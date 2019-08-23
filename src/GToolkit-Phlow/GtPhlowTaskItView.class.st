Class {
	#name : #GtPhlowTaskItView,
	#superclass : #GtPhlowProtoView,
	#instVars : [
		'originalView'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowTaskItView >> asElementDo: aBlock [

	| containerElement |

	containerElement := BlElement new.
	containerElement
		layout: BlFrameLayout new;
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self taskElement: containerElement.
	^ aBlock value: containerElement
]

{ #category : #converting }
GtPhlowTaskItView >> asTaskItView [
	^ self
]

{ #category : #accessing }
GtPhlowTaskItView >> definingMethod [
	"Get view defining method.
	It is a method where a view is defined."
	<return: #RGMethodDefinition>
	^ self originalView definingMethod
]

{ #category : #accessing }
GtPhlowTaskItView >> definingMethod: aRGMethodDefinition [
	"Set view defining method.
	It is a method where a view is defined."
	^ self originalView definingMethod: aRGMethodDefinition
]

{ #category : #private }
GtPhlowTaskItView >> displayProgressIn: containerElement [
	"Conditionally display the progress element in the supplied container.
	This must be executed by the UI process"

	| progressElement repeatedTask rollingGradient |

	containerElement hasChildren ifTrue: [ ^self ].

	progressElement := self newProgressElement.
	rollingGradient := BlRollingLinearGradientBackgroundCommand new
				element: progressElement children first.
	containerElement addChild: progressElement.
	rollingGradient execute.
	repeatedTask := BlRepeatedTaskAction new.
	repeatedTask 
		delay: 200 milliSeconds;
		action: rollingGradient.
	progressElement enqueueTask: repeatedTask.

]

{ #category : #private }
GtPhlowTaskItView >> errorElementFrom: anException [
	anException freeze.
	^ GtPhlowViewWithError new
		error: anException;
		asElementDo: [ :errorElement | errorElement ]
]

{ #category : #converting }
GtPhlowTaskItView >> ifItHasContent: aBlock [
	self originalView ifItHasContent: aBlock
]

{ #category : #initialization }
GtPhlowTaskItView >> initialize [
	super initialize.
	self originalView: self empty.
]

{ #category : #private }
GtPhlowTaskItView >> installNotificationsOnTask: aTask [
	aTask
		onNotification: BlExactProgress
		enqueueAction: [ :aProgress | 
			aTask element
				childNamed: #progressText
				ifFound: [ :theTextElement | 
					theTextElement
						text:
							(self
								notificationText:
									aProgress messageText asString , ' '
										, aProgress percentage rounded asString , '%') ]
				ifNone: [ "do nothing" ] ].
	aTask
		onNotification: BlSomeProgress
		enqueueAction: [ :aProgress | 
			aTask element
				childNamed: #progressText
				ifFound: [ :theTextElement | 
					theTextElement
						text:
							(self
								notificationText:
									aProgress messageText asString , ' '
										, aProgress amount rounded asString) ]
				ifNone: [ "do nothing" ] ].
	aTask
		onNotification: BlAnyProgress
		enqueueAction: [ :aProgress | 
			aTask element
				childNamed: #progressText
				ifFound: [ :theTextElement | 
					theTextElement
						text: (self notificationText: aProgress messageText asString) ]
				ifNone: [ "do nothing" ] ]
]

{ #category : #private }
GtPhlowTaskItView >> make: anElement onlyChildOf: containerElement [
	"Replace any children of containerElement with anElement"

	containerElement enqueueTask: (BlTaskAction new action: [
		containerElement 
			removeChildren;
			addChild: anElement. ]).
]

{ #category : #private }
GtPhlowTaskItView >> newProgressElement [
	| aProgressElement |
	aProgressElement := BlElement new.
	aProgressElement
		layout: BlFrameLayout new;
		addChild:
			(BlTextElement new
				text: (self notificationText: 'Rendering...');
				geometry: (BlRectangle cornerRadius: 7);
				padding:
					(BlInsets
						top: 10
						left: 20
						bottom: 10
						right: 20);
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ])
			as: #progressText.
	aProgressElement
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	^ aProgressElement
]

{ #category : #private }
GtPhlowTaskItView >> notificationText: aStringOrRope [
	^ aStringOrRope asRopedText 
			foreground: Color gray lighter;
			fontSize: 12
]

{ #category : #private }
GtPhlowTaskItView >> originalElementDo: anAsElementBlock [

	self originalView asElementDo: anAsElementBlock.

]

{ #category : #accessing }
GtPhlowTaskItView >> originalView [
	<return: #GtPhlowView>
	^ originalView
]

{ #category : #accessing }
GtPhlowTaskItView >> originalView: aView [
	self 
		assert: [ aView notNil ]
		description: [ 'Original view must be non-nil' ].
	originalView := aView
]

{ #category : #accessing }
GtPhlowTaskItView >> priority [
	"Get view priority defining a view order.
	Lower priority is supposed to be displayed to the left."
	<return: #Number>
	^ self originalView priority
]

{ #category : #accessing }
GtPhlowTaskItView >> priority: aNumber [
	"Set view priority defining a view order.
	Lower priority is supposed to be displayed to the left."
	^ self originalView priority: aNumber
]

{ #category : #private }
GtPhlowTaskItView >> taskElement: containerElement [

	| aCommand methodName aTask |

	aCommand := [ self originalElementDo: [ :anElement |
			anElement forceLayout.
			self make: anElement onlyChildOf: containerElement ] ] asBlTktCommand.
	methodName := self definingMethod
		ifNil: [ '<unknown>' ]
		ifNotNil: [ :aMethod | aMethod fullName asString ].
	aCommand name: 'Phlow view: ', methodName.
	aTask := BlNotificableTaskItAction new 
		action: aCommand;
		element: containerElement;
		yourself.
	self installNotificationsOnTask: aTask.
	aTask onFailureDo: [ :anException | 
			| anErrorElement |
			anErrorElement := self errorElementFrom: anException.
			self make: anErrorElement onlyChildOf: containerElement ].
	aTask onRunEnqueueTask: (BlTaskAction new action: [ 
		BlTaskAtQueue default
			schedule: [ self displayProgressIn: containerElement ]
			at: BlTime real now + 300 milliSeconds ]).
	containerElement enqueueTask: aTask
]

{ #category : #accessing }
GtPhlowTaskItView >> title [
	"Return view title, a user friendly view name.
	It is supposed to be a short name"
	^ self originalView title
]

{ #category : #accessing }
GtPhlowTaskItView >> title: aString [
	"Set view title, a user friendly view name.
	It is supposed to be a short name"
	^ self originalView title: aString
]
