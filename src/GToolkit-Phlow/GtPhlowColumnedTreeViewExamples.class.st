Class {
	#name : #GtPhlowColumnedTreeViewExamples,
	#superclass : #GtPhlowViewExamples,
	#traits : 'TGtPhlowSendTransformationExamples',
	#classTraits : 'TGtPhlowSendTransformationExamples classTrait',
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #'examples - columned tree view' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewWithItems [
	<gtExample>
	| aView anElement |
	aView := self emptyColumnedTreeView.
	aView items: [ 1 to: 10 ].
	aView column: 'x' text: [ :aNumber | aNumber ].
	aView column: 'x * x' text: [ :aNumber | aNumber * aNumber ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BlElement).
	self
		assert: anElement children second viewModel root childrenValues size
		equals: 10.
	^ aView
]

{ #category : #'examples - columned tree view' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewWithItemsAndChildren [
	<gtExample>
	| aView anElement |
	aView := self columnedTreeViewWithItems.
	aView items: [ 1 to: 10 ].
	aView
		children: [ :aNumber | 
			aNumber < 3
				ifTrue: [ #() ]
				ifFalse: [ 1 to: aNumber - 1 ] ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BlElement).
	self
		assert: anElement children second viewModel root childrenValues size
		equals: 10.
	^ aView
]

{ #category : #'examples - columned tree view' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewWithItemsAndChildren_WithChildrenError [
	<gtExample>
	| aView anElement |
	aView := self columnedTreeViewWithItems.
	aView expandOneLevel.
	aView items: [ 1 to: 10 ].
	aView children: [ :aNumber | 21/0. aNumber < 3 ifTrue: [ #() ] ifFalse: [ 1 to: (aNumber - 1) ] ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement class equals: BlElement.
	^ aView
]

{ #category : #'examples - columned tree view' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewWithItems_WithItemsError [
	<gtExample>
	| aView anElement |
	aView := self columnedTreeViewWithItems.
	aView items: [ 4/0. 1 to: 10 ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement class equals: BrFrame.
	^ aView
]

{ #category : #'examples - support' }
GtPhlowColumnedTreeViewExamples >> elementItemsFor: anElement [
	"Return element items"

	<gtExample>
	| aListElement |
	aListElement := self listElementFor: anElement.
	^ aListElement viewModel root childrenValues
]

{ #category : #'examples - columned tree view' }
GtPhlowColumnedTreeViewExamples >> emptyColumnedTreeView [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty columnedTree.
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: anElement phlow isView.
	self assert: anElement phlow entity equals: aView.
	^ aView
]

{ #category : #'examples - element' }
GtPhlowColumnedTreeViewExamples >> expectedElementClass [
	^ BlElement
]

{ #category : #'gt-extension' }
GtPhlowColumnedTreeViewExamples >> gtAutoUpdatingTreeFor: aView [
	<gtView>
	| aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	^ aView columnedTree
		title: 'Auto Updating Tree';
		priority: 15;
		items: [ aCollection ];
		children: [ :aNumber | aNumber // 2 to: aNumber ];
		column: 'x' text: [ :aNumber | aNumber ];
		column: 'x * x' text: [ :aNumber | aNumber * aNumber ];
		actionButtonIcon: BrGlamorousVectorIcons add 
			action: [ aCollection add: 100 atRandom. anAnnouncer announce: Announcement new ];
		updateWhen: Announcement in: [ anAnnouncer ]
]

{ #category : #'gt-extension' }
GtPhlowColumnedTreeViewExamples >> gtNumbersFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Numbers';
		priority: 1;
		items: [ 1 to: 10 ];
		children: [ :aNumber | aNumber // 2 to: aNumber ];
		column: 'x' text: [ :aNumber | aNumber ];
		column: 'x * x' text: [ :aNumber | aNumber * aNumber ]
]

{ #category : #'gt-extension' }
GtPhlowColumnedTreeViewExamples >> gtNumbersWithContextMenuFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Numbers weith Context Menu';
		priority: 1;
		items: [ 1 to: 10 ];
		children: [ :aNumber | aNumber // 2 to: aNumber ];
		column: 'x' text: [ :aNumber | aNumber ];
		column: 'x * x' text: [ :aNumber | aNumber * aNumber ];
		contextItemLabel: 'Context Menu Action' action: [ :anElement | anElement halt ]
]

{ #category : #'examples - support' }
GtPhlowColumnedTreeViewExamples >> listElementFor: anElement [
	| aListElement |
	aListElement := anElement childAt: 2.
	self assert: aListElement class equals: BrColumnedTree.
	^ aListElement
]

{ #category : #'gt-extension' }
GtPhlowColumnedTreeViewExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #'examples - view' }
GtPhlowColumnedTreeViewExamples >> phlowView [
	<gtExample>
	^ self columnedTreeViewWithItemsAndChildren
]

{ #category : #'examples - support' }
GtPhlowColumnedTreeViewExamples >> selectItemAt: anIndex for: anElement [
	<gtExample>
	"Select an item at anIndex in anElement (list, tree)"
	| aListElement |
	aListElement := self listElementFor: anElement.
	aListElement selectOne: anIndex.
	self assert: (aListElement isSelectedAt: anIndex).
]

{ #category : #'examples - transformation' }
GtPhlowColumnedTreeViewExamples >> sendTool [
	<gtExample>
	| view element |
	view := self viewWithTenItems.
	view sendTool: [ :aNumber | GtPhlowValuableTool new
		valuable: [ BrFrame new
			labeled: 'tool';
			matchParent;
			alignCenter;
			addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aNumber;
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ]) ] ].
	view asElementDo: [ :el | element := el ].
	self itemsFor: element ofSize: 10.
	^ view
]

{ #category : #'examples - view' }
GtPhlowColumnedTreeViewExamples >> viewWithTenItems [
	"Return an initialized view with 10 (root) items"
	<gtExample>
	^ self columnedTreeViewWithItemsAndChildren
]
