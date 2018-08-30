Class {
	#name : #GtPhlowTaskItView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'asElementBlock'
	],
	#category : #'GToolkit-Phlow'
}

{ #category : #accessing }
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
GtPhlowTaskItView >> originalElementDo: anAsElementBlock [
	^ self originalView asElementDo: anAsElementBlock
]

{ #category : #private }
GtPhlowTaskItView >> taskElement: anAsElementBlock [
	| aProgressElement aTask |
	aProgressElement := BlElement new.
	aProgressElement 
		layout: BlFrameLayout new;
		addChild: (BlTextElement new 
			text: ('Rendering...' asRopedText 
				foreground: Color gray lighter;
				fontSize: 21);
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ]).
	aProgressElement
		background: BlTransparentBackground new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aTask := BlCancellableTaskItAction new.
	aTask action: [ self originalElementDo: anAsElementBlock ].
	aTask onRunEnqueueRepeatedAction: (BlRollingLinearGradientBackgroundCommand new element: aProgressElement).
	aTask onSuccessEnqueueAction: [ :aComputedElement | 
		self attach: aComputedElement toParentOf: aProgressElement ].
	aTask onFailureEnqueueAction: [ :anException | 
		| anErrorElement |
		anErrorElement := self errorElementFrom: anException.
		self attach: anErrorElement toParentOf: aProgressElement ].
	aProgressElement enqueueTask: aTask.
	^ aProgressElement
]
