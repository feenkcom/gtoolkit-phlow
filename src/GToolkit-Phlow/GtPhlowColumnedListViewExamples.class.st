Class {
	#name : #GtPhlowColumnedListViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
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
		items: [ aCollection ];
		column: 'x' item: [ :x | x ];
		column: 'x * x' item: [ :x | x * x ];
		actionButtonIcon: BrGlamorousVectorIcons add 
			tooltip: 'Add an item'
			action: [ aCollection add: 100 atRandom. anAnnouncer announce: Announcement new ];
		updateWhen: Announcement in: [ anAnnouncer ]
]

{ #category : #accessing }
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

{ #category : #accessing }
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

{ #category : #accessing }
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
GtPhlowColumnedListViewExamples >> gtTenItemsWithColumnItemFormatFor: aView [
	<gtView>
	^ aView columnedList
		title: 'column:item:text: usage';
		priority: 3;
		items: [ 1 to: 10 ];
		column: 'x' item: [ :x | 2 * x ] text: [ :x | 'Base ', x asString ];
		column: 'x * x' item: [ :x | 4 * x * x ] text: [ :squared | 'Square ', squared asString ]
]

{ #category : #accessing }
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

{ #category : #'api-shortcuts' }
GtPhlowColumnedListViewExamples >> viewWithItems [
	<gtExample>
	| view element |
	view := self emptyList 
		items: [ (1 to: 100) ];
		column: 'x' do: [:column | 
			column item: [ :number | number ]; matchParent ];
		column: 'x * 2' translated do: [:column | 
			column item: [:number | number * 2 ]; matchParent ].
	view asElementDo: [ :el | element := el ].
	self assert: element children second items size = 100.
	^ view
]

{ #category : #'api-shortcuts' }
GtPhlowColumnedListViewExamples >> viewWithItemsWithColumnCreationError [
	<gtExample>
	| view element |
	view := self viewWithItems 
		column: 'Error' translated do: [:column | 
			column item: [ :number | number * 4 / 0 ]; matchParent ].
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
