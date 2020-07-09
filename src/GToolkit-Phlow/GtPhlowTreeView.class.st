Class {
	#name : #GtPhlowTreeView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'itemsBuilder',
		'itemStencil',
		'transformation',
		'childrenBuilder',
		'expandUpTo'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #converting }
GtPhlowTreeView >> asElementDo: aBlock [
	| theItems aTree |
	
	theItems := self itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	
	aTree := self elementClass new.

	self 
		performBlock: [ aTree items: theItems children: self childrenBuilder ]
		onExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].

	aTree addEventHandler: (GtPhlowListToSelectHandler new transformation: [ :aNode | self send value: aNode value ]).
	aTree constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].
	aTree rowStencil: (BrColumnedTreeRowStencilBuilder new
		cellSpacing: 2;
		padding: (BlInsets left: 0)).

	aTree column
		title: 'Item';
		stencil: [ :aNode :index | 
			| itemElement |
			itemElement := self itemStencil value: aNode value.
			itemElement padding: (BlInsets top: 3 left: 0 bottom: 3 right: 0) ].

	self expandTree: aTree.
	self beViewElement: aTree.

	^ aBlock value: aTree
]

{ #category : #'private - building' }
GtPhlowTreeView >> buildTextElementFor: aString [
	^ BrLabel new
		look: BrGlamorousListLabelLook;
		text: aString.
]

{ #category : #accessing }
GtPhlowTreeView >> children: anObject [
	childrenBuilder := anObject
]

{ #category : #accessing }
GtPhlowTreeView >> childrenBuilder [
	^ childrenBuilder
]

{ #category : #'expanding-collapsing' }
GtPhlowTreeView >> collapseAll [
	expandUpTo := nil.
]

{ #category : #copying }
GtPhlowTreeView >> copySendFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowTreeView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #accessing }
GtPhlowTreeView >> elementClass [
	^ BrSimpleTree
]

{ #category : #'expanding-collapsing' }
GtPhlowTreeView >> expandAll [
	self expandUpTo: 20
]

{ #category : #'expanding-collapsing' }
GtPhlowTreeView >> expandOneLevel [
	self expandUpTo: 1
]

{ #category : #'private - actions' }
GtPhlowTreeView >> expandTree: aBrColumnedTree [ 
	expandUpTo ifNil: [ ^ self ].
	aBrColumnedTree expandUpTo: expandUpTo
]

{ #category : #'expanding-collapsing' }
GtPhlowTreeView >> expandUpTo: aLevelIndex [
	self 
		assert: [ aLevelIndex isInteger and: [ aLevelIndex > 0 ] ] 
		description: [ 'Level index must be a natural number' ].
	expandUpTo := aLevelIndex.
]

{ #category : #'scripting - deprecated' }
GtPhlowTreeView >> format: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemFormat: instead.'
		transformWith: '`@receiver format: `@statements' -> '`@receiver itemFormat: `@statements'.
	self itemFormat: aBlockOrSymbol
]

{ #category : #initialization }
GtPhlowTreeView >> initialize [
	super initialize.
	itemStencil := [ :anObject | 
		self buildTextElementFor: anObject gtDisplayText ].
	itemsBuilder := [ { } ].
	childrenBuilder := [ :each | { } ].
	transformation := [ :aValue | "by default there is no transformation" aValue ].
]

{ #category : #testing }
GtPhlowTreeView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : #'scripting - deprecated' }
GtPhlowTreeView >> itemElement: anObject [
	self 
		deprecated: 'Please use #itemStencil: instead.'
		transformWith: '`@receiver itemElement: `@statements' -> '`@receiver itemStencil: `@statements'.
	itemStencil := anObject
]

{ #category : #'scripting - utils' }
GtPhlowTreeView >> itemFormat: aBlockOrSymbol [
	self itemStencil: [ :anObject |
		self buildTextElementFor: (aBlockOrSymbol phlowValue: anObject) ]
]

{ #category : #accessing }
GtPhlowTreeView >> itemStencil [
	^ itemStencil
]

{ #category : #accessing }
GtPhlowTreeView >> itemStencil: anElementStencil [
	itemStencil := anElementStencil
]

{ #category : #accessing }
GtPhlowTreeView >> items: anObject [
	itemsBuilder := anObject
]

{ #category : #accessing }
GtPhlowTreeView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : #'private - accessing' }
GtPhlowTreeView >> itemsOnExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ self itemsBuilder value ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #accessing }
GtPhlowTreeView >> send [
	^ transformation
]

{ #category : #accessing }
GtPhlowTreeView >> send: aBlock [
	self
		assert: [ aBlock notNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	aBlock isSymbol ifTrue: [ 
		self 
			assert: [ aBlock isUnary ]
			description: [ 'Send transformation symbol must be unary' ].
		transformation := [ :obj :event | aBlock value: obj ].
		^self ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
	transformation := aBlock
]

{ #category : #updating }
GtPhlowTreeView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"
	| aParent |

	(self isExpectedElement: aCurrentElement) ifFalse: [
		^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		| theItems |
		theItems := self itemsOnExceptionErrorElement: [ :anErrorElement | 
			^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		self 
			enqueueAction: [ 
				aCurrentElement items: theItems children: self childrenBuilder.
				self expandTree: aCurrentElement. ] 
			in: aCurrentElement ]
]
