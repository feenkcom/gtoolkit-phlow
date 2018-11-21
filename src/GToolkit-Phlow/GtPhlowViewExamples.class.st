Class {
	#name : #GtPhlowViewExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #examples }
GtPhlowViewExamples >> compositeView [
	<gtExample>
	| view element |
	view := GtPhlowView explicit composite views: {self explicitViewWithElementStencil}.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BrTabGroup).
	self assert: element phlow isView.
	self assert: element phlow entity = view.
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
	view := GtPhlowView explicit 
		title: 'Sample';
		stencil: [ BlElement new ].
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BlElement).
	self assert: element phlow isView.
	^ view
]

{ #category : #examples }
GtPhlowViewExamples >> labelledCompositeView [
	<gtExample>
	| view element childElementsWithView |
	view := self compositeView labelled label: 'Composite'.
	view asElementDo: [ :el | element := el ].
	self assert: element notNil.
	self assert: (element isKindOf: BrTabGroup).
	self assert: (element phlow firstChildWithView isKindOf: BrTab).
	self assert: (element phlow firstChildWithView phlow entity = view).
	childElementsWithView := element allChildrenBreadthFirstSelect: [:each | each phlow isView ].
	self assert: childElementsWithView size = 3.
	^ view
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithError [
	<gtExample>
	| aView |
	aView := GtPhlowView explicit on: nil perform: #nonExistingMethod:.
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
	aView := GtPhlowView explicit on: self perform: #gtViewsFor:.
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

{ #category : #examples }
GtPhlowViewExamples >> textView [
	<gtExample>
	| view element |
	view := GtPhlowView empty textEditor text: 'abc' asRopedText.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BrEditorElement).
	self assert: element phlow isView.
	self assert: element phlow entity equals: view.
	^ view
]
