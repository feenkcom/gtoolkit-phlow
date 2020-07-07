Class {
	#name : #GtPhlowListViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
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
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aCollection := aCollection copy addFirst: 100; yourself.
	
	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aListElement items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
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
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aParent addChild: aListElement.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aCollection := aCollection copy addFirst: 100; yourself.

	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aParent childrenCount equals: 1.
	self assert: aParent children first == aListElement.
	self assert: aParent children first items size equals: 11.
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
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	aParent addChild: aListElement.
	
	aCollection := aCollection copy addFirst: 100; yourself.
	BlUseAsyncFeatures disableDuring: [
		anAnnouncer announce: Announcement new ].
	
	self assert: aListElement items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.
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

{ #category : #examples }
GtPhlowListViewExamples >> emptyList [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty list.
	aView asElementDo: [ :el | anElement := el ].
	self assertViewElement: anElement ofClass: BrColumnedList inView: aView.
	^ aView
]

{ #category : #'examples - element' }
GtPhlowListViewExamples >> expectedElementClass [
	^ BrColumnedList
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtAutoUpdatingListFor: aView [
	<gtView>
	| aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	^ aView list
		title: 'Auto Updating List';
		items: [ aCollection ];
		actionButtonIcon: BrGlamorousVectorIcons add 
			action: [ aCollection add: 100 atRandom. anAnnouncer announce: Announcement new ];
		updateWhen: Announcement in: [ anAnnouncer ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtTenItemsFor: aView [
	<gtView>
	^ aView list 
		title: '10 Items';
		items: [ (1 to: 10) ]
]

{ #category : #'gt-extension' }
GtPhlowListViewExamples >> gtTenLinesFor: aView [
	<gtView>
	^ aView list 
		title: '10 Lines';
		items: [ (1 to: 10) ];
		itemStencil: [ :x | 
			BlElement new background: Color orange; size: 10 @ x; margin: (BlInsets all: 10) ]
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

{ #category : #'examples - updating' }
GtPhlowListViewExamples >> updateOnDefiningMethodChange [
	<gtExample>
	| anElement aView anElementContext aCommand aContainer |
	aContainer := self container.
	anElement := self modifiedElement.
	anElementContext := anElement phlow.
	aView := anElement phlow entity.
	aContainer addChild: anElement.
	
	aCommand := GtPhlowUpdateView new
		elementContext: anElement phlow.
	BlUseAsyncFeatures disableDuring: [ 
		aCommand execute ].

	self assert: anElement phlow equals: anElementContext.
	self assert: anElement phlow entity ~= aView.
	self assert: anElement items size equals: 10.
	self assert: anElement phlow entity title equals: '10 Lines'.
	
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
		itemStencil: [:x | 
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
		itemStencil: [:x |
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
