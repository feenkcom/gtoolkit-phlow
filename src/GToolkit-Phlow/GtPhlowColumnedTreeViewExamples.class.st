Class {
	#name : #GtPhlowColumnedTreeViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #'examples - columned tree view' }
GtPhlowColumnedTreeViewExamples >> columnedTreeViewWithItems [
	<gtExample>
	| aView anElement |
	aView := self emptyColumnedTreeView.
	aView items: [ 1 to: 10 ].
	aView column: 'x' item: [ :aNumber | aNumber ].
	aView column: 'x * x' item: [ :aNumber | aNumber * aNumber ].
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
	self assert: anElement class equals: BrFrame.
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
		column: 'x' item: [ :aNumber | aNumber ];
		column: 'x * x' item: [ :aNumber | aNumber * aNumber ];
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
		column: 'x' item: [ :aNumber | aNumber ];
		column: 'x * x' item: [ :aNumber | aNumber * aNumber ]
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
