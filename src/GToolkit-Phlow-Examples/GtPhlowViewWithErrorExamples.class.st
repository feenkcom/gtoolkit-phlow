Class {
	#name : #GtPhlowViewWithErrorExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #'gt-extensions' }
GtPhlowViewWithErrorExamples >> createViewFrom: aView [ 
	^ aView
]

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

{ #category : #'gt-extensions' }
GtPhlowViewWithErrorExamples >> gtViewWithFailureInColumnedListFor: aView [
	<gtView>

	^ aView columnedTree
		title: 'Collection Subclasses';
		items: [ {Collection}];
		expandUpTo: 2;
		children: [ :aClass | aClass subclasses ];
		column: 'Name' text: [ :aClass | aClass name];
		column: 'Number of methods' text: [ :aClass | 
			aClass name = #LinkedList ifTrue: [ 1/0 ].
			aClass name = #Set ifTrue: [ 1/0 ].
			aClass methods size]
]

{ #category : #'gt-extensions' }
GtPhlowViewWithErrorExamples >> gtViewWithReturningIndirectlySameViewFor: aView [
	<gtView>

	self hasData ifFalse: [ ^ self createViewFrom: aView  ].

	^ aView list
		title: 'View Data';
		items: [ 1 to: 100 ]
]

{ #category : #'gt-extensions' }
GtPhlowViewWithErrorExamples >> gtViewWithReturningSameViewFor2: aView [
	
	self hasData ifFalse: [ ^ aView ].

	self hasMoreData ifFalse: [ ^ aView ].

	^ aView list
		title: 'View Data';
		items: [ 1 to: 100 ]
]

{ #category : #'gt-extensions' }
GtPhlowViewWithErrorExamples >> gtViewWithReturningSameViewFor: aView [
	<gtView>
	self hasData ifFalse: [ ^ aView ].

	self hasMoreData ifFalse: [ ^ aView ].

	^ aView list
		title: 'View Data';
		items: [ 1 to: 100 ]
]

{ #category : #'gt-extensions' }
GtPhlowViewWithErrorExamples >> hasData [
	^ false
]

{ #category : #'gt-extensions' }
GtPhlowViewWithErrorExamples >> hasMoreData [
	^ true
]

{ #category : #'examples - view' }
GtPhlowViewWithErrorExamples >> onPerformWithErrorAtCreation [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtViewWithExceptionAtCreationFor:.
	self assert: aView class equals: GtPhlowViewWithError.
	self assert: aView buildContext isBuildContext.
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
	self assert: aView buildContext isBuildContext.
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
