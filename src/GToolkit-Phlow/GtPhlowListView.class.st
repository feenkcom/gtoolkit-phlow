"
I represent a simple list view.
I create {{gtClass:BrSimpleList}}  to display items. 
1. # Examples 

The following object displays several examples. You can `ALT+CLICK` on tab names to display their definitions: {{gtExample:GtPhlowListViewExamples>>#myself|noCode=true}} 
 


"
Class {
	#name : 'GtPhlowListView',
	#superclass : 'GtPhlowViewDecorator',
	#traits : 'TGtPhlowErrorTolerantCell - {#performBlock:onException:} + TGtPhlowItemText + TGtPhlowSendTransformable',
	#classTraits : 'TGtPhlowErrorTolerantCell classTrait + TGtPhlowItemText classTrait + TGtPhlowSendTransformable classTrait',
	#instVars : [
		'itemsBuilder',
		'itemStencil',
		'itemDataBinder',
		'itemTypeStencil'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : 'api - converting' }
GtPhlowListView >> asElementDo: aBlock [
	| theItems aList |
	theItems := self
		itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	aList := self elementClass new items: theItems.
	aList
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation).
	aList
		constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].
	aList
		itemStencil: self itemElementStencil;
		itemDataBinder: self itemDataBinder;
		itemType: self itemTypeStencil.
	self beViewElement: aList.
	^ aBlock value: aList
]

{ #category : 'copying' }
GtPhlowListView >> copyTransformationFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
]

{ #category : 'scripting - deprecated' }
GtPhlowListView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : 'defaults' }
GtPhlowListView >> elementClass [
	^ BrSimpleList
]

{ #category : 'scripting - deprecated' }
GtPhlowListView >> format: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemFormat: instead.'
		transformWith: '`@receiver format: `@statements' -> '`@receiver itemFormat: `@statements'.
	self itemFormat: aBlockOrSymbol
]

{ #category : 'initialization' }
GtPhlowListView >> initialize [
	super initialize.
	self items: [ { } ].
	self itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | anItemTypeFactory default ].
	self itemText: [ :aValue | aValue ].
	self transformation: self defaultTransformation.
]

{ #category : 'private - testing' }
GtPhlowListView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : 'private - accessing' }
GtPhlowListView >> itemDataBinder [
	"Return a stencil that is used to bind data to a given item element"

	^ itemDataBinder
]

{ #category : 'api - scripting' }
GtPhlowListView >> itemDataBinder: aBrListItemDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemElement :anItemObject :anItemIndex | ]"
	itemDataBinder := self errorTreatedCellDataBinderFor: aBrListItemDataBinderOrBlock.
]

{ #category : 'scripting - deprecated' }
GtPhlowListView >> itemElement: anObject [
	self 
		deprecated: 'Please use #itemStencil: instead.'
		transformWith: '`@receiver itemElement: `@statements' -> '`@receiver itemStencil: `@statements'.
	itemStencil := anObject
]

{ #category : 'private - accessing' }
GtPhlowListView >> itemElementStencil [
	^ itemStencil
]

{ #category : 'scripting - deprecated' }
GtPhlowListView >> itemFormat: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemText: instead.'
		transformWith: '`@receiver itemFormat: `@statements' -> '`@receiver itemText: `@statements'.
	self itemText: aBlockOrSymbol
]

{ #category : 'api - scripting' }
GtPhlowListView >> itemStencil: aBrListItemElementStencilBuilderOrBlock [
	"An item element stencil can be a #value-able of the form [ :anItemType | ]"

	itemStencil := self errorTreatedCellStencilFor: aBrListItemElementStencilBuilderOrBlock.
]

{ #category : 'api - scripting' }
GtPhlowListView >> itemType: aBrListItemTypeStencilBuilderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemTypeFactory :anItemObject :anItemIndex | ].
	==anItemTypeFactory== is a ${class:BrListItemType class}$"

	itemTypeStencil := self errorTreatedCellTypeFor: aBrListItemTypeStencilBuilderOrBlock.
]

{ #category : 'private - accessing' }
GtPhlowListView >> itemTypeStencil [
	"Return a stencil that is used to create an item type of a given item object"

	^ itemTypeStencil
]

{ #category : 'api - scripting' }
GtPhlowListView >> items: anObject [
	itemsBuilder := anObject
]

{ #category : 'private - accessing' }
GtPhlowListView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : 'private - accessing' }
GtPhlowListView >> itemsOnExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ self itemsBuilder value ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : 'private - building' }
GtPhlowListView >> newItemLabel [
	^ BrLabel new
		aptitude: BrGlamorousListLabelAptitude + BrGlamorousListItemAptitude;
		alignCenterLeft;
		hMatchParent;
		vFitContent
]

{ #category : 'api - scripting' }
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

{ #category : 'api - updating' }
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
