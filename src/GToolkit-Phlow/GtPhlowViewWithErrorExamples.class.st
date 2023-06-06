Class {
	#name : #GtPhlowViewWithErrorExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #'examples - element' }
GtPhlowViewWithErrorExamples >> expectedElementClass [
	^ BrHorizontalPane
]

{ #category : #'gt-extensions' }
GtPhlowViewWithErrorExamples >> gtViewWithExceptionAtCreationFor: aView [
	<gtView>
	1/0.
	^ aView title: 'With error during view creation'
]

{ #category : #'examples - view' }
GtPhlowViewWithErrorExamples >> onPerformWithErrorAtCreation [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtViewWithExceptionAtCreationFor:.
	self assert: aView class equals: GtPhlowViewWithError.
	self 
		assert: aView definingMethod 
		equals: (self class >> #gtViewWithExceptionAtCreationFor:) asRingDefinition.
	^ aView
]

{ #category : #'examples - view' }
GtPhlowViewWithErrorExamples >> onPerformWithNonExistingMethodError [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #nonExistingMethod:.
	self assert: aView class equals: GtPhlowViewWithError.
	^ aView
]

{ #category : #'examples - view' }
GtPhlowViewWithErrorExamples >> onPerformWithNonExistingMethodErrorBlocElement [
	<gtExample>
	| aView anElement |
	aView := self onPerformWithNonExistingMethodError.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement
]

{ #category : #'examples - view' }
GtPhlowViewWithErrorExamples >> onPerformWithoutError [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtViewsFor:.
	self assert: aView class equals: GtPhlowLabelledView.
	self assert: aView originalView originalView class equals: GtPhlowEmptyView.
	^ aView
]

{ #category : #'examples - view' }
GtPhlowViewWithErrorExamples >> onPerformWithoutErrorBlocElement [
	<gtExample>
	| aView anElement |
	aView := self onPerformWithoutError.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement
]

{ #category : #'examples - view' }
GtPhlowViewWithErrorExamples >> phlowView [
	<return: #GtPhlowView>
	^ self onPerformWithErrorAtCreation
]
