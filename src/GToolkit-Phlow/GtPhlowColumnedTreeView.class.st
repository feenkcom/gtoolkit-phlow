Class {
	#name : #GtPhlowColumnedTreeView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowColumnedHeader + TGtPhlowColumnScripts + TGtPhlowSendTreeNodeTransformable + TGtPhlowTreeNodeExpansion + TGtPhlowWithContextMenu + TGtPhlowColumnedRemoteSpecification',
	#classTraits : 'TGtPhlowColumnedHeader classTrait + TGtPhlowColumnScripts classTrait + TGtPhlowSendTreeNodeTransformable classTrait + TGtPhlowTreeNodeExpansion classTrait + TGtPhlowWithContextMenu classTrait + TGtPhlowColumnedRemoteSpecification classTrait',
	#instVars : [
		'columns',
		'transformation',
		'itemsBuilder',
		'childrenBuilder',
		'multipleSelectionEnabled'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #building }
GtPhlowColumnedTreeView >> asElementDo: aBlock [
	| aContainer aTree theItems phlowColumns |
	theItems := self itemsOnExceptionErrorElement: [ :element | ^ aBlock value: element ].
	aContainer := self elementClass new.
	aContainer layout: BlLinearLayout vertical;
		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ].
	aTree := self columnedTreeClass new matchParent.
	self performBlock: [ aTree items: theItems lazy: self errorCatchingChildrenBuilder ]
		onExceptionErrorElement: [ :element | ^ aBlock value: element ].
	aTree addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation asTreeNodeTransformation).
	self hasMultipleSelection ifTrue: [ aTree aptitude: BrColumnedMultiTreeAptitude ].
	aTree cellSpacing: self cellSpacing.
	aTree rowStencil: self newDecoratedItemStencil.
	self buildColumnsInTree: aTree.
	phlowColumns := self columns ifEmpty: [ { self fallbackColumnWhenEmpty } ].
	aTree withHeadersDo: [ :header |
		header
			headerId: GtPhlowColumnedListHeaderId;
			labelStencil: [ :column | (phlowColumns at: (aTree columns identityIndexOf: column)) buildHeaderElement ];
			resizerIdStencil: [ :column | (column title asString, '-resizer') asSymbol ] ].
	self performBlock: [ self expandTree: aTree ]
		onExceptionErrorElement: [ :element | ^ aBlock value: element ].
	aContainer addEventHandler: (GtPhlowTreeExpanderEventHandler new treeElement: aTree).
	aContainer addChild: aTree.
	aContainer addAptitude: (BrLayoutResizerAptitude new inherit: aTree).
	self beViewElement: aContainer.
	^ aBlock value: aContainer
]

{ #category : #'private - building' }
GtPhlowColumnedTreeView >> buildColumnsInTree: aTree [
	columns
		do: [ :eachPhlowColumn | 
			eachPhlowColumn configureColumn: aTree column ].
			
	columns ifEmpty:  [ self fallbackColumnWhenEmpty configureColumn: aTree column ].
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> cellSpacing [
	^ BrColumn defaultCellSpacing
]

{ #category : #'api - scripting' }
GtPhlowColumnedTreeView >> children: aValuable [
	childrenBuilder := aValuable
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> childrenBuilder [
	^ childrenBuilder
]

{ #category : #'api - scripting column' }
GtPhlowColumnedTreeView >> columnOfType: aColumnClass [
	<return: #GtPhlowTextColumn>
	| aColumn |
	
	aColumn := aColumnClass new index: columns size + 1.
	columns add: aColumn.
	^ aColumn
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> columnedTreeClass [
	^ BrColumnedTree
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> columns [
	<return: #Collection of: #GtPhlowExplicitColumn>
	^ columns
]

{ #category : #copying }
GtPhlowColumnedTreeView >> copyTransformationFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowColumnedTreeView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> elementClass [
	^ BlElement
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> errorCatchingChildrenBuilder [
	^ [ :aParent | 
			(aParent isKindOf: GtPhlowChildrenBuilderError)
				ifTrue: [ Array empty ]
				ifFalse: [ 
					self
						performBlock: [ self childrenBuilder value: aParent ] 
						onException: [ :anException | 
							anException freeze.
							Array with: (GtPhlowChildrenBuilderError new 
								exception: anException;
								parent: aParent;
								childrenBuilder: self childrenBuilder) ] ] ]
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> gtViewContextMenuActionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Context menu actions';
		items: [ self contextMenuActions ];
		column: 'Name' text: #name;
		column: 'Action' text: #action;
		column: 'Filter' text: [ :anAction | anAction filter ifNil: [ '' ] ]
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> hasMultipleSelection [
	^ multipleSelectionEnabled
]

{ #category : #initialization }
GtPhlowColumnedTreeView >> initialize [
	super initialize.
	
	columns := OrderedCollection new.
	itemsBuilder := [ { } ].
	childrenBuilder := [ :each | { } ].
	self transformation: self defaultTransformation.
	multipleSelectionEnabled := false
]

{ #category : #testing }
GtPhlowColumnedTreeView >> isExpectedElement: anElement [
	^ anElement class = self elementClass
		and: [ (anElement query // BrColumnedTree) isNotEmpty ]
]

{ #category : #'api - scripting' }
GtPhlowColumnedTreeView >> items: aValuable [
	itemsBuilder := aValuable
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> itemsOnExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ self itemsBuilder value ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> itemsProviderComputation [
	^ self itemsBuilder
]

{ #category : #'api - converting' }
GtPhlowColumnedTreeView >> newDecoratedItemStencil [
	| anItemElementStencil |
	anItemElementStencil := BrGlamorousColumnedTreeSelectableRowElementStencilBuilder
			new cellSpacing: self cellSpacing.
	self contextMenuActions
		ifNotEmpty: [ :contextMenuActionsList | 
			anItemElementStencil := GtPhlowColumnedTreeItemElementWithContextMenuDecorator
					new
					stencilBuilder: anItemElementStencil;
					contextMenuItemsStencil: self contextMenuItemsStencilFromActions;
					contextMenuStencil: self contextMenuStencilFromActions;
					multipleSelectionEnabled: multipleSelectionEnabled ].

	^ anItemElementStencil
]

{ #category : #'instance creation' }
GtPhlowColumnedTreeView >> newWrapper [
	| aWrapper |
	aWrapper := BlElement new.
	aWrapper layout: BlLinearLayout vertical.
	aWrapper
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical matchParent ].
	^ aWrapper
]

{ #category : #updating }
GtPhlowColumnedTreeView >> updateContent: aCurrentElement [
	| aParent |
	(self isExpectedElement: aCurrentElement) ifFalse: [ ^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [
		| theItems aTree |
		theItems := self itemsOnExceptionErrorElement: [ :errorElement |
			^ self replaceOldElement: aCurrentElement by: errorElement in: aParent ].
		aTree := (aCurrentElement query // BrColumnedTree) anyOne.
		self enqueueAction: [
			aTree items: theItems lazy: self errorCatchingChildrenBuilder.
			self expandTree: aTree ] in: aTree ]
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> withMultipleSelection [
	multipleSelectionEnabled := true
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> withoutMultipleSelection [
	multipleSelectionEnabled := false
]
