Class {
	#name : #GtPhlowGroupedListView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowSendTransformable + TGtPhlowWithContextMenu',
	#classTraits : 'TGtPhlowSendTransformable classTrait + TGtPhlowWithContextMenu classTrait',
	#instVars : [
		'itemComputation',
		'itemStencil',
		'itemDataBinder',
		'itemTypeStencil',
		'itemId',
		'groupsProviderComputation',
		'itemContextMenuStencil',
		'headerElementStencil',
		'itemsProvider',
		'groupStencil',
		'groupLabelStencil',
		'groupLabelDataBinder'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowGroupedListView >> asElementDo: aBlock [
	| aList groupsProvider |
	groupsProvider := self
			groupsProviderOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].

	aList := self elementClass new groupsProvider: groupsProvider.
	aList
		addEventHandler: (GtPhlowGroupedListToSelectHandler new transformation: self transformation).
	aList constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].
	aList headerElementStencil: self groupLabelStencil;
		headerDataBinder: self groupLabelDataBinder.
	itemId ifNotNil: [ aList itemId: itemId ].

	self beViewElement: aList.
	^ aBlock value: aList
]

{ #category : #'private - accessing' }
GtPhlowGroupedListView >> buildGroups [
	| itemStream |
	itemStream := itemsProvider value asAsyncStream cached.
	^ groupsProviderComputation value asAsyncStream
		map: [ :aPair | 
			self groupStencil
				value: aPair key
				value: (itemStream asyncSimilarCopy filter: aPair value) ]
]

{ #category : #copying }
GtPhlowGroupedListView >> copyTransformationFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
]

{ #category : #initialization }
GtPhlowGroupedListView >> defaultGroupLabelDataBinder [
	^ [ :aLabel :eachItem | aLabel text: eachItem domainObject ]
]

{ #category : #initialization }
GtPhlowGroupedListView >> defaultGroupLabelStencil [
	^ [ BrLabel new
		margin: (BlInsets top: 10);
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ]
]

{ #category : #initialization }
GtPhlowGroupedListView >> defaultGroupStencil [
	^ [ :aLabel :aStream  | 
	BrGroup new
		stream: aStream;
		domainObject: aLabel;
		shouldShowWithoutItems: true ]
]

{ #category : #defaults }
GtPhlowGroupedListView >> defaultItemComputation [
	^ [ :eachItem :eachRowIndex | eachItem ]
]

{ #category : #'scripting - deprecated' }
GtPhlowGroupedListView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #defaults }
GtPhlowGroupedListView >> elementClass [
	^ BrGroupedList
]

{ #category : #'scripting - deprecated' }
GtPhlowGroupedListView >> format: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemFormat: instead.'
		transformWith: '`@receiver format: `@statements' -> '`@receiver itemFormat: `@statements'.
	self itemFormat: aBlockOrSymbol
]

{ #category : #accessing }
GtPhlowGroupedListView >> groupLabelDataBinder [
	^ groupLabelDataBinder
]

{ #category : #accessing }
GtPhlowGroupedListView >> groupLabelDataBinder: anObject [
	groupLabelDataBinder := anObject
]

{ #category : #accessing }
GtPhlowGroupedListView >> groupLabelStencil [
	^ groupLabelStencil
]

{ #category : #accessing }
GtPhlowGroupedListView >> groupLabelStencil: anObject [
	groupLabelStencil := anObject
]

{ #category : #accessing }
GtPhlowGroupedListView >> groupStencil [
	^ groupStencil
]

{ #category : #accessing }
GtPhlowGroupedListView >> groupStencil: anObject [
	groupStencil := anObject
]

{ #category : #accessing }
GtPhlowGroupedListView >> groups: aBlock [
	groupsProviderComputation := aBlock
]

{ #category : #'private - accessing' }
GtPhlowGroupedListView >> groupsProviderOnExceptionErrorElement: aBlock [
	^ self
		performBlock: [ BrStreamItemsProvider new
				stream: (self buildGroups asAsyncStream
						map: [ :aGroup | 
							aGroup
								itemStencil: self newDecoratedItemStencil;
								itemDataBinder: self newDecoratedItemDataBinder;
								itemType: self newDecoratedItemTypeStencil ]) ]
		onExceptionErrorElement: [ :anElement | aBlock value: anElement ]
]

{ #category : #accessing }
GtPhlowGroupedListView >> headerDataBinder [
	^ headerDataBinder
]

{ #category : #accessing }
GtPhlowGroupedListView >> headerDataBinder: anObject [
	headerDataBinder := anObject
]

{ #category : #initialization }
GtPhlowGroupedListView >> initialize [
	super initialize.
	self items: [ { } ].
	self groups: [ { } ].
	self itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | anItemTypeFactory default ].
	self itemText: [ :aValue | aValue ].
	self transformation: self defaultTransformation.
	self groupStencil: self defaultGroupStencil.
	self groupLabelStencil: self defaultGroupLabelStencil.
	self groupLabelDataBinder: self defaultGroupLabelDataBinder.

	itemComputation := self defaultItemComputation.
	"nil means that we should not create a context menu for each item"
	itemContextMenuStencil := nil
]

{ #category : #'private - testing' }
GtPhlowGroupedListView >> isExpectedElement: aCurrentElement [
	^ aCurrentElement class = self elementClass
]

{ #category : #'private - accessing' }
GtPhlowGroupedListView >> itemComputation [
	^ itemComputation
]

{ #category : #'private - accessing' }
GtPhlowGroupedListView >> itemDataBinder [
	"Return a stencil that is used to bind data to a given item element"

	^ itemDataBinder
]

{ #category : #'api - configuration' }
GtPhlowGroupedListView >> itemDataBinder: aBrListItemDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemElement :anItemObject :anItemIndex | ]"

	itemDataBinder := aBrListItemDataBinderOrBlock asStencilBuilder: BrListItemDataBinder
]

{ #category : #'scripting - deprecated' }
GtPhlowGroupedListView >> itemElement: anObject [
	self 
		deprecated: 'Please use #itemStencil: instead.'
		transformWith: '`@receiver itemElement: `@statements' -> '`@receiver itemStencil: `@statements'.
	itemStencil := anObject
]

{ #category : #'private - accessing' }
GtPhlowGroupedListView >> itemElementStencil [
	^ itemStencil
]

{ #category : #'scripting - deprecated' }
GtPhlowGroupedListView >> itemFormat: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemText: instead.'
		transformWith: '`@receiver itemFormat: `@statements' -> '`@receiver itemText: `@statements'.
	self itemText: aBlockOrSymbol
]

{ #category : #'api - configuration' }
GtPhlowGroupedListView >> itemId: aBrListItemIdStencilBuilderOrBlock [
		"An item type stencil can be a #value-able of the form [ :anItemObject :anItemIndex | ]"

	itemId := aBrListItemIdStencilBuilderOrBlock 
]

{ #category : #accessing }
GtPhlowGroupedListView >> itemStencil: aBrListItemElementStencilBuilderOrBlock [
	"An item element stencil can be a #value-able of the form [ :anItemType | ]"

	itemStencil := aBrListItemElementStencilBuilderOrBlock asStencilBuilder: BrListItemElementStencilBuilder
]

{ #category : #'api - scripting' }
GtPhlowGroupedListView >> itemText: aBlockOrSymbol [
	"Display each list item as a text label whose text is computed based on the given text computation as a block or a symbol"

	itemComputation := aBlockOrSymbol.
	self itemStencil: GtPhlowListTextElementStencilBuilder new.
	self itemDataBinder: GtPhlowListTextDataBinder new
]

{ #category : #'api - configuration' }
GtPhlowGroupedListView >> itemType: aBrListItemTypeStencilBuilderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemTypeFactory :anItemObject :anItemIndex | ].
	==anItemTypeFactory== is a ${class:BrListItemType class}$"

	itemTypeStencil := aBrListItemTypeStencilBuilderOrBlock asStencilBuilder: BrListItemTypeStencilBuilder
]

{ #category : #'private - accessing' }
GtPhlowGroupedListView >> itemTypeStencil [
	"Return a stencil that is used to create an item type of a given item object"

	^ itemTypeStencil
]

{ #category : #'private - accessing' }
GtPhlowGroupedListView >> items: aBlock [
	itemsProvider := aBlock
]

{ #category : #'private - building' }
GtPhlowGroupedListView >> newDecoratedItemDataBinder [
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
GtPhlowGroupedListView >> newDecoratedItemStencil [
	| anItemElementStencil |
	anItemElementStencil := self itemElementStencil.

	self contextMenuActions
		ifNotEmpty: [ :contextMenuActionsList | 
			anItemElementStencil := GtPhlowListItemElementWithContextMenuDecorator new
					stencilBuilder: anItemElementStencil;
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
GtPhlowGroupedListView >> newDecoratedItemTypeStencil [
	| anItemTypeStencil |

	anItemTypeStencil := self itemTypeStencil.

	anItemTypeStencil := GtPhlowListErrorHandlingItemTypeStencilBuilder new
		itemTypeStencilBuilder: anItemTypeStencil.

	^ anItemTypeStencil
]

{ #category : #'api - configuration' }
GtPhlowGroupedListView >> stencil: aBrListRowStencilBuilder [
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
GtPhlowGroupedListView >> updateContent: aCurrentElement [
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
