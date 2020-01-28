Class {
	#name : #GtPhlowColumnedListViewExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

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
GtPhlowColumnedListViewExamples >> viewWithItemsWithError [
	<gtExample>
	| view element |
	view := self viewWithItems 
		column: 'Error' translated do: [:column | 
			column item: [ :number | Error signal. number * 4 ]; matchParent ].
	view asElementDo: [ :el | element := el ].
	self assert: element children second items size = 100.
	^ view
]
