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

	| aContainerElement |

	aContainerElement := BlElement new.
	aContainerElement
		layout: BlFrameLayout new;
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self taskElement: aContainerElement.
	^ aBlock value: aContainerElement
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
GtPhlowTaskItView >> displayProgressIn: aContainerElement [
	"Conditionally display the progress element in the supplied container.
	This must be executed by the UI process"

	| aProgressElement |

	aContainerElement hasChildren ifTrue: [ ^self ].

	aProgressElement := BrProgress new 
		fixedLabel: ('Rendering...' asRopedText 
			foreground: Color gray lighter);
		look: BrGlamorousProgressWithLabelAndBarLook;
		constraintsDo: [ :c | 
			c frame horizontal weight: 0.5.
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
		
	aContainerElement 
		addChild: aProgressElement.
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
GtPhlowTaskItView >> make: anElement onlyChildOf: containerElement [
	"Replace any children of containerElement with anElement"

	containerElement enqueueTask: (BlTaskAction new action: [
		containerElement 
			removeChildren;
			addChild: anElement. ]).
]

{ #category : #'instance creation' }
GtPhlowTaskItView >> newUpdateCommandWithContainer: aContainerElement [
	| aCommand aMethodName |
	aCommand := [ self originalElementDo: [ :anElement |
			self make: anElement onlyChildOf: aContainerElement ] ] asBlTktCommand.
	aMethodName := self definingMethod
		ifNil: [ '<unknown>' ]
		ifNotNil: [ :aMethod | aMethod fullName asString ].
	aCommand name: 'Phlow view: ', aMethodName.
	^ aCommand
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
GtPhlowTaskItView >> scheduleCommand: aCommand [
	^ BlTktWorkerProvider highUICPUBoundPool future: aCommand asBlTktTerminableCommand asBlTktLoggingCommand
]

{ #category : #private }
GtPhlowTaskItView >> taskElement: aContainerElement [

	aContainerElement enqueueTask: (BlTaskAction new action: [
		| aCommand aFuture |
		aCommand := self newUpdateCommandWithContainer: aContainerElement.
		aFuture := self scheduleCommand: aCommand.
		aFuture onFailureDo: [ :anException | 
				| anErrorElement |
				anErrorElement := self errorElementFrom: anException.
				self make: anErrorElement onlyChildOf: aContainerElement ] ]).
	
	aContainerElement enqueueTask: (BlTaskAction new action: [ 
		BlTaskAtQueue default
			schedule: [ self displayProgressIn: aContainerElement ]
			at: BlTime real now + 300 milliSeconds ]).
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
