Class {
	#name : #GtPhlowViewExamples,
	#superclass : #Object,
	#category : 'GToolkit-Phlow'
}

{ #category : #examples }
GtPhlowViewExamples >> compositeView [
	<gtExample>
	| view element |
	view := GtPhlowExplicitView new composite views: {self explicitViewWithElementStencil}.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BrTabGroup).
	^ view
]

{ #category : #examples }
GtPhlowViewExamples >> emptyExplicitView [
	<gtExample>
	| view element |
	view := self explicitViewWithElementStencil empty.
	view asElementDo: [ :el | element := el ].
	self assert: element isNil.
	^ view
]

{ #category : #examples }
GtPhlowViewExamples >> explicitViewWithElementStencil [
	<gtExample>
	| view element |
	view := GtPhlowExplicitView new 
		title: 'Sample';
		stencil: [ BlElement new ].
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BlElement).
	^ view
]

{ #category : #examples }
GtPhlowViewExamples >> labelledCompositeView [
	<gtExample>
	| view element |
	view := self compositeView labelled label: 'Composite'.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BlElement).
	self assert: (element children first isKindOf: BlTextElement).
	^ view
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithError [
	<gtExample>
	| aView |
	aView := GtPhlowExplicitView on: nil perform: #nonExistingMethod:.
	self assert: aView class equals: GtPhlowViewWithError.
	^ aView
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithErrorBlocElement [
	<gtExample>
	| aView anElement |
	aView := self onPerformWithError.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithoutError [
	<gtExample>
	| aView |
	aView := GtPhlowExplicitView on: self perform: #gtViewsFor:.
	self assert: aView class equals: GtPhlowLabelledView.
	self assert: aView originalView originalView class equals: GtPhlowExplicitView.
	^ aView
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithoutErrorBlocElement [
	<gtExample>
	| aView anElement |
	aView := self onPerformWithoutError.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement
]
