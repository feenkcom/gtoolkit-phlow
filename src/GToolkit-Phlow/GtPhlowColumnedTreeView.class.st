Class {
	#name : #GtPhlowColumnedTreeView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowColumnedHeader + TGtPhlowColumnScripts + TGtPhlowSendTreeNodeTransformable',
	#classTraits : 'TGtPhlowColumnedHeader classTrait + TGtPhlowColumnScripts classTrait + TGtPhlowSendTreeNodeTransformable classTrait',
	#instVars : [
		'columns',
		'transformation',
		'itemsBuilder',
		'childrenBuilder',
		'expander'
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
	aHeader := self buildHeaderForItems: theItems.
	aHeader children
		ifNotEmpty: [ aHeader children first padding: (BlInsets left: 20) ].

	aTree := self columnedTreeClass new.
	self
		performBlock: [ aTree items: theItems lazy: self childrenBuilder ]
		onExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	
	aTree
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation asTreeNodeTransformation).
	aTree
		rowStencil: (BrGlamorousColumnedTreeSelectableRowElementStencilBuilder new cellSpacing: self cellSpacing).				

	self buildColumnsInTree: aTree.
	
	self
		performBlock: [ self expandTree: aTree ]
		onExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].

	aContainer
		addChildren:
			{aHeader.
			aTree}.
	self beViewElement: aContainer.
	^ aBlock value: aContainer
]

{ #category : #'private - building' }
GtPhlowColumnedTreeView >> buildColumnsInTree: aTree [
	columns
		do: [ :eachPhlowColumn | 
			eachPhlowColumn configureColumn: aTree column ].
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> cellSpacing [
	^ 10
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> children: aValuable [
	childrenBuilder := aValuable
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> childrenBuilder [
	^ childrenBuilder
]

{ #category : #'expanding-collapsing' }
GtPhlowColumnedTreeView >> collapseAll [
	expander := GtPhlowTreeNodeExpander null.
]

{ #category : #'api - scripting column' }
GtPhlowColumnedTreeView >> column [
	<return: #GtPhlowColumn>
	| aColumn |
	
	aColumn := GtPhlowColumn new index: columns size + 1.
	columns add: aColumn.
	^ aColumn
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> columnedTreeClass [
	^ BrColumnedTree
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> columns [
	<return: #Collection of: #GtPhlowColumn>
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

{ #category : #'expanding-collapsing' }
GtPhlowColumnedTreeView >> expandAll [
	self expandUpTo: 20
]

{ #category : #'expanding-collapsing' }
GtPhlowColumnedTreeView >> expandOneLevel [
	self expandUpTo: 1
]

{ #category : #'expanding-collapsing' }
GtPhlowColumnedTreeView >> expandSuchThat: aBlock [
	"It stops expanding children if a parent node does not satisfy the condition.
	The block receives [ :aTreeNode :aNodeValue | ... ]"
	expander := GtPhlowTreeNodeExpander suchThat: aBlock.
]

{ #category : #'private - actions' }
GtPhlowColumnedTreeView >> expandTree: aBrColumnedTree [ 
	expander ifNil: [ ^ self ].
	expander expandTree: aBrColumnedTree.
]

{ #category : #'expanding-collapsing' }
GtPhlowColumnedTreeView >> expandUpTo: aLevelIndex [
	expander := GtPhlowTreeNodeExpander upTo: aLevelIndex.
]

{ #category : #initialization }
GtPhlowColumnedTreeView >> initialize [
	super initialize.
	
	columns := OrderedCollection new.
	itemsBuilder := [ { } ].
	childrenBuilder := [ :each | { } ].
	expander := GtPhlowTreeNodeExpander null.
	self transformation: self defaultTransformation.
]

{ #category : #testing }
GtPhlowColumnedTreeView >> isExpectedElement: aCurrentElement [
	aCurrentElement class = self elementClass ifFalse: [ ^ false ].
	aCurrentElement childrenCount = 2 ifFalse: [ ^ false ].
	(aCurrentElement childAt: 2) class = self columnedTreeClass ifFalse: [ ^ false ].
	^ true
]

{ #category : #accessing }
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
				aTree items: theItems lazy: self childrenBuilder.
				self expandTree: aTree ] 
			in: aTree ].
]
