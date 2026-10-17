Class {
	#name : #GtPhlowColumnedTreeViewExamples,
	#superclass : #GtPhlowViewExamples,
	#traits : 'TGtPhlowSendTransformationExamples',
	#classTraits : 'TGtPhlowSendTransformationExamples classTrait',
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #examples }
GtPhlowColumnedTreeViewExamples >> columnHeadersAlignWithCellsAfterResizing [
	<gtExample>
	| s |
	s := self columnedTreeViewColumnResizing.
	s assertStep: [ :step |
		step label: 'Headers and body cells have matching column boundaries after resizing';
			satisfies: [ :container |
				| header cells headers |
				header := (container query // GtPhlowColumnedListHeaderId) anyOne.
				headers := header children asArray.
				cells := (container query // GtPhlowCellElement) all asArray.
				headers size = 2 and: [ cells notEmpty and: [
					(1 to: cells size) allSatisfy: [ :index |
						| cell columnHeader |
						cell := cells at: index.
						columnHeader := headers at: ((index - 1) \\ 2 + 1).
						(cell bounds inSpace asRectangle left - columnHeader bounds inSpace asRectangle left) abs < 1
							and: [ (cell width - columnHeader width) abs < 1 ] ] ] ] ] ].
	^ s
]

{ #category : #accessing }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewColumnResizing [
	<gtExample>
	| scripter |
	scripter := BlScripter new.
	scripter element: self columnedTreeViewWithItemsAndChildren asElement.
	scripter
		assertStep: [ :s | 
			s
				label: 'Check initial column widths';
				satisfies: [ :tree | 
					tree columns
						allSatisfy: [ :each | each columnWidth isKindOf: BrColumnProportionalWidth ] ];
				// BrColumnedTree ].
	scripter
		substep: 'Move first column resizer'
		do: [ :aStep | 
			aStep mouseMoveOver id: #'x-resizer'.
			aStep mouseDown.
			aStep mouseMove by: -50 @ 0.
			aStep mouseUp.
			aStep play ].
	scripter
		assertStep: [ :s | 
			s
				label: 'Check moved column widths';
				satisfies: [ :tree | 
					(tree columns first columnWidth isKindOf: BrColumnFixedWidth)
						and: [ tree columns second columnWidth isKindOf: BrColumnProportionalWidth ] ];
				// BrColumnedTree ].
	^ scripter
]

{ #category : #'as yet unclassified' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewContextMenuWithMultiSelection [
	<gtExample>
	| scripter view result |
	scripter := BlScripter new.
	view := self columnedTreeViewWithItemsAndChildren.
	view withMultipleSelection.
	view contextItemLabel: 'Itself' action: [ :element :each | result := each ].
	scripter element: view asElement.
	scripter click
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		play.

	scripter menuStep
		openContextMenu;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		@ 1;
		play.

	scripter menuStep
		clickMenuItemWithId: [ :anElement | (anElement isKindOf: BrLabel) and: [ anElement text asString = 'Itself' ] ];
		onMenuContainer;
		play.

	self assert: result isCollection.
	self assert: result equals: {7}.

	^ scripter
]

{ #category : #'as yet unclassified' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewContextMenuWithMultiSelectionAndNoExplicitSelection [
	<gtExample>
	| scripter view result |
	scripter := BlScripter new.
	view := self columnedTreeViewWithItemsAndChildren.
	view withMultipleSelection.
	view contextItemLabel: 'Itself' action: [ :element :each | result := each ].
	scripter element: view asElement.
	
	"We do not select anything first"
	
	scripter menuStep
		openContextMenu;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		@ 1;
		play.

	scripter menuStep
		clickMenuItemWithId: [ :anElement | (anElement isKindOf: BrLabel) and: [ anElement text asString = 'Itself' ] ];
		onMenuContainer;
		play.

	"But we still get the target in the menu"
	self assert: result isCollection.
	self assert: result equals: {7}.

	^ scripter
]

{ #category : #'as yet unclassified' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewContextMenuWithSingleSelection [
	<gtExample>
	| scripter view result |
	scripter := BlScripter new.
	view := self columnedTreeViewWithItemsAndChildren.
	view contextItemLabel: 'Itself' action: [ :element :each | result := each ].
	scripter element: view asElement.
	scripter click
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		play.

	scripter menuStep
		openContextMenu;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		@ 1;
		play.

	scripter menuStep
		clickMenuItemWithId: [ :anElement | (anElement isKindOf: BrLabel) and: [ anElement text asString = 'Itself' ] ];
		onMenuContainer;
		play.

	self assert: result equals: 7.

	^ scripter
]

{ #category : #'as yet unclassified' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewContextMenuWithSingleSelectionAndClickOnAnotherItem [
	<gtExample>
	| scripter view result |
	scripter := BlScripter new.
	view := self columnedTreeViewWithItemsAndChildren.
	view contextItemLabel: 'Itself' action: [ :element :each | result := each ].
	scripter element: view asElement.
	scripter click
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		play.

	scripter menuStep
		openContextMenu;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '8' ];
		@ 1;
		play.

	scripter menuStep
		clickMenuItemWithId: [ :anElement | (anElement isKindOf: BrLabel) and: [ anElement text asString = 'Itself' ] ];
		onMenuContainer;
		play.

	"We do not want to explicitly select, to be able to open a context menu of another item"
	self assert: result equals: 8.

	^ scripter
]

{ #category : #'as yet unclassified' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewContextMenuWithSingleSelectionAndNoExplicitSelection [
	<gtExample>
	| scripter view result |
	scripter := BlScripter new.
	view := self columnedTreeViewWithItemsAndChildren.
	view contextItemLabel: 'Itself' action: [ :element :each | result := each ].
	scripter element: view asElement.
	
	"We do not select anything first"

	scripter menuStep
		openContextMenu;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		@ 1;
		play.

	scripter menuStep
		clickMenuItemWithId: [ :anElement | (anElement isKindOf: BrLabel) and: [ anElement text asString = 'Itself' ] ];
		onMenuContainer;
		play.

	"But we still get the target in the menu"
	self assert: result equals: 7.

	^ scripter
]

{ #category : #examples }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewWithItems [
	<gtExample>
	| aView anElement |
	aView := self emptyColumnedTreeView.
	aView items: [ 1 to: 10 ].
	aView column: 'x' text: [ :number | number ].
	aView column: 'x * x' text: [ :number | number * number ].
	aView asElementDo: [ :element | anElement := element ].
	self assert: (anElement isKindOf: BlElement).
	self assert: (self listElementFor: anElement) viewModel root childrenValues size equals: 10.
	^ aView
]

{ #category : #examples }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewWithItemsAndChildren [
	<gtExample>
	| aView anElement |
	aView := self columnedTreeViewWithItems.
	aView items: [ 1 to: 10 ].
	aView children: [ :number | number < 3 ifTrue: [ #() ] ifFalse: [ 1 to: number - 1 ] ].
	aView asElementDo: [ :element | anElement := element ].
	self assert: (anElement isKindOf: BlElement).
	self assert: (self listElementFor: anElement) viewModel root childrenValues size equals: 10.
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

{ #category : #examples }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewWithNoColumns [
	<gtExample>
	| aView anElement |
	aView := self emptyColumnedTreeView.
	aView items: [ 1 to: 10 ].
	aView asElementDo: [ :element | anElement := element ].
	self assert: (anElement isKindOf: BlElement).
	self assert: (self listElementFor: anElement) viewModel root childrenValues size equals: 10.
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
	self assert: anElement phlow isViewTitle not.
	self assert: anElement phlow isViewContent.
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
		title: 'Auto updating tree';
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
		title: 'Numbers weith context menu';
		priority: 1;
		items: [ 1 to: 10 ];
		children: [ :aNumber | aNumber // 2 to: aNumber ];
		column: 'x' text: [ :aNumber | aNumber ];
		column: 'x * x' text: [ :aNumber | aNumber * aNumber ];
		contextItemLabel: 'Context Menu Action' action: [ :anElement | anElement inspect ]
]

{ #category : #helpers }
GtPhlowColumnedTreeViewExamples >> listElementFor: anElement [
	^ (anElement query // BrColumnedTree) anyOne
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

{ #category : #examples }
GtPhlowColumnedTreeViewExamples >> sortableColumnHeader [
	<gtExample>
	| view s |
	view := GtPhlowView empty columnedTree.
	view
		items: [ #(20 10) ];
		children: [ :item | item = 20 ifTrue: [ #(4 3) ] ifFalse: [ #() ] ];
		expandAll.
	view
		column: 'Number'
		do: [ :column | 
			column
				text: #yourself;
				sortBy: [ :a :b | a <= b ] ].
	s := BlScripter new element: view asElement.
	s
		clickStep: [ :step | 
			step
				label: 'Sort tree siblings ascending';
				// BrLabel;
				@ [ :label | label text asString = 'Number' ] ].
	s
		assertStep: [ :step | 
			step
				label: 'Hierarchy retained in ascending order';
				// BrColumnedTree;
				value: [ :tree | 
						((1 to: tree viewModel itemCount) collect: [ :i | (tree nodeAt: i) value ])
							asArray ]
					equals: [ #(10 20 3 4) ] ].
	s
		clickStep: [ :step | 
			step
				label: 'Reverse via sort icon';
				id: #columnSortIcon ].
	s
		assertStep: [ :step | 
			step
				label: 'Hierarchy retained in descending order';
				// BrColumnedTree;
				value: [ :tree | 
						((1 to: tree viewModel itemCount) collect: [ :i | (tree nodeAt: i) value ])
							asArray ]
					equals: [ #(20 4 3 10) ] ].
	^ s
]

{ #category : #'examples - view' }
GtPhlowColumnedTreeViewExamples >> viewWithTenItems [
	"Return an initialized view with 10 (root) items"
	<gtExample>
	^ self columnedTreeViewWithItemsAndChildren
]
