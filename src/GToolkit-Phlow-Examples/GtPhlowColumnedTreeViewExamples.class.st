Class {
	#name : #GtPhlowColumnedTreeViewExamples,
	#superclass : #GtPhlowViewExamples,
	#traits : 'TGtPhlowSendTransformationExamples',
	#classTraits : 'TGtPhlowSendTransformationExamples classTrait',
	#category : #'GToolkit-Phlow-Examples-Views'
}

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

{ #category : #'examples - columned tree view' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewWithNoColumns [
	<gtExample>
	| aView anElement |
	aView := self emptyColumnedTreeView.
	aView items: [ 1 to: 10 ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BlElement).
	self
		assert: anElement children second viewModel root childrenValues size
		equals: 10.
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

{ #category : #'examples - view' }
GtPhlowColumnedTreeViewExamples >> viewWithTenItems [
	"Return an initialized view with 10 (root) items"
	<gtExample>
	^ self columnedTreeViewWithItemsAndChildren
]
