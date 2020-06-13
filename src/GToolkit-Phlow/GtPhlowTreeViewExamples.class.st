Class {
	#name : #GtPhlowTreeViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'examples - auto updates' }
GtPhlowTreeViewExamples >> autoUpdatedView_InSpace [
	<gtExample>
	| aView aParent anElement aCollection anAnnouncer aSpace |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aSpace := BlSpace new.
	aParent := BrHorizontalPane new matchParent.
	aSpace addChild: aParent.
	
	aView := self treeViewWithItemsAndChildren items: [ aCollection ].
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	
	self assert: anElement viewModel root children size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aParent addChild: anElement.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aCollection := aCollection copy addFirst: 100; yourself.

	BlUseAsyncFeatures disableDuring: [ anAnnouncer announce: Announcement new ].
	
	self assert: aParent childrenCount equals: 1.
	self assert: aParent children first == anElement.
	self assert: aParent children first viewModel root children size equals: 11.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^ aView
]

{ #category : #'examples - auto updates' }
GtPhlowTreeViewExamples >> autoUpdatedView_InSpace_WithChildrenError [
	<gtExample>
	<noTest>
	| aView aParent anElement aCollection anAnnouncer aSpace |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aSpace := BlSpace new.
	aParent := BrHorizontalPane new matchParent.
	aSpace addChild: aParent.
	aView := self treeViewWithItemsAndChildren items: [ aCollection ].
	aView children: [ :aNumber | { 1 / aNumber * aNumber } ].
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement viewModel root children size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aParent addChild: anElement.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aCollection := aCollection copy addFirst: 0; yourself.

	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aParent childrenCount equals: 1.
	self assert: aParent children first == anElement.
	self assert: aParent children first viewModel root children size equals: 11.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^ aView
]

{ #category : #'examples - auto updates' }
GtPhlowTreeViewExamples >> autoUpdatedView_WithParent [
	<gtExample>
	| aView aParent anElement aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aParent := BrHorizontalPane new matchParent.
	aView := self treeViewWithItemsAndChildren items: aCollection.
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement viewModel root children size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	aParent addChild: anElement.
	
	aCollection := aCollection copy addFirst: 100; yourself.
	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: anElement viewModel root children size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	^ aView
]

{ #category : #'examples - tree view' }
GtPhlowTreeViewExamples >> emptyTree [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty tree.
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assertViewElement: anElement ofClass: BrColumnedTree inView: aView.
	^ aView
]

{ #category : #'gt-extension' }
GtPhlowTreeViewExamples >> gtAutoUpdatingTreeFor: aView [
	<gtView>
	| aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	^ aView tree
		title: 'Auto Updating List';
		items: [ aCollection ];
		children: [ :aNumber | aNumber // 2 to: aNumber ];
		actionButtonIcon: BrGlamorousVectorIcons add 
			action: [ aCollection add: 100 atRandom. anAnnouncer announce: Announcement new ];
		updateWhen: Announcement in: [ anAnnouncer ]
]

{ #category : #'gt-extension' }
GtPhlowTreeViewExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #'examples - updating' }
GtPhlowTreeViewExamples >> phlowView [
	<gtExample>
	^ self treeViewWithItemsAndChildren
]

{ #category : #'examples - tree view' }
GtPhlowTreeViewExamples >> treeViewWithItems [
	<gtExample>
	| aView anElement |
	aView := self emptyTree.
	aView items: [ 1 to: 10 ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assertViewElement: anElement ofClass: BrColumnedTree inView: aView.
	self assert: anElement viewModel root children size equals: 10.
	^ aView
]

{ #category : #'examples - tree view' }
GtPhlowTreeViewExamples >> treeViewWithItemsAndChildren [
	<gtExample>
	| aView anElement |
	aView := self treeViewWithItems.
	aView children: [ :aNumber | aNumber // 2 to: aNumber ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assertViewElement: anElement ofClass: BrColumnedTree inView: aView.
	self assert: anElement viewModel root children size equals: 10.
	^ aView
]

{ #category : #'examples - tree view' }
GtPhlowTreeViewExamples >> treeViewWithItemsAndChildrenWithChildrenError [
	<gtExample>
	| aView anElement |
	aView := self treeViewWithItems.
	aView children: [ :aNumber | 3/0. aNumber // 2 to: aNumber ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement class equals: BrFrame.
	^ aView
]

{ #category : #'examples - tree view' }
GtPhlowTreeViewExamples >> treeViewWithItemsWithItemsError [
	<gtExample>
	| aView anElement |
	aView := self emptyTree.
	aView items: [ 3/0. 1 to: 10 ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement class equals: BrFrame.
	^ aView
]
