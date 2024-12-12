"
I represent a simple list view.
I create {{gtClass:BrSimpleList}}  to display items. 
1. # Examples 

The following object displays several examples. You can `ALT+CLICK` on tab names to display their definitions: {{gtExample:GtPhlowListViewExamples>>#myself|noCode=true}} 
 


"
Class {
	#name : #GtPhlowListView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowSendTransformable + TGtPhlowWithContextMenu',
	#classTraits : 'TGtPhlowSendTransformable classTrait + TGtPhlowWithContextMenu classTrait',
	#instVars : [
		'itemsProviderComputation',
		'itemComputation',
		'itemStencil',
		'itemDataBinder',
		'itemTypeStencil',
		'itemId',
		'multipleSelectionEnabled'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowListView >> asElementDo: aBlock [
	| aList itemsProvider |

	itemsProvider := self itemsProviderOnExceptionErrorElement: [ :anElement | 
		^ aBlock value: anElement ].
	
	aList := self elementClass new 
		itemsProvider: itemsProvider.
	aList
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation).
	aList
		constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].
	aList
		itemStencil: self newDecoratedItemStencil;
		itemDataBinder: self newDecoratedItemDataBinder;
		itemType: self newDecoratedItemTypeStencil.
	itemId ifNotNil: [
		aList itemId: itemId ].
		
	self hasMultipleSelection ifTrue: [
		aList aptitude: BrMultiListAptitude
	].
		
	self beViewElement: aList.
	^ aBlock value: aList
]

{ #category : #copying }
GtPhlowListView >> copyTransformationFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
]

{ #category : #defaults }
GtPhlowListView >> defaultItemComputation [
	^ [ :eachItem :eachRowIndex | eachItem ]
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

{ #category : #accessing }
GtPhlowListView >> gtViewContextMenuActionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Context menu actions';
		items: [ self contextMenuActions ];
		column: 'Name' text: #name;
		column: 'Action' text: #action;
		column: 'Filter' text: [ :anAction | anAction filter ifNil: [ '' ] ]
]

{ #category : #'api - converting' }
GtPhlowListView >> hasMultipleSelection [
	^ multipleSelectionEnabled
]

{ #category : #initialization }
GtPhlowListView >> initialize [
	super initialize.
	self items: [ { } ].
	self itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | 
		anItemTypeFactory default ].
	self itemText: [ :aValue | aValue ].
	self transformation: self defaultTransformation.

	itemComputation := self defaultItemComputation.

	multipleSelectionEnabled := false
]

{ #category : #'private - testing' }
GtPhlowListView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : #'private - accessing' }
GtPhlowListView >> itemComputation [
	^ itemComputation
]

{ #category : #'private - accessing' }
GtPhlowListView >> itemDataBinder [
	"Return a stencil that is used to bind data to a given item element"

	^ itemDataBinder
]

{ #category : #'api - configuration' }
GtPhlowListView >> itemDataBinder: aBrListItemDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemElement :anItemObject :anItemIndex | ]"

	itemDataBinder := aBrListItemDataBinderOrBlock asStencilBuilder: BrListItemDataBinder
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

{ #category : #'scripting - deprecated' }
GtPhlowListView >> itemFormat: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemText: instead.'
		transformWith: '`@receiver itemFormat: `@statements' -> '`@receiver itemText: `@statements'.
	self itemText: aBlockOrSymbol
]

{ #category : #'api - configuration' }
GtPhlowListView >> itemId: aBrListItemIdStencilBuilderOrBlock [
		"An item type stencil can be a #value-able of the form [ :anItemObject :anItemIndex | ]"

	itemId := aBrListItemIdStencilBuilderOrBlock 
]

{ #category : #'api - configuration' }
GtPhlowListView >> itemStencil: aBrListItemElementStencilBuilderOrBlock [
	"An item element stencil can be a #value-able of the form [ :anItemType | ]"

	itemStencil := aBrListItemElementStencilBuilderOrBlock asStencilBuilder: BrListItemElementStencilBuilder
]

{ #category : #'api - scripting' }
GtPhlowListView >> itemText: aBlockOrSymbol [
	"Display each list item as a text label whose text is computed based on the given text computation as a block or a symbol"

	itemComputation := aBlockOrSymbol.
	self itemStencil: GtPhlowListTextElementStencilBuilder new.
	self itemDataBinder: GtPhlowListTextDataBinder new
]

{ #category : #'api - configuration' }
GtPhlowListView >> itemType: aBrListItemTypeStencilBuilderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemTypeFactory :anItemObject :anItemIndex | ].
	==anItemTypeFactory== is a ${class:BrListItemType class}$"

	itemTypeStencil := aBrListItemTypeStencilBuilderOrBlock asStencilBuilder: BrListItemTypeStencilBuilder
]

{ #category : #'private - accessing' }
GtPhlowListView >> itemTypeStencil [
	"Return a stencil that is used to create an item type of a given item object"

	^ itemTypeStencil
]

{ #category : #'api - scripting' }
GtPhlowListView >> items: aBlock [
	itemsProviderComputation := aBlock
]

{ #category : #'private - accessing' }
GtPhlowListView >> itemsProviderComputation [
	^ itemsProviderComputation
]

{ #category : #'private - accessing' }
GtPhlowListView >> itemsProviderOnExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ itemsProviderComputation value asBrItemsProvider ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #'private - building' }
GtPhlowListView >> newDecoratedItemDataBinder [
	| anItemDataBinder |

	anItemDataBinder := self itemDataBinder.
	
	anItemDataBinder := GtPhlowSimpleListItemComputationDataBinder new
		dataBinder: anItemDataBinder;
		itemComputation: itemComputation.

	anItemDataBinder := GtPhlowSimpleListErrorHandlingItemDataBinder new
		dataBinder: anItemDataBinder.

	^ anItemDataBinder
]

{ #category : #'private - building' }
GtPhlowListView >> newDecoratedItemStencil [
	| anItemElementStencil |
	anItemElementStencil := self itemElementStencil.

	self contextMenuActions
		ifNotEmpty: [ :contextMenuActionsList | 
			anItemElementStencil := GtPhlowListItemElementWithContextMenuDecorator new
					stencilBuilder: anItemElementStencil;
					contextMenuItemsStencil: self contextMenuItemsStencilFromActions;
					contextMenuStencil: self contextMenuStencilFromActions ].


	anItemElementStencil := GtPhlowSimpleListErrorHandlingItemElementStencilBuilder
			new
			stencilBuilder: anItemElementStencil;
			cellSpacing: (BlInsets left: 10).

	anItemElementStencil := GtPhlowListItemElementWithSelectionDecorator new
			stencilBuilder: anItemElementStencil.

	^ anItemElementStencil
]

{ #category : #'private - building' }
GtPhlowListView >> newDecoratedItemTypeStencil [
	| anItemTypeStencil |

	anItemTypeStencil := self itemTypeStencil.

	anItemTypeStencil := GtPhlowListErrorHandlingItemTypeStencilBuilder new
		itemTypeStencilBuilder: anItemTypeStencil.

	^ anItemTypeStencil
]

{ #category : #'api - configuration' }
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
		
		aRowStencil ]
]

{ #category : #'api - updating' }
GtPhlowListView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"

	| aParent |
	(self isExpectedElement: aCurrentElement)
		ifFalse: [ ^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ | theItems |
		theItems := self itemsProviderOnExceptionErrorElement: [ :anErrorElement | 
			^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		self enqueueAction: [ aCurrentElement itemsProvider: theItems ] in: aCurrentElement ]
]

{ #category : #'api - converting' }
GtPhlowListView >> withMultipleSelection [
	multipleSelectionEnabled := true
]

{ #category : #'api - converting' }
GtPhlowListView >> withoutMultipleSelection [
	multipleSelectionEnabled := false
]
