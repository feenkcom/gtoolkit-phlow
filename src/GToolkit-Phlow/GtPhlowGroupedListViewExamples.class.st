Class {
	#name : #GtPhlowGroupedListViewExamples,
	#superclass : #GtPhlowViewExamples,
	#traits : 'TGtPhlowSendTransformationExamples',
	#classTraits : 'TGtPhlowSendTransformationExamples classTrait',
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> emptyList [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty groupedList.
	aView asElementDo: [ :el | anElement := el ].
	self assertViewElement: anElement ofClass: self expectedElementClass inView: aView.
	^ aView
]

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> expectedElementClass [
	^ BrGroupedList
]

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> gtTenLinesFor: aView [
	<gtView>
	^ aView groupedList
		title: '10 Lines';
		priority: 3;
		items: [ 1 to: 10 ];
		groups: [ {'Even' -> #even.
				'Odd' -> #odd} ];
		itemStencil: [ BlElement new
				background: Color orange;
				size: 10 @ 10;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c margin: (BlInsets all: 10) ] ];
		itemDataBinder: [ :anElement :aNumber :anIndex | anElement height: aNumber * 5 ]
]

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> phlowView [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtTenLinesFor:.
	self assert: aView hasBuildContext.
	^ aView
]

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> sendTool [
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
	^ view
]

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> updateOnDefiningMethodChange [
	<gtExample>
	| anElement aView anElementContext aCommand aContainer aNewElement |
	aContainer := self container.
	anElement := self modifiedElement.
	anElementContext := anElement phlow.
	aView := anElement phlow entity.
	aContainer addChild: anElement.

	aCommand := GtPhlowUpdateView new elementContext: anElement phlow.
	BlUseAsyncFeatures disableDuring: [ aCommand execute ].

	self assert: aContainer childrenCount equals: 1.

	self assert: anElement phlow equals: anElementContext.
	self assert: anElement phlow entity equals: aView.

	aNewElement := aContainer childAt: 1.


	self assert: aNewElement ~= anElement.
	self assert: aNewElement phlow entity title equals: '10 Lines'.

	^ aContainer
]

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> viewWithItems [
	<gtExample>
	| view element |
	view := self emptyList
			items: [ 1 to: 10 ];
			groups: [ {'Even' -> #even.
					'Odd' -> #odd} ].
	view asElementDo: [ :el | element := el ].
	^ view
]

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> viewWithItemsAndItemElement [
	<gtExample>
	| view element |
	view := self viewWithItems 
		itemStencil: [
			BlElement new background: Color orange; margin: (BlInsets all: 10) ]; itemDataBinder: [:aLabel :aValue | aLabel  size: 10 @ (aValue*3)].
	view asElementDo: [ :el | element := el ].
	^ view
]

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> viewWithItemsAndItemElement_ProducingError [
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

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> viewWithItemsAndItemElement_ProducingError_InSpace [
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

{ #category : #accessing }
GtPhlowGroupedListViewExamples >> viewWithItems_WithGetItemsError [
	<gtExample>
	| aView anElement |
	aView := self emptyList items: [ 21/0. (1 to: 10) ].
	aView asElementDo: [ :el | anElement := el ].
	self assertErrorElement: anElement inView: aView.
	^ aView
]

{ #category : #'examples - view' }
GtPhlowGroupedListViewExamples >> viewWithTenItems [
	"Return an initialized view with 10 (root) items"
	<gtExample>
	^ self viewWithItems
]
