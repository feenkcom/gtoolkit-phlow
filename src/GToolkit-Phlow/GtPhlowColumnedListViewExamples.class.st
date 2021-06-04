"
I exemplify {{gtClass:GtPhlowColumnedListView}}. 


"
Class {
	#name : #GtPhlowColumnedListViewExamples,
	#superclass : #GtPhlowViewExamples,
	#traits : 'TGtPhlowSendTransformationExamples',
	#classTraits : 'TGtPhlowSendTransformationExamples classTrait',
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #'examples - auto updates' }
GtPhlowColumnedListViewExamples >> autoUpdatedView [
	<gtExample>
	| aView anElement aCollection anAnnouncer |

	aCollection := OrderedCollection withAll: (1 to: 10).

	anAnnouncer := Announcer new.
	aView := self viewWithItems items: aCollection.
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aCollection := aCollection copy addFirst: 100; yourself.
	anAnnouncer announce: Announcement new.
	
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	^ aView
]

{ #category : #'examples - auto updates with condition' }
GtPhlowColumnedListViewExamples >> autoUpdatedViewWithCondition_False [
	<gtExample>
	| aView anElement aCollection anAnnouncer |

	aCollection := OrderedCollection withAll: (1 to: 10).

	anAnnouncer := Announcer new.
	aView := self viewWithItems items: aCollection.
	aView updateWhen: Announcement if: [ false ] in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aCollection := aCollection copy addFirst: 100; yourself.
	anAnnouncer announce: Announcement new.
	
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	^ aView
]

{ #category : #'examples - auto updates with condition' }
GtPhlowColumnedListViewExamples >> autoUpdatedViewWithCondition_False_InSpace [
	<gtExample>
	| aView aParent anElement aCollection anAnnouncer aSpace |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aSpace := BlSpace new.
	aParent := BrHorizontalPane new matchParent.
	aSpace addChild: aParent.
	aView := self viewWithItems items: [ aCollection ].
	aView updateWhen: Announcement if: [ false ] in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aParent addChild: anElement.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aCollection := aCollection copy addFirst: 100; yourself.

	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aParent childrenCount equals: 1.
	self assert: (aParent children first == anElement).
	self assert: aParent children first children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^ aView
]

{ #category : #'examples - auto updates with condition' }
GtPhlowColumnedListViewExamples >> autoUpdatedViewWithCondition_False_WithParent [
	<gtExample>
	| aView aParent anElement aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aParent := BrHorizontalPane new matchParent.
	aView := self viewWithItems items: aCollection.
	aView updateWhen: Announcement if: [ false ] in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	aParent addChild: anElement.
	aCollection := aCollection copy addFirst: 100; yourself.
	
	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	self assert: aParent childrenCount equals: 1.
	self assert: (aParent children first == anElement).
	^ aView
]

{ #category : #'examples - auto updates with condition' }
GtPhlowColumnedListViewExamples >> autoUpdatedViewWithCondition_True [
	<gtExample>
	| aView anElement aCollection anAnnouncer |

	aCollection := OrderedCollection withAll: (1 to: 10).

	anAnnouncer := Announcer new.
	aView := self viewWithItems items: aCollection.
	aView updateWhen: Announcement if: [ true ] in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aCollection := aCollection copy addFirst: 100; yourself.
	anAnnouncer announce: Announcement new.
	
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	^ aView
]

{ #category : #'examples - auto updates with condition' }
GtPhlowColumnedListViewExamples >> autoUpdatedViewWithCondition_True_InSpace [
	<gtExample>
	| aView aParent anElement aCollection anAnnouncer aSpace |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aSpace := BlSpace new.
	aParent := BrHorizontalPane new matchParent.
	aSpace addChild: aParent.
	aView := self viewWithItems items: [ aCollection ].
	aView updateWhen: Announcement if: [ true ] in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aParent addChild: anElement.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aCollection := aCollection copy addFirst: 100; yourself.

	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aParent childrenCount equals: 1.
	self assert: (aParent children first == anElement).
	self assert: aParent children first children second items size equals: 11.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^ aView
]

{ #category : #'examples - auto updates with condition' }
GtPhlowColumnedListViewExamples >> autoUpdatedViewWithCondition_True_WithParent [
	<gtExample>
	| aView aParent anElement aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aParent := BrHorizontalPane new matchParent.
	aView := self viewWithItems items: aCollection.
	aView updateWhen: Announcement if: [ true ] in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	aParent addChild: anElement.
	aCollection := aCollection copy addFirst: 100; yourself.
	
	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	self assert: aParent childrenCount equals: 1.
	self assert: (aParent children first == anElement).
	^ aView
]

{ #category : #'examples - auto updates' }
GtPhlowColumnedListViewExamples >> autoUpdatedView_InSpace [
	<gtExample>
	| aView aParent anElement aCollection anAnnouncer aSpace |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aSpace := BlSpace new.
	aParent := BrHorizontalPane new matchParent.
	aSpace addChild: aParent.
	aView := self viewWithItems items: [ aCollection ].
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aParent addChild: anElement.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aCollection := aCollection copy addFirst: 100; yourself.

	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aParent childrenCount equals: 1.
	self assert: (aParent children first == anElement).
	self assert: aParent children first children second items size equals: 11.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^ aView
]

{ #category : #'examples - auto updates' }
GtPhlowColumnedListViewExamples >> autoUpdatedView_WithParent [
	<gtExample>
	| aView aParent anElement aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aParent := BrHorizontalPane new matchParent.
	aView := self viewWithItems items: aCollection.
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	aParent addChild: anElement.
	aCollection := aCollection copy addFirst: 100; yourself.
	
	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: anElement children second items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	self assert: aParent childrenCount equals: 1.
	self assert: (aParent children first == anElement).
	^ aView
]

{ #category : #'examples - text' }
GtPhlowColumnedListViewExamples >> columnItemView [
	<gtExample>
	| aView anElement aColumnedList aCellElement |
	aView := GtPhlowView empty on: self perform: #gtTenItemsWithColumnItemsFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.

	aColumnedList := anElement childAt: 2.
	self assert: aColumnedList class equals: BrColumnedList.
	self assert: aColumnedList items size equals: 10.
	
	anElement forceLayout.
	self assert: aColumnedList aptitude listElement childrenCount equals: 10.
	
	aCellElement := (aColumnedList aptitude listElement childAt: 1) childAt: 1.
	
	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content class equals: BrLabel.
	self assert: aCellElement content text asString equals: '1'.
	^ aView
]

{ #category : #'examples - support' }
GtPhlowColumnedListViewExamples >> elementItemsFor: anElement [
	"Return element items"

	<gtExample>
	| aListElement |
	aListElement := self listElementFor: anElement.
	^ aListElement items
]

{ #category : #'api-shortcuts' }
GtPhlowColumnedListViewExamples >> emptyList [
	<gtExample>
	| view element |
	view := GtPhlowView empty columnedList.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BlElement).
	self assert: (element children size = 2).
	self assert: (element children second isKindOf: BrColumnedList).
	self assert: element phlow isView.
	self assert: element phlow entity = view.
	^ view
]

{ #category : #'examples - errors' }
GtPhlowColumnedListViewExamples >> errorInColumnDoCellStencil [
	<gtExample> 
	| aView anElement aColumnedList aCellElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInColumnDoCellStencilFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	aColumnedList := anElement childAt: 2.
	self assert: aColumnedList items size equals: 1000.
	anElement forceLayout.
	
	aCellElement := (aColumnedList aptitude listElement childAt: 1) childAt: 1.

	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content isNil.
	self assert: aCellElement exception isNotNil.
	self assert: aCellElement exception visibility isVisible.
	^ aView
]

{ #category : #'examples - errors' }
GtPhlowColumnedListViewExamples >> errorInColumnDoDataBinder [
	<gtExample> 
	| aView anElement aColumnedList aCellElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInColumnDoDataBinderFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	aColumnedList := anElement childAt: 2.
	self assert: aColumnedList items size equals: 1000.
	anElement forceLayout.

	aCellElement := (aColumnedList aptitude listElement childAt: 1) childAt: 1.

	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content isNotNil.
	self assert: aCellElement content visibility isVisible.
	self assert: aCellElement exception isNil.

	aCellElement := (aColumnedList aptitude listElement childAt: 3) childAt: 1.

	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content isNotNil.
	self assert: aCellElement content visibility isGone.
	self assert: aCellElement exception isNotNil.
	self assert: aCellElement exception visibility isVisible.
	^ aView
]

{ #category : #'examples - errors' }
GtPhlowColumnedListViewExamples >> errorInColumnIcon [
	<gtExample> 
	| aView anElement aColumnedList aCellElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInColumnIcon:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	aColumnedList := anElement childAt: 2.
	self assert: aColumnedList items size > 3.
	anElement forceLayout.

	aCellElement := (aColumnedList aptitude listElement childAt: 1) childAt: 1.

	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content isNotNil.
	self assert: aCellElement content visibility isVisible.
	self assert: aCellElement exception isNil.

	aCellElement := (aColumnedList aptitude listElement childAt: 3) childAt: 1.

	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content isNotNil.
	self assert: aCellElement content visibility isGone.
	self assert: aCellElement exception isNotNil.
	self assert: aCellElement exception visibility isVisible.

	aCellElement := (aColumnedList aptitude listElement childAt: 3) childAt: 2.

	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content isNotNil.
	self assert: aCellElement content visibility isVisible.
	self assert: aCellElement exception isNil.

	^ aView
]

{ #category : #'examples - errors' }
GtPhlowColumnedListViewExamples >> errorInColumnText [
	<gtExample> 
	| aView anElement aColumnedList aCellElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInColumnTextFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	aColumnedList := anElement childAt: 2.
	self assert: aColumnedList items size equals: 1000.
	anElement forceLayout.

	aCellElement := (aColumnedList aptitude listElement childAt: 1) childAt: 1.

	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content isNotNil.
	self assert: aCellElement content visibility isVisible.
	self assert: aCellElement exception isNil.

	aCellElement := (aColumnedList aptitude listElement childAt: 3) childAt: 1.

	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content isNotNil.
	self assert: aCellElement content visibility isGone.
	self assert: aCellElement exception isNotNil.
	self assert: aCellElement exception visibility isVisible.

	aCellElement := (aColumnedList aptitude listElement childAt: 3) childAt: 2.

	self assert: aCellElement class equals: GtPhlowCellElement.
	self assert: aCellElement content isNotNil.
	self assert: aCellElement content visibility isVisible.
	self assert: aCellElement exception isNil.

	^ aView
]

{ #category : #'examples - errors' }
GtPhlowColumnedListViewExamples >> errorInItems [
	<gtExample> 
	| aView anElement |
	aView := GtPhlowView empty on: self perform: #gtErrorInItemsFor:.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aView asElementDo: [ :theElement | theElement ] ].
	self assertViewElement: anElement ofClass: BrFrame inView: aView.
	^ aView
]

{ #category : #'examples - element' }
GtPhlowColumnedListViewExamples >> expectedElementClass [
	^ BlElement
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtAutoUpdatingListFor: aView [
	<gtView>
	| aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	^ aView columnedList
		title: 'Auto Updating List';
		priority: 15;
		items: [ aCollection ];
		column: 'x' item: [ :x | x ];
		column: 'x * x' item: [ :x | x * x ];
		actionButtonIcon: BrGlamorousVectorIcons add 
			tooltip: 'Add an item'
			action: [ aCollection add: 100 atRandom. anAnnouncer announce: Announcement new ];
		updateWhen: Announcement in: [ anAnnouncer ]
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtColorsWithColumnIconFor: aView [
	<gtView>
	^ aView columnedList
		title: 'column:icon: usage';
		priority: 7;
		items: [ self registeredColors ];
		column: 'Icon' 
			icon: [ :aColor |
				BlElement new
					padding: (BlInsets all: 6);
					margin: (BlInsets top: 3 left: 0 bottom: 3 right: 0);
					background: aColor;
					geometry: BlCircle new;
					layout: BlLinearLayout horizontal alignCenter;
					constraintsDo: [ :c |
						c horizontal fitContent.
						c vertical fitContent ] ];
		column: 'Name' item: #name
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtColorsWithColumnIconWidthFor: aView [
	<gtView>
	^ aView columnedList
		title: 'column:icon:width: usage';
		priority: 7;
		items: [ self registeredColors reversed ];
		column: 'Icon' 
			icon: [ :aColor |
				BlElement new
					padding: (BlInsets all: 6);
					margin: (BlInsets top: 3 left: 0 bottom: 3 right: 0);
					background: aColor;
					geometry: BlCircle new;
					layout: BlLinearLayout horizontal alignCenter;
					constraintsDo: [ :c |
						c horizontal fitContent.
						c vertical fitContent ] ] 
			width: 36;
		column: 'Name' item: #name
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtColorsWithColumnItemIconWidthFor: aView [
	<gtView>
	^ aView columnedList
		title: 'column:item:icon:width: usage';
		priority: 6;
		items: [ self registeredColors ];
		column: 'Icon' 
			item: [ :aColor | aColor ] 
			icon: [ :aColor |
				BlElement new
					padding: (BlInsets all: 6);
					margin: (BlInsets top: 3 left: 0 bottom: 3 right: 0);
					background: aColor;
					geometry: BlCircle new;
					layout: BlLinearLayout horizontal alignCenter;
					constraintsDo: [ :c |
						c horizontal fitContent.
						c vertical fitContent ] ] 
			width: 36;
		column: 'Name' item: #name
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtErrorInColumnDoCellStencilFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Error in cellStencil:';
		priority: 21;
		items: [ (1 to: 1000) ];
		column: 'Rectangle' do: [ :aColumn |
			aColumn
				cellStencil: [ 
					ZeroDivide signal: 'cellStencil: error'. 
					BlElement new 
						background: Color orange; 
						size: 10 @ 10; 
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c margin: (BlInsets all: 10) ] ];
				dataBinder: [ :anElement :aNumber :anIndex |
					anElement height: aNumber ] ]
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtErrorInColumnDoDataBinderFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Error in dataBinder:';
		priority: 22;
		items: [ (1 to: 1000) ];
		column: 'Rectangle' do: [ :aColumn |
			aColumn
				cellStencil: [ 
					BlElement new 
						background: Color orange; 
						size: 10 @ 10; 
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c margin: (BlInsets all: 10) ] ];
				dataBinder: [ :anElement :aNumber :anIndex |
					aNumber = 3 ifTrue: [ ZeroDivide signal: 'cellStencil: error'. ].
					anElement height: aNumber ] ]
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtErrorInColumnIcon: aView [
	<gtView>
	^ aView columnedList
		title: 'Error in column:icon:';
		priority: 25;
		items: [ self registeredColors ];
		column: 'Icon' 
			icon: [ :aColor :aRowIndex |
				aRowIndex = 3 ifTrue: [ ZeroDivide signal: 'column:icon: error'. ].
				BlElement new
					padding: (BlInsets all: 6);
					margin: (BlInsets top: 3 left: 0 bottom: 3 right: 0);
					background: aColor;
					geometry: BlCircle new;
					layout: BlLinearLayout horizontal alignCenter;
					constraintsDo: [ :c |
						c horizontal fitContent.
						c vertical fitContent ] ];
		column: 'Name' item: #name
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtErrorInColumnTextFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Error in column:text:';
		priority: 24;
		items: [ (1 to: 1000) ];
		column: 'x' text: [ :x | 
			x = 3 ifTrue: [ ZeroDivide signal: 'column:text: error' ].
			'Base ', x asString ];
		column: 'x * x' text: [ :x | 'Square ', (x * x) asString ]
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtErrorInItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Error in items:';
		priority: 20;
		items: [ ZeroDivide signal: 'items: error'. (1 to: 1000) ];
		column: 'x' text: [ :x | 'Base ', x asString ];
		column: 'x * x' text: [ :x | 'Square ', (x * x) asString ]
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtTenItemsWithColumnItemFormatFor: aView [
	<gtView>
	^ aView columnedList
		title: 'column:item:text: usage';
		priority: 3;
		items: [ 1 to: 10 ];
		column: 'x' item: [ :x | 2 * x ] text: [ :x | 'Base ', x asString ];
		column: 'x * x' item: [ :x | 4 * x * x ] text: [ :squared | 'Square ', squared asString ]
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtTenItemsWithColumnItemFormatWidthFor: aView [
	<gtView>
	^ aView columnedList
		title: 'column:item:text:width: usage';
		priority: 4;
		items: [ 1 to: 10 ];
		column: 'x' item: [ :x | x ] text: [ :x | 'Base ', x asString ] width: 100;
		column: 'x * x' item: [ :x | x * x ] text: [ :squared | 'Square ', squared asString ] width: 100
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtTenItemsWithColumnItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'column:item: usage';
		priority: 1;
		items: [ 1 to: 10 ];
		column: 'x' item: [ :x | x ];
		column: 'x * x' item: [ :x | x * x ]
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> gtTenItemsWithColumnTextFor: aView [
	<gtView>
	^ aView columnedList
		title: 'column:text: usage';
		priority: 2;
		items: [ 1 to: 10 ];
		column: 'x' text: [ :x | 'Base ', x asString ];
		column: 'x * x' text: [ :x | 'Square ', (x * x) asString ]
]

{ #category : #'examples - support' }
GtPhlowColumnedListViewExamples >> listElementFor: anElement [
	| aListElement |
	aListElement := anElement childAt: 2.
	self assert: aListElement class equals: BrColumnedList.
	^ aListElement
]

{ #category : #'gt-extensions' }
GtPhlowColumnedListViewExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #'examples - view' }
GtPhlowColumnedListViewExamples >> phlowView [
	<gtExample>
	^ self viewWithItems
]

{ #category : #accessing }
GtPhlowColumnedListViewExamples >> registeredColors [
	<gtExample>
	| aCollection |
	aCollection := Color registeredColorNames collect: [ :aColorName | Color named: aColorName ].
	self assert: aCollection isNotNil.
	self assert: aCollection isNotEmpty.
	^ aCollection
]

{ #category : #'examples - support' }
GtPhlowColumnedListViewExamples >> selectItemAt: anIndex for: anElement [
	<gtExample>
	"Select an item at anIndex in anElement (list, tree)"
	| aListElement |
	aListElement := self listElementFor: anElement.
	aListElement selectOne: anIndex.
	self assert: (aListElement isSelectedAt: anIndex).
]

{ #category : #'examples - transformation' }
GtPhlowColumnedListViewExamples >> sendTool [
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

{ #category : #'api-shortcuts' }
GtPhlowColumnedListViewExamples >> viewWithItems [
	<gtExample>
	| view element |
	view := self emptyList
		items: [ 1 to: 100 ];
		column: 'x' item: [ :number | number ];
		column: 'x * 2' translated item: [ :number | number * 2 ].
	view asElementDo: [ :el | element := el ].
	self assert: element children second items size = 100.
	^ view
]

{ #category : #'api-shortcuts' }
GtPhlowColumnedListViewExamples >> viewWithItemsWithColumnCreationError [
	<gtExample>
	| view element |
	view := self viewWithItems
		column: 'Error' translated
		item: [ :number | number * 4 / 0 ].
	view asElementDo: [ :el | element := el ].
	self assert: element children second items size = 100.
	^ view
]

{ #category : #'api-shortcuts' }
GtPhlowColumnedListViewExamples >> viewWithItemsWithItemsError [
	<gtExample>
	| view element |
	view := self viewWithItems 
		items: [ 3/0. (1 to: 100) ].
	view asElementDo: [ :el | element := el ].
	self assert: element childrenCount equals: 1.
	^ view
]

{ #category : #'examples - view' }
GtPhlowColumnedListViewExamples >> viewWithTenItems [
	"Return an initialized view with 10 (root) items"
	<gtExample>
	^ self viewWithItems
		items: [ 1 to: 10 ]
]
