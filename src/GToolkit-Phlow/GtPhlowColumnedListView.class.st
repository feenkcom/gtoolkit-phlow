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

{ #category : #'api - converting' }
GtPhlowColumnedListView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aContainer aHeader itemsProvider aList |
	itemsProvider := self
			itemsProviderOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].

	aContainer := self elementClass new.
	aContainer
		id: GtPhlowColumnedListContainerId;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].

	aContainer layout: BlLinearLayout vertical.

	aList := self columnedListClass new.

	self hasMultipleSelection
		ifTrue: [ aList aptitude: BrColumnedMultiListAptitude ].

	aList
		id: GtPhlowColumnedListId;
		itemsProvider: itemsProvider;
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation);
		rowStencil: self newDecoratedItemStencil.

	rowDataBinder ifNotNil: [ aList rowDataBinder: rowDataBinder ].

	self buildColumnsInList: aList.
	aHeader := self buildHeaderForItems: aList columns.
	
	aContainer
		addChildren: { aHeader. aList }.

	horizontalScrollingEnabled
		ifTrue: [
			| aScrollableElement |
			
			aContainer constraintsDo: [ :c | c horizontal fitContent ].
			aList hFitContent.
			aHeader constraintsDo: [ :c | c horizontal fitContent ].
			
			aScrollableElement := BrScrollPane new
				aptitude: BrScrollPaneAptitude + BrGlamorousWithHorizontalScrollbarAptitude;
				matchParent;
				content: aContainer;
				margin: (BlInsets bottom: 2).
			
			aContainer := aScrollableElement ].
			
	aContainer addAptitude: (
		BrLayoutResizerAptitude new
			hMatchParentToMatchParent: aHeader;
			hExactToMatchParent: aHeader;
			hFitContentToFitContent: aHeader;
			hFitContentLimitedToFitContentLimited: aHeader;
			vAnyToFitContent: aHeader;
			matchParentToMatchParent: aList;
			exactToMatchParent: aList;
			fitContentToFitContent: aList;
			fitContentLimitedToFitContentLimited: aList).
	
	self beViewElement: aContainer.

	^ aBlock value: aContainer
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
	^ 10
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

{ #category : #'private - testing' }
GtPhlowColumnedListView >> isExpectedElement: aCurrentElement [
	aCurrentElement class = self elementClass ifFalse: [ ^ false ].
	aCurrentElement childrenCount = 2 ifFalse: [ ^ false ].
	(aCurrentElement childAt: 2) class = self columnedListClass ifFalse: [ ^ false ].
	^ true
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
					contextMenuStencil: self contextMenuStencilFromActions ].

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

{ #category : #'api - updating' }
GtPhlowColumnedListView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"
	
	| aParent |
	(self isExpectedElement: aCurrentElement) ifFalse: [ 
		^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		| theItems aList |
		theItems := self itemsProviderOnExceptionErrorElement: [ :anErrorElement | 
			^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		aList := aCurrentElement children second.
		self enqueueAction: [ aList itemsProvider: theItems ] in: aList ].
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
