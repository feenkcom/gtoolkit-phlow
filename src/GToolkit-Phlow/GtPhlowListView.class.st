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

{ #category : #'api - converting' }
GtPhlowListView >> asElementDo: aBlock [
	| theItems aList |
	
	theItems := self itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	
	aList := self elementClass new items: theItems.
	aList addEventHandler: (GtPhlowListToSelectHandler new transformation: self send).
	aList constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].

	aList
		itemStencil: self itemElementStencil;
		itemDataBinder: self itemDataBinder;
		itemType: self itemTypeStencil.

	self beViewElement: aList.
	
	^ aBlock value: aList
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
	self items: [ { } ].
	self itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | anItemTypeFactory default ].
	self itemText: [ :aValue | aValue ].
	transformation := [ :aValue | "by default there is no transformation" aValue ].
]

{ #category : #testing }
GtPhlowListView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : #'private - accessing' }
GtPhlowListView >> itemDataBinder [
	"Return a stencil that is used to bind data to a given item element"
	<return: #BrListItemDataBinder>

	^ itemDataBinder
]

{ #category : #'api - scripting' }
GtPhlowListView >> itemDataBinder: aBrListItemDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemElement :anItemObject :anItemIndex | ]"
	itemDataBinder := aBrListItemDataBinderOrBlock asStencilBuilder: BrListItemDataBinder.
]

{ #category : #'scripting - deprecated' }
GtPhlowListView >> itemElement: anObject [
	self 
		deprecated: 'Please use #itemStencil: instead.'
		transformWith: '`@receiver itemElement: `@statements' -> '`@receiver itemStencil: `@statements'.
	itemStencil := anObject
]

{ #category : #'private - accessing' }
GtPhlowListView >> itemElementStencil [
	^ itemStencil
]

{ #category : #'api - scripting' }
GtPhlowListView >> itemFormat: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemText: instead.'
		transformWith: '`@receiver itemFormat: `@statements' -> '`@receiver itemText: `@statements'.
	self itemText: aBlockOrSymbol
]

{ #category : #'api - scripting' }
GtPhlowListView >> itemStencil: aBrListItemElementStencilBuilderOrBlock [
	"An item element stencil can be a #value-able of the form [ :anItemType :aListWidget | ]"

	itemStencil := aBrListItemElementStencilBuilderOrBlock asStencilBuilder: BrListItemElementStencilBuilder.
]

{ #category : #'api - scripting' }
GtPhlowListView >> itemText: aBlockOrSymbol [
	self itemStencil: [ self newItemLabel ].
	self itemDataBinder: [ :anElement :anItem :anIndex |
		self 
			performBlock: [ 
				| aText aLabel |
				aText := aBlockOrSymbol phlowValue: anItem withEnoughArguments: { anItem. anIndex. anElement }.
				aLabel := (anElement class = BrLabel)
					ifTrue: [ anElement ] 
					ifFalse: [ self newItemLabel ].
				aLabel text: aText ]
			onException: [ :anException | 
				anException asDebuggableElement 
					vFitContent;
					padding: self newItemElementPadding ] ]
]

{ #category : #'api - scripting' }
GtPhlowListView >> itemType: aBrListItemTypeStencilBuilderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemTypeFactory :anItemObject :anItemIndex | ].
	==anItemTypeFactory== is a ${class:BrListItemType class}$"

	itemTypeStencil := aBrListItemTypeStencilBuilderOrBlock asStencilBuilder: BrListItemTypeStencilBuilder.
]

{ #category : #'private - accessing' }
GtPhlowListView >> itemTypeStencil [
	"Return a stencil that is used to create an item type of a given item object"
	<return: #BrListItemTypeStencilBuilder>

	^ itemTypeStencil
]

{ #category : #'api - items' }
GtPhlowListView >> items: anObject [
	itemsBuilder := anObject
]

{ #category : #'private - accessing' }
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

{ #category : #'private - building' }
GtPhlowListView >> newItemElementPadding [
	^ BlInsets
		top: 3
		left: 10
		bottom: 3
		right: 10
]

{ #category : #'private - building' }
GtPhlowListView >> newItemLabel [
	^ BrLabel new
		look: BrGlamorousListLabelLook;
		hMatchParent;
		vFitContent;
		padding: self newItemElementPadding
]

{ #category : #'private - accessing' }
GtPhlowListView >> send [
	^ transformation
]

{ #category : #'api - scripting' }
GtPhlowListView >> send: aBlock [
	"Define what object should be displayed on selection and/or spawn item (object) request"
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

{ #category : #'api - scripting' }
GtPhlowListView >> stencil: aBrListRowStencilBuilder [
	"I am a part of the `toy` api. It is inefficient to use me because I always create a new
	element for each new row which may be expensive. It is much better to split it in two (or three)
	steps:
		- item element creation using #itemStencil: (the items are reused when they go out of the viewport)
		- data binding using #itemDataBinder: (to update just a part of the reused item element)
	A stencil builder can be a value-able of the form [ :aRowValue :anIndex :aListWidget | ]"
	| listRowStencil |

	self itemType: (BrListItemTypeStencilBuilder new).

	listRowStencil := aBrListRowStencilBuilder asStencilBuilder: BrListRowStencilBuilder.
	self itemDataBinder: [ :anItemElement :anItemObject :anItemPosition |
		| aRowStencil |

		aRowStencil := listRowStencil
			listElement: self;
			rowValue: anItemObject;
			rowIndex: anItemPosition;
			build.
		
		listRowStencil reset.
		
		aRowStencil ]
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
