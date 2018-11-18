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
