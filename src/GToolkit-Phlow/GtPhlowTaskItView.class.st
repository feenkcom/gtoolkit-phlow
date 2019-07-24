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
	| aProgressElement |
	aProgressElement := self taskElement: aBlock.
	^ aBlock value: aProgressElement
]

{ #category : #converting }
GtPhlowTaskItView >> asTaskItView [
	^ self
]

{ #category : #private }
GtPhlowTaskItView >> attach: aComputedElement toParentOf: aProgressElement [
	| aParent |
	self 
		assert: [ aProgressElement hasParent ]
		description: [ 'Progress element must have a parent' ].
	self 
		assert: [ aComputedElement notNil ]
		description: [ 'Computed element must be non-nil' ].
	aParent := aProgressElement parent.
	aProgressElement removeFromParent.
	aParent addChild: aComputedElement.
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
	| anElementToDisplay |
	anElementToDisplay := self originalView asElementDo: anAsElementBlock.
	anElementToDisplay forceLayout.
	^ anElementToDisplay
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
GtPhlowTaskItView >> taskElement: anAsElementBlock [
	| aProgressElement aCommand aTask |
	aProgressElement := self newProgressElement.
	aCommand := [ self originalElementDo: anAsElementBlock ] asBlTktCommand.
	self definingMethod
		ifNotNil: [ :aMethod | 
			aCommand name: 'Phlow view: ' , aMethod fullName asString ].
	aTask := BlCancellableTaskItAction new.
	aTask action: aCommand.
	self installNotificationsOnTask: aTask.
	aTask
		onRunEnqueueRepeatedAction:
			(BlRollingLinearGradientBackgroundCommand new
				element: aProgressElement children first).
	aTask
		onSuccessEnqueueAction: [ :aComputedElement | 
			self attach: aComputedElement toParentOf: aProgressElement ].
	aTask
		onFailureEnqueueAction: [ :anException | 
			| anErrorElement |
			anErrorElement := self errorElementFrom: anException.
			self attach: anErrorElement toParentOf: aProgressElement ].
	aProgressElement enqueueTask: aTask.
	^ aProgressElement
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
