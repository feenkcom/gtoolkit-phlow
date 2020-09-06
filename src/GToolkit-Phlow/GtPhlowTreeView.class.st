Class {
	#name : #GtPhlowTreeView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowErrorTolerantCell - {#performBlock:onException:} + TGtPhlowItemText',
	#classTraits : 'TGtPhlowErrorTolerantCell classTrait + TGtPhlowItemText classTrait',
	#instVars : [
		'itemsBuilder',
		'itemStencil',
		'transformation',
		'childrenBuilder',
		'expandUpTo',
		'itemTypeStencil',
		'itemDataBinder'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowTreeView >> asElementDo: aBlock [
	| theItems aTree |
	
	theItems := self itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	
	aTree := self elementClass new.

	self 
		performBlock: [ aTree items: theItems children: self childrenBuilder ]
		onExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].

	aTree addEventHandler: (GtPhlowListToSelectHandler new transformation: [ :aNode | self send value: aNode value ]).
	aTree constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].

	aTree
		nodeType: self itemTypeStencil;
		nodeStencil: self itemStencil;
		nodeDataBinder: self itemDataBinder.

	"aTree column
		title: 'Item';
		stencil: [ :anItemObject :index | 
			| itemElement |
			itemElement := self itemStencil value: anItemObject.
			itemElement padding: (BlInsets top: 3 left: 0 bottom: 3 right: 0) ]."
		
	self expandTree: aTree.
	self beViewElement: aTree.

	^ aBlock value: aTree
]

{ #category : #'api - scripting' }
GtPhlowTreeView >> children: anObject [
	childrenBuilder := anObject
]

{ #category : #'private - accessing' }
GtPhlowTreeView >> childrenBuilder [
	^ childrenBuilder
]

{ #category : #'api - scripting tree node expansion' }
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

{ #category : #'private - accessing' }
GtPhlowTreeView >> elementClass [
	^ BrSimpleTree
]

{ #category : #'api - scripting tree node expansion' }
GtPhlowTreeView >> expandAll [
	self expandUpTo: 20
]

{ #category : #'api - scripting tree node expansion' }
GtPhlowTreeView >> expandOneLevel [
	self expandUpTo: 1
]

{ #category : #'private - building' }
GtPhlowTreeView >> expandTree: aBrColumnedTree [ 
	expandUpTo ifNil: [ ^ self ].
	aBrColumnedTree expandUpTo: expandUpTo
]

{ #category : #'api - scripting tree node expansion' }
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
	itemsBuilder := [ { } ].
	childrenBuilder := [ :each | { } ].
	transformation := [ :aValue | "by default there is no transformation" aValue ].
	self itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | anItemTypeFactory default ].
	self itemText: [ :anObject | anObject gtDisplayText ].
]

{ #category : #'private - testing' }
GtPhlowTreeView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : #'private - accessing' }
GtPhlowTreeView >> itemDataBinder [
	"Return a stencil that is used to bind data to a given item element"

	^ itemDataBinder
]

{ #category : #'api - scripting' }
GtPhlowTreeView >> itemDataBinder: aBrTreeNodeDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anElement :anItem :anIndex | ]"

	itemDataBinder := self errorTreatedCellDataBinderFor: aBrTreeNodeDataBinderOrBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowTreeView >> itemElement: anObject [
	self deprecated: 'itemElement: is not supported'.
	Error signal: 'itemElement: is not supported'
]

{ #category : #'scripting - deprecated' }
GtPhlowTreeView >> itemFormat: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemText: instead.'
		transformWith: '`@receiver itemFormat: `@statements' -> '`@receiver itemText: `@statements'.
	self itemText: aBlockOrSymbol
]

{ #category : #'private - accessing' }
GtPhlowTreeView >> itemStencil [
	^ itemStencil
]

{ #category : #'api - scripting' }
GtPhlowTreeView >> itemStencil: aBrListItemElementStencilBuilderOrBlock [
	"A node element stencil can be a #value-able of the form [ :aNodeType | ]"

	itemStencil := self errorTreatedCellStencilFor: aBrListItemElementStencilBuilderOrBlock
]

{ #category : #'api - scripting' }
GtPhlowTreeView >> itemType: aBrTreeNodeTypeStencilBuilderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemTypeFactory :anItem :anIndex | ].
	anItemTypeFactory is a ${class:BrListItemType class}$ "
	
	itemTypeStencil := self errorTreatedCellTypeFor: aBrTreeNodeTypeStencilBuilderOrBlock
]

{ #category : #'private - accessing' }
GtPhlowTreeView >> itemTypeStencil [
	"Return a stencil that is used to create an item type of a given item object"

	^ itemTypeStencil
]

{ #category : #'api - scripting' }
GtPhlowTreeView >> items: anObject [
	itemsBuilder := anObject
]

{ #category : #'private - accessing' }
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

{ #category : #'api - scripting' }
GtPhlowTreeView >> send [
	^ transformation
]

{ #category : #'api - scripting' }
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

{ #category : #'api - scripting' }
GtPhlowTreeView >> stencil: aBlock [
	"I am a part of the `toy` api. It is inefficient to use me because I always create a new
	element for each new row which may be expensive. It is much better to split it in two (or three)
	steps:
		- item element creation using #nodeStencil: (the items are reused when they go out of the viewport)
		- data binding using #nodeDataBinder: (to update just a part of the reused item element)
	A stencil builder can be a value-able of the form [ :aRowValue :anIndex | ]"
	
	self itemStencil: [ :aNodeType | 
		BlElement new
			labeled: 'Wrapper';
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ] ].

	self itemDataBinder: [ :aWrapperElement :anItemObject :aTreeNode |
		| aNodeStencil |
		aNodeStencil := aBlock glamourValueWithArgs: { anItemObject. aTreeNode indexInTree }.
		aWrapperElement
			removeChildren;
			addChild: aNodeStencil asElement ]
]

{ #category : #'api - updating' }
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
