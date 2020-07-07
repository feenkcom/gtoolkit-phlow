Class {
	#name : #GtPhlowListView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'itemsBuilder',
		'itemStencil',
		'transformation',
		'itemDataBinder',
		'itemTypeStencil'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #converting }
GtPhlowListView >> asElementDo: aBlock [
	| theItems aList |
	
	theItems := self itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	
	aList := self elementClass new items: theItems.
	aList addEventHandler: (GtPhlowListToSelectHandler new transformation: self send).
	aList constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].

	aList stencil: [ :eachNode :index | 
		| itemElement |
		itemElement := self performBlock: [ self itemStencil value: eachNode ].
		itemElement constraintsDo: [ :c | 
			c horizontal matchParent. 
			c padding: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ] ].

	self beViewElement: aList.
	
	^ aBlock value: aList
]

{ #category : #'private - building' }
GtPhlowListView >> buildTextElementFor: aString [
	^ BrLabel new
		look: BrGlamorousListLabelLook;
		text: aString.
]

{ #category : #copying }
GtPhlowListView >> copySendFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowListView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #defaults }
GtPhlowListView >> elementClass [
	^ BrSimpleList
]

{ #category : #'scripting - deprecated' }
GtPhlowListView >> format: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemFormat: instead.'
		transformWith: '`@receiver format: `@statements' -> '`@receiver itemFormat: `@statements'.
	self itemFormat: aBlockOrSymbol
]

{ #category : #initialization }
GtPhlowListView >> initialize [
	super initialize.
	itemStencil := [ :anObject | 
		self buildTextElementFor: anObject gtDisplayString ].
	itemsBuilder := [ { } ].
	transformation := [ :aValue | "by default there is no transformation" aValue ].
]

{ #category : #testing }
GtPhlowListView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : #'scripting - deprecated' }
GtPhlowListView >> itemElement: anObject [
	self 
		deprecated: 'Please use #itemStencil: instead.'
		transformWith: '`@receiver itemElement: `@statements' -> '`@receiver itemStencil: `@statements'.
	itemStencil := anObject
]

{ #category : #'scripting - utils' }
GtPhlowListView >> itemFormat: aBlockOrSymbol [
	self itemStencil: [ :anObject |
		self buildTextElementFor: (aBlockOrSymbol phlowValue: anObject) ]
]

{ #category : #accessing }
GtPhlowListView >> itemStencil [
	^ itemStencil
]

{ #category : #accessing }
GtPhlowListView >> itemStencil: anElementStencil [
	itemStencil := anElementStencil
]

{ #category : #accessing }
GtPhlowListView >> items: anObject [
	itemsBuilder := anObject
]

{ #category : #accessing }
GtPhlowListView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : #'private - accessing' }
GtPhlowListView >> itemsOnExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ self itemsBuilder value ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #accessing }
GtPhlowListView >> send [
	^ transformation
]

{ #category : #accessing }
GtPhlowListView >> send: aBlock [
	self
		assert: [ aBlock notNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	aBlock isSymbol ifTrue: [ 
		self 
			assert: [ aBlock isUnary ]
			description: [ 'Send transformation symbol must be unary' ].
		transformation := [ :obj | aBlock value: obj ].
		^self ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
	transformation := aBlock
]

{ #category : #updating }
GtPhlowListView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"

	| aParent |
	(self isExpectedElement: aCurrentElement)
		ifFalse: [ ^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ | theItems |
		theItems := self itemsOnExceptionErrorElement: [ :anErrorElement | 
			^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		self enqueueAction: [ aCurrentElement items: theItems ] in: aCurrentElement ]
]
