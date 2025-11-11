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

{ #category : #'api - converting' }
GtPhlowColumnedTreeView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aContainer aHeader aTree theItems |
	theItems := self
		itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	aContainer := self elementClass new.
	aContainer
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aContainer layout: BlLinearLayout vertical.

	aTree := self columnedTreeClass new.
	aTree matchParent.
	self
		performBlock: [ aTree items: theItems lazy: self errorCatchingChildrenBuilder ]
		onExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	
	aTree
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation asTreeNodeTransformation).
	aTree
		rowStencil: self newDecoratedItemStencil.				
		
	self hasMultipleSelection ifTrue: [
		aTree aptitude: BrColumnedMultiTreeAptitude
	].

	self buildColumnsInTree: aTree.
	aHeader := self buildHeaderForItems: aTree columns.
	aHeader children
		ifNotEmpty: [ aHeader children first padding: (BlInsets left: 20) ].
	
	self
		performBlock: [ self expandTree: aTree ]
		onExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].

	aContainer addEventHandler: (GtPhlowTreeExpanderEventHandler new 
		treeElement: aTree).
		
	aContainer
		addChildren:
			{aHeader.
			aTree}.
	
	aContainer addAptitude: (
		BrLayoutResizerAptitude new
			hMatchParentToMatchParent: aHeader;
			hExactToMatchParent: aHeader;
			hFitContentToFitContent: aHeader;
			hFitContentLimitedToFitContentLimited: aHeader;
			vAnyToFitContent: aHeader;
			matchParentToMatchParent: aTree;
			exactToMatchParent: aTree;
			fitContentToFitContent: aTree;
			fitContentLimitedToFitContentLimited: aTree).
			
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

{ #category : #'private - building' }
GtPhlowColumnedTreeView >> buildHeaderForItems: theItems [
	| aHeader exp |
	aHeader := BlElement new.
	aHeader
		layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: self cellSpacing).
	aHeader padding: (BlInsets top: 5 bottom: 5).
	aHeader id: GtPhlowColumnedListHeaderId.
	aHeader
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].	

	"Add an invisible expander to the header to make spacing for columns correct"
	exp := BrColumnedTreeRowElementStencilBuilder new createExpandCollapseElement.
	exp visibility: BlVisibilityHidden new.
	aHeader addChild: exp.
	self buildHeaderItems: theItems inHeader: aHeader.
	^ aHeader
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> cellSpacing [
	^ 10
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
GtPhlowColumnedTreeView >> isExpectedElement: aCurrentElement [
	aCurrentElement class = self elementClass ifFalse: [ ^ false ].
	aCurrentElement childrenCount = 2 ifFalse: [ ^ false ].
	(aCurrentElement childAt: 2) class = self columnedTreeClass ifFalse: [ ^ false ].
	^ true
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
GtPhlowColumnedTreeView >> newHeader [
	^ BlElement new
		layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: 10);
		padding: (BlInsets top: 5 bottom: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
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
	"anElement is previously computed content from asElementDo:"
	
	| aParent |
	(self isExpectedElement: aCurrentElement) ifFalse: [ 
		^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		| theItems aTree |
		theItems := self itemsOnExceptionErrorElement: [ :anErrorElement | 
			^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		aTree := aCurrentElement children second.
		self 
			enqueueAction: [ 
				aTree items: theItems lazy: self errorCatchingChildrenBuilder.
				self expandTree: aTree ] 
			in: aTree ].
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> withMultipleSelection [
	multipleSelectionEnabled := true
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> withoutMultipleSelection [
	multipleSelectionEnabled := false
]
