Class {
	#name : #GtPhlowListViewExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'examples - auto updates' }
GtPhlowListViewExamples >> autoUpdatedView [
	<gtExample>
	| aView anElement aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aView := self emptyList items: [ aCollection ].
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	
	aCollection addFirst: 100.
	anAnnouncer announce: Announcement new.
	
	self assert: anElement items size equals: 11.
	self assert: anElement items first equals: 100.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	^ aView
]

{ #category : #'examples - auto updates' }
GtPhlowListViewExamples >> autoUpdatedView_WithParent [
	<gtExample>
	| aView aParent anElement aCollection anAnnouncer |
	aCollection := OrderedCollection new.
	aCollection addAll: (1 to: 10).
	anAnnouncer := Announcer new.
	aParent := BrHorizontalPane new matchParent.
	aView := self emptyList items: [ aCollection ].
	aView updateWhen: Announcement in: [ anAnnouncer ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.
	
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement items size equals: 10.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.

	aParent addChild: anElement.
	aCollection addFirst: 100.
	anAnnouncer announce: Announcement new.
	
	self assert: anElement items size equals: 11.
	self assert: anElement items first equals: 100.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.
	self assert: aParent childrenCount equals: 1.
	self assert: (aParent children first = anElement) not.
	^ aView
]

{ #category : #examples }
GtPhlowListViewExamples >> emptyList [
	<gtExample>
	| view element |
	view := GtPhlowView empty list.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BrColumnedList).
	self assert: element phlow isView.
	self assert: element phlow entity = view.
	^ view
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
	| view element |
	view := self emptyList items: [ 21/0. (1 to: 10) ].
	view asElementDo: [ :el | element := el ].
	self assert: element class equals: BrFrame.
	^ view
]
