Class {
	#name : #GtPhlowEmptyViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #accessing }
GtPhlowEmptyViewExamples >> element [
	<gtExample>
	| aView anElement |
	aView := self phlowView.
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assertViewElement: anElement ofClass: BlElement inView: aView.
	^ anElement
]

{ #category : #'gt-extensions' }
GtPhlowEmptyViewExamples >> gtPhlowEmptyViewFor: aView [
	<gtView>
	^ aView empty
		title: 'Empty view';
		priority: 3
]

{ #category : #'gt-extensions' }
GtPhlowEmptyViewExamples >> gtPhlowViewFor: aView [
	<gtView>
	^ aView empty
		title: 'Empty view';
		priority: 3
]

{ #category : #'examples - view' }
GtPhlowEmptyViewExamples >> phlowView [
	<return: #GtPhlowView>
	| aView |
	aView := GtPhlowView empty.
	self assertCommonDefaultView: aView.
	^ aView
]
