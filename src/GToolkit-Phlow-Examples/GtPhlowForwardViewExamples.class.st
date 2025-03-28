Class {
	#name : #GtPhlowForwardViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #'examples - element' }
GtPhlowForwardViewExamples >> expectedElementClass [
	^ BrFromFuture
]

{ #category : #'examples - view' }
GtPhlowForwardViewExamples >> phlowView [
	<gtExample>
	<return: #GtPhlowView>
	^ GtPhlowView empty forward
		object: [ GtPhlowColumnedListViewExamples new ];
		view: #gtTenItemsWithColumnItemsFor:
]
