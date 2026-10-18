"
nil
"
Class {
	#name : #GtPhlowColumnedListView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowColumnedHeader + TGtPhlowColumnScripts + TGtPhlowSendTransformable + TGtPhlowWithContextMenu + TGtPhlowColumnedRemoteSpecification',
	#classTraits : 'TGtPhlowColumnedHeader classTrait + TGtPhlowColumnScripts classTrait + TGtPhlowSendTransformable classTrait + TGtPhlowWithContextMenu classTrait + TGtPhlowColumnedRemoteSpecification classTrait',
	#instVars : [
		'itemsProviderComputation',
		'columns',
		'rowDataBinder',
		'multipleSelectionEnabled',
		'horizontalScrollingEnabled'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #building }
GtPhlowColumnedListView >> asElementDo: aBlock [
	| container provider list phlowColumns |
	provider := self itemsProviderOnExceptionErrorElement: [ :element | ^ aBlock value: element ].
	container := self elementClass new
		id: GtPhlowColumnedListContainerId;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ].
	list := self columnedListClass new.
	self hasMultipleSelection ifTrue: [ list aptitude: BrColumnedMultiListAptitude ].
	list id: GtPhlowColumnedListId;
		itemsProvider: provider;
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation);
		cellSpacing: self cellSpacing;
		rowStencil: self newDecoratedItemStencil.
	rowDataBinder ifNotNil: [ list rowDataBinder: rowDataBinder ].
	self buildColumnsInList: list.
	phlowColumns := self columns ifEmpty: [ { self fallbackColumnWhenEmpty } ].
	list withHeadersDo: [ :header |
		header headerId: GtPhlowColumnedListHeaderId;
			labelStencil: [ :column | (phlowColumns at: (list columns identityIndexOf: column)) buildHeaderElement ];
			resizerIdStencil: [ :column | (column title asString, '-resizer') asSymbol ] ].
	container addChild: list.
	horizontalScrollingEnabled ifTrue: [
		container constraintsDo: [ :c | c horizontal fitContent ].
		list hFitContent.
		(list query // GtPhlowColumnedListHeaderId) anyOne hFitContent.
		container := BrScrollPane new
			aptitude: BrScrollPaneAptitude + BrGlamorousWithHorizontalScrollbarAptitude;
			matchParent; content: container; margin: (BlInsets bottom: 2) ].
	container addAptitude: (BrLayoutResizerAptitude new inherit: list).
	self beViewElement: container.
	^ aBlock value: container
]

{ #category : #'private - building' }
GtPhlowColumnedListView >> buildColumnsInList: aList [
	columns do: [ :eachPhlowColumn |
		eachPhlowColumn configureColumn: aList column ].
	
	"There must be at least one default column"
	columns ifEmpty:  [
		self fallbackColumnWhenEmpty
			configureColumn: aList column ].
]

{ #category : #accessing }
GtPhlowColumnedListView >> cellSpacing [
	^ BrColumn defaultCellSpacing
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> columnOfType: aColumnClass [
	<return: #GtPhlowTextColumn>
	| aColumn |
	
	aColumn := aColumnClass new index: columns size + 1.
	columns add: aColumn.
	^ aColumn
]

{ #category : #'private - testing' }
GtPhlowColumnedListView >> columnedListClass [
	^ BrColumnedList
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> columns [
	<return: #Collection of: #GtPhlowExplicitColumn>
	^ columns
]

{ #category : #copying }
GtPhlowColumnedListView >> copyTransformationFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowColumnedListView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> elementClass [
	^ BlElement
]

{ #category : #accessing }
GtPhlowColumnedListView >> gtViewContextMenuActionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Context menu actions';
		items: [ self contextMenuActions ];
		column: 'Name' text: #name;
		column: 'Action' text: #action;
		column: 'Filter' text: [ :anAction | anAction filter ifNil: [ '' ] ]
]

{ #category : #'api - converting' }
GtPhlowColumnedListView >> hasMultipleSelection [
	^ multipleSelectionEnabled
]

{ #category : #initialization }
GtPhlowColumnedListView >> initialize [
	super initialize.

	columns := OrderedCollection new.
	self items: [ { } ].
	self transformation: self defaultTransformation.

	multipleSelectionEnabled := false.
	horizontalScrollingEnabled := false
]

{ #category : #testing }
GtPhlowColumnedListView >> isExpectedElement: anElement [
	^ (anElement class = self elementClass or: [ anElement isKindOf: BrScrollPane ])
		and: [ (anElement query // GtPhlowColumnedListId) isNotEmpty ]
]

{ #category : #'api - scripting' }
GtPhlowColumnedListView >> items: aBlock [
	itemsProviderComputation := aBlock
]

{ #category : #accessing }
GtPhlowColumnedListView >> itemsProvider: aBlock [
	itemsProviderComputation := aBlock
]

{ #category : #accessing }
GtPhlowColumnedListView >> itemsProviderComputation [
	^ itemsProviderComputation
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> itemsProviderOnExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ itemsProviderComputation value asBrItemsProvider ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #accessing }
GtPhlowColumnedListView >> newDecoratedItemStencil [
	| anItemElementStencil |
	anItemElementStencil := BrGlamorousColumnedListSelectableRowElementStencilBuilder
			new cellSpacing: self cellSpacing.
	self contextMenuActions
		ifNotEmpty: [ :contextMenuActionsList | 
			anItemElementStencil := GtPhlowColumnedListItemElementWithContextMenuDecorator
					new
					stencilBuilder: anItemElementStencil;
					contextMenuItemsStencil: self contextMenuItemsStencilFromActions;
					contextMenuStencil: self contextMenuStencilFromActions;
					multipleSelectionEnabled: multipleSelectionEnabled ].

	^ anItemElementStencil
]

{ #category : #'api - converting' }
GtPhlowColumnedListView >> rowDataBinder [
	^ rowDataBinder
]

{ #category : #'api - converting' }
GtPhlowColumnedListView >> rowDataBinder: aBlock [
	rowDataBinder := aBlock
]

{ #category : #updating }
GtPhlowColumnedListView >> updateContent: aCurrentElement [
	| parent |
	(self isExpectedElement: aCurrentElement) ifFalse: [ ^ super updateContent: aCurrentElement ].
	parent := aCurrentElement parent.
	parent ifNotNil: [
		| provider list |
		provider := self itemsProviderOnExceptionErrorElement: [ :error |
			^ self replaceOldElement: aCurrentElement by: error in: parent ].
		list := (aCurrentElement query // BrColumnedList) anyOne.
		self enqueueAction: [ self columns do: #prepareForUpdateContent. list itemsProvider: provider ] in: list ]
]

{ #category : #'api - converting' }
GtPhlowColumnedListView >> withHorizontalScrolling [
	horizontalScrollingEnabled := true
]

{ #category : #'api - converting' }
GtPhlowColumnedListView >> withMultipleSelection [
	multipleSelectionEnabled := true
]

{ #category : #'api - converting' }
GtPhlowColumnedListView >> withoutHorizontalScrolling [
	horizontalScrollingEnabled := false
]

{ #category : #'api - converting' }
GtPhlowColumnedListView >> withoutMultipleSelection [
	multipleSelectionEnabled := false
]
