"
nil
"
Class {
	#name : #GtPhlowColumnedListView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowColumnedHeader + TGtPhlowColumnScripts + TGtPhlowSendTransformable + TGtPhlowWithContextMenu',
	#classTraits : 'TGtPhlowColumnedHeader classTrait + TGtPhlowColumnScripts classTrait + TGtPhlowSendTransformable classTrait + TGtPhlowWithContextMenu classTrait',
	#instVars : [
		'itemsProviderComputation',
		'columns',
		'rowDataBinder',
		'multipleSelectionEnabled'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowColumnedListView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aContainer header itemsProvider list |
	itemsProvider := self
			itemsProviderOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].

	aContainer := self elementClass new.
	aContainer
		id: GtPhlowColumnedListContainerId;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].

	aContainer layout: BlLinearLayout vertical.
	header := self buildHeaderForItems: #().

	list := self columnedListClass new.

	self hasMultipleSelection
		ifTrue: [ list aptitude: BrColumnedMultiListAptitude ].

	list
		id: GtPhlowColumnedListId;
		itemsProvider: itemsProvider;
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation);
		rowStencil: self newDecoratedItemStencil.


	rowDataBinder ifNotNil: [ list rowDataBinder: rowDataBinder ].

	self buildColumnsInList: list.
	aContainer
		addChildren: {header.
				list}.
	self beViewElement: aContainer.

	^ aBlock value: aContainer
]

{ #category : #'private - building' }
GtPhlowColumnedListView >> buildColumnsInList: aList [
	columns do: [ :eachPhlowColumn |
		eachPhlowColumn configureColumn: aList column ]
		"aList column
			title: eachPhlowColumn title;
			cellStencil: eachPhlowColumn cellStencil;
			dataBinder: eachPhlowColumn dataBinder;
			stencil: [ :eachItem :eachIndex |
				| aRowElement |

				aRowElement := self performBlock: [ 
					eachPhlowColumn createRowElementFor: eachItem atIndex: eachIndex ].
				
				eachPhlowColumn resizer ifNotNil: [ :aLayoutResizer |
					aRowElement constraintsDo: [ :c |
						c horizontal resizer: aLayoutResizer.
						c vertical fitContent ].
					aRowElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
					aRowElement dispatchEvent: (BrLayoutVerticalResizerWish fitContent) ].
				aRowElement ] ]."
]

{ #category : #accessing }
GtPhlowColumnedListView >> cellSpacing [
	^ 10
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column [
	<return: #GtPhlowColumn>
	| aColumn |
	
	aColumn := GtPhlowColumn new index: columns size + 1.
	columns add: aColumn.
	^ aColumn
]

{ #category : #'private - testing' }
GtPhlowColumnedListView >> columnedListClass [
	^ BrColumnedList
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> columns [
	<return: #Collection of: #GtPhlowColumn>
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

	multipleSelectionEnabled := false
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
GtPhlowColumnedListView >> withMultipleSelection [
	multipleSelectionEnabled := true
]

{ #category : #'api - converting' }
GtPhlowColumnedListView >> withoutMultipleSelection [
	multipleSelectionEnabled := false
]
