"
I exemplify {{gtClass:GtPhlowListView}}. 


"
Class {
	#name : #GtPhlowListViewExamples,
	#superclass : #GtPhlowViewExamples,
	#traits : 'TGtPhlowSendTransformationExamples',
	#classTraits : 'TGtPhlowSendTransformationExamples classTrait',
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #'examples - auto updates' }
GtPhlowListViewExamples >> autoUpdatedView [
	<gtExample>
	| aView aListElement aCollection anAnnouncer |
	aCollection := OrderedCollection withAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aView := self emptyList items: [ aCollection ].
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | aListElement := theElement ].
	self assert: aListElement items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aCollection := aCollection copy addFirst: 100; yourself.
	
	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aListElement items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^ aView
]

{ #category : #'examples - auto updates' }
GtPhlowListViewExamples >> autoUpdatedView_InSpace [
	<gtExample>
	| aView aParent aListElement aCollection anAnnouncer aSpace |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aSpace := BlSpace new.
	aParent := BrHorizontalPane new matchParent.
	aSpace addChild: aParent.
	aView := self viewWithItems items: [ aCollection ].
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | aListElement := theElement ].
	self assert: aListElement items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aParent addChild: aListElement.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aCollection := aCollection copy addFirst: 100; yourself.

	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aParent childrenCount equals: 1.
	self assert: aParent children first == aListElement.
	self assert: aParent children first items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^ aView
]

{ #category : #'examples - auto updates' }
GtPhlowListViewExamples >> autoUpdatedView_WithParent [
	<gtExample>
	| aView aParent aListElement aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aParent := BrHorizontalPane new matchParent.
	aView := self emptyList items: [ aCollection ].
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | aListElement := theElement ].
	self assert: aListElement items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.

	aParent addChild: aListElement.
	
	aCollection := aCollection copy addFirst: 100; yourself.
	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aListElement items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^ aView
]

{ #category : #'examples - element' }
GtPhlowListViewExamples >> element [
	<gtExample>
	| aView aList |
	aView := self phlowView.
	aList := aView asElementDo: [ :theElement | theElement ].

	self assertViewElement: aList ofClass: BrSimpleList inView: aView.

	self assert: aList items size equals: 10.
	self assert: (aList items allSatisfy: [ :eachItem | eachItem isInteger ]).
	
	^ aList
]

{ #category : #'examples - support' }
GtPhlowListViewExamples >> elementItemsFor: anElement [
	"Return element items"
	<gtExample>
	^ anElement items
]

{ #category : #examples }
GtPhlowListViewExamples >> emptyList [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty list.
	aView asElementDo: [ :el | anElement := el ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	^ aView
]

{ #category : #'examples - errors' }
GtPhlowListViewExamples >> errorInItemDataBinder [
	<gtExample> 
	| aView anElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInItemDataBinderFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	self assert: anElement items size equals: 1000.
	anElement forceLayout.

	self assert: (anElement aptitude listElement childAt: 1) class equals: GtPhlowCellElement.
	self assert: (anElement aptitude listElement childAt: 1) content isNotNil.
	self assert: (anElement aptitude listElement childAt: 1) content visibility isVisible.
	self assert: (anElement aptitude listElement childAt: 1) exception isNil.

	self assert: (anElement aptitude listElement childAt: 3) class equals: GtPhlowCellElement.
	self assert: (anElement aptitude listElement childAt: 3) content isNotNil.
	self assert: (anElement aptitude listElement childAt: 3) content visibility isGone.
	self assert: (anElement aptitude listElement childAt: 3) exception isNotNil.
	self assert: (anElement aptitude listElement childAt: 3) exception visibility isVisible.
	^ aView
]

{ #category : #'examples - errors' }
GtPhlowListViewExamples >> errorInItemStencil [
	<gtExample> 
	| aView anElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInItemStencilFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	self assert: anElement items size equals: 1000.
	anElement forceLayout.

	self assert: (anElement aptitude listElement childAt: 1) class equals: GtPhlowCellElement.
	self assert: (anElement aptitude listElement childAt: 1) content isNil.
	self assert: (anElement aptitude listElement childAt: 1) exception isNotNil.
	self assert: (anElement aptitude listElement childAt: 1) exception visibility isVisible.
	^ aView
]

{ #category : #'examples - errors' }
GtPhlowListViewExamples >> errorInItemText [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInItemTextFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	self assert: anElement items size equals: 1000.
	anElement forceLayout.

	self assert: (anElement aptitude listElement childAt: 1) class equals: GtPhlowCellElement.
	self assert: (anElement aptitude listElement childAt: 1) content isNotNil.
	self assert: (anElement aptitude listElement childAt: 1) content visibility isVisible.
	self assert: (anElement aptitude listElement childAt: 1) exception isNil.

	self assert: (anElement aptitude listElement childAt: 1) content class equals: BrLabel.
	self assert: (anElement aptitude listElement childAt: 1) content text asString equals: 'Item number 1'.

	self assert: (anElement aptitude listElement childAt: 3) class equals: GtPhlowCellElement.
	self assert: (anElement aptitude listElement childAt: 3) content isNotNil.
	self assert: (anElement aptitude listElement childAt: 3) content visibility isGone.
	self assert: (anElement aptitude listElement childAt: 3) exception isNotNil.
	self assert: (anElement aptitude listElement childAt: 3) exception visibility isVisible.

	self assert: (anElement aptitude listElement childAt: 3) exception class equals: BrFrame.

	^ aView
]

{ #category : #'examples - errors' }
GtPhlowListViewExamples >> errorInItemType [
	<gtExample> 
	| aView anElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInItemTypeFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	self assert: anElement items size equals: 1000.
	anElement forceLayout.

	self assert: (anElement aptitude listElement childAt: 1) class equals: GtPhlowCellElement.
	self assert: (anElement aptitude listElement childAt: 1) content isNotNil.
	self assert: (anElement aptitude listElement childAt: 1) content visibility isVisible.
	self assert: (anElement aptitude listElement childAt: 1) exception isNil.

	self assert: (anElement aptitude listElement childAt: 3) class equals: GtPhlowCellElement.
	self assert: (anElement aptitude listElement childAt: 3) content isNil.
	self assert: (anElement aptitude listElement childAt: 3) exception isNotNil.
	self assert: (anElement aptitude listElement childAt: 3) exception visibility isVisible.
	^ aView
]

{ #category : #'examples - errors' }
GtPhlowListViewExamples >> errorInItemsWithDefaultItemTexts [
	<gtExample> 
	| aView anElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInItemsFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: BrFrame inView: aView.
	^ aView
]

{ #category : #'examples - element' }
GtPhlowListViewExamples >> expectedElementClass [
	^ BrSimpleList
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtAutoUpdatingListFor: aView [
	<gtView>
	| aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	^ aView list
		title: 'Auto updating list';
		priority: 4;
		items: [ aCollection ];
		actionButtonIcon: BrGlamorousVectorIcons add 
			action: [ aCollection add: 100 atRandom. anAnnouncer announce: Announcement new ];
		updateWhen: Announcement in: [ anAnnouncer ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtErrorInItemDataBinderFor: aView [
	<gtView>
	^ aView list 
		title: 'Error in itemDataBinder:';
		priority: 22;
		items: [ (1 to: 1000) ];
		itemStencil: [ 
			BlElement new 
				background: Color orange; 
				size: 10 @ 10; 
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c margin: (BlInsets all: 10) ]
				 ];
		itemDataBinder: [ :anElement :aNumber :anIndex |
			aNumber = 3 ifTrue: [ 
				ZeroDivide signal: 'itemDataBinder: error' ].
			anElement height: aNumber ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtErrorInItemStencilFor: aView [
	<gtView>
	^ aView list 
		title: 'Error in itemStencil:';
		priority: 25;
		items: [ (1 to: 1000) ];
		itemStencil: [ 
			ZeroDivide signal: 'itemStencil: error'. 
			BlElement new 
				background: Color orange; 
				size: 10 @ 10; 
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c margin: (BlInsets all: 10) ]
				 ];
		itemDataBinder: [ :anElement :aNumber :anIndex |
			anElement height: aNumber ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtErrorInItemTextFor: aView [
	<gtView>
	^ aView list 
		title: 'Error in itemText:';
		priority: 21;
		items: [ (1 to: 1000) ];
		itemText: [ :aNumber | 
			aNumber = 3 ifTrue: [ 
				ZeroDivide signal: 'itemText: error' ].
			'Item number ', aNumber asString ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtErrorInItemTypeFor: aView [
	<gtView>
	^ aView list 
		title: 'Error in itemType:';
		priority: 23;
		items: [ (1 to: 1000) ];
		itemType: [ :anItemTypeFactory :aNumber :anItemIndex |
			aNumber = 3 ifTrue: [ 
				ZeroDivide signal: 'itemType: error' ].
		];
		itemStencil: [ 
			BlElement new 
				background: Color orange; 
				size: 10 @ 10; 
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c margin: (BlInsets all: 10) ]
				 ];
		itemDataBinder: [ :anElement :aNumber :anIndex |
			anElement height: aNumber ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtErrorInItemsFor: aView [
	<gtView>
	^ aView list 
		title: 'Error in items:';
		priority: 20;
		items: [ ZeroDivide signal: 'items: error'. (1 to: 1000) ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtTenItemsFor: aView [
	<gtView>
	^ aView list 
		title: '10 items';
		priority: 1;
		items: [ (1 to: 10) ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtTenItemsWithContextMenuFor: aView [
	<gtView>
	^ aView list
		title: '10 items with context menu';
		priority: 1;
		items: [ 1 to: 10 ];
		contextItemLabel: 'Context Menu Action'
			action: [ :anElement | anElement inspect ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtTenLinesFor: aView [
	<gtView>
	^ aView list 
		title: '10 lines';
		priority: 3;
		items: [ (1 to: 10) ];
		itemStencil: [ 
			BlElement new 
				background: Color orange; 
				size: 10 @ 10; 
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c margin: (BlInsets all: 10) ]
				 ];
		itemDataBinder: [ :anElement :aNumber :anIndex |
			anElement height: aNumber * 5 ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtTextFor: aView [
	<gtView>
	^ aView list 
		title: 'Text items';
		priority: 2;
		items: [ (1 to: 10) ];
		itemText: [ :aNumber | 'Item number ', aNumber asString ]
]

{ #category : #'examples - text' }
GtPhlowListViewExamples >> itemText [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty on: self perform: #gtTextFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	self assert: anElement items size equals: 10.
	anElement forceLayout.
	self assert: anElement aptitude listElement childrenCount equals: 10.
	self assert: (anElement aptitude listElement childAt: 1) class equals: GtPhlowCellElement.
	self assert: (anElement aptitude listElement childAt: 1) content class equals: BrLabel.
	self assert: (anElement aptitude listElement childAt: 1) content text asString equals: 'Item number 1'.
	^ aView
]

{ #category : #'examples - text' }
GtPhlowListViewExamples >> itemsAsDefaultTexts [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty on: self perform: #gtTenItemsFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	self assert: anElement items size equals: 10.
	anElement forceLayout.
	
	self assert: anElement aptitude listElement childrenCount equals: 10.
	self assert: (anElement aptitude listElement childAt: 1) class equals: GtPhlowCellElement.
	self assert: (anElement aptitude listElement childAt: 1) content isNotNil.
	self assert: (anElement aptitude listElement childAt: 1) content visibility isVisible.
	self assert: (anElement aptitude listElement childAt: 1) exception isNil.
	
	self assert: (anElement aptitude listElement childAt: 1) content class equals: BrLabel.
	self assert: (anElement aptitude listElement childAt: 1) content text asString equals: 1 asString.
	self assert: (anElement aptitude listElement childAt: 1) content text asString equals: 1 asString.
	^ aView
]

{ #category : #'as yet unclassified' }
GtPhlowListViewExamples >> listViewContextMenuWithMultiSelection [
	<gtExample>
	| scripter view result |
	scripter := BlScripter new.
	view := self viewWithItems.
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

	self assert: result equals: {7}.
	
	^ scripter
]

{ #category : #'as yet unclassified' }
GtPhlowListViewExamples >> listViewContextMenuWithMultiSelectionAndNoExplicitSelection [
	<gtExample>
	| scripter view result |
	scripter := BlScripter new.
	view := self viewWithItems.
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
	self assert: result equals: {7}.
	
	^ scripter
]

{ #category : #'as yet unclassified' }
GtPhlowListViewExamples >> listViewContextMenuWithSingleSelection [
	<gtExample>
	| scripter view result |
	scripter := BlScripter new.
	view := self viewWithItems.
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
GtPhlowListViewExamples >> listViewContextMenuWithSingleSelectionAndNoExplicitSelection [
	<gtExample>
	| scripter view result |
	scripter := BlScripter new.
	view := self viewWithItems.
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

{ #category : #'examples - element' }
GtPhlowListViewExamples >> modifiedElement [
	<gtExample>
	| aList |
	aList := super modifiedElement.

	self assert: aList items size equals: 3.
	self assert: (aList items allSatisfy: [ :eachItem | eachItem isInteger ]).
	
	^ aList
]

{ #category : #'examples - view' }
GtPhlowListViewExamples >> modifiedPhlowView [
	<gtExample>
	| aView |
	aView := super modifiedPhlowView.
	aView items: [ (1 to: 3) asOrderedCollection ].
	^ aView
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #'examples - view' }
GtPhlowListViewExamples >> phlowView [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtTenLinesFor:.
	self assert: aView hasBuildContext.
	^ aView
]

{ #category : #'examples - support' }
GtPhlowListViewExamples >> selectItemAt: anIndex for: anElement [
	<gtExample>
	"Select an item at anIndex in anElement (list, tree)"
	anElement selectOne: 1
]

{ #category : #'examples - updating' }
GtPhlowListViewExamples >> updateOnDefiningMethodChange [
	<gtExample>
	| anElement aView anElementContext aCommand aContainer aNewElement |
	aContainer := self container.
	anElement := self modifiedElement.
	anElementContext := anElement phlow.
	aView := anElement phlow entity.
	aContainer addChild: anElement.
	
	aCommand := GtPhlowUpdateView new
		elementContext: anElement phlow.
	BlUseAsyncFeatures disableDuring: [ 
		aCommand execute ].
	
	self assert: aContainer childrenCount equals: 1.
	
	self assert: anElement phlow equals: anElementContext.
	self assert: anElement phlow entity equals: aView.

	aNewElement := aContainer childAt: 1.
	

	self assert: aNewElement ~= anElement.	
	self assert: aNewElement items size equals: 10.
	self assert: aNewElement phlow entity title equals: '10 lines'.
	
	^ aContainer
]

{ #category : #examples }
GtPhlowListViewExamples >> viewWithItems [
	<gtExample>
	| view element |
	view := self emptyList items: [ (1 to: 10) ].
	view asElementDo: [ :el | element := el ].
	self assert: element items size equals: 10.
	^ view
]

{ #category : #examples }
GtPhlowListViewExamples >> viewWithItemsAndItemElement [
	<gtExample>
	| view element |
	view := self viewWithItems 
		stencil: [ :x | 
			BlElement new background: Color orange; size: 10 @ x; margin: (BlInsets all: 10) ].
	view asElementDo: [ :el | element := el ].
	"I do not know how to assert the nature of the item elements because they are not yet rendered"
	"	self assert: element children first children size = 10."
	^ view
]

{ #category : #examples }
GtPhlowListViewExamples >> viewWithItemsAndItemElement_ProducingError [
	<gtExample>
	| aView anElement |
	aView := self viewWithItems 
		stencil: [ :x |
			Error signal. 
			BlElement new background: Color orange; size: 10 @ x; margin: (BlInsets all: 10) ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement isNotNil.
	"It does not produce an error here yet" 
	^ aView
]

{ #category : #examples }
GtPhlowListViewExamples >> viewWithItemsAndItemElement_ProducingError_InSpace [
	<gtExample>
	| aView anElement aSpace anException |
	aView := self viewWithItemsAndItemElement_ProducingError.
	aSpace := BlSpace new.
	anException := nil.
	BlUseAsyncFeatures disableDuring: [
		[ 
			aView asElementDo: [ :theElement | anElement := theElement ].
			aSpace addChild: anElement.
			aSpace pulse ] on: Error do: [ :theException | anException := theException ] ].
	"It does not produce an error here yet" 
	self assert: anException isNil.
	^ aView
]

{ #category : #examples }
GtPhlowListViewExamples >> viewWithItems_WithGetItemsError [
	<gtExample>
	| aView anElement |
	aView := self emptyList items: [ 21/0. (1 to: 10) ].
	aView asElementDo: [ :el | anElement := el ].
	self assertErrorElement: anElement inView: aView.
	^ aView
]

{ #category : #'examples - view' }
GtPhlowListViewExamples >> viewWithTenItems [
	"Return an initialized view with 10 (root) items"
	<gtExample>
	^ self viewWithItems
]
