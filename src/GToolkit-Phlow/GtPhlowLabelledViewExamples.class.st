Class {
	#name : #GtPhlowLabelledViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #'examples - element' }
GtPhlowLabelledViewExamples >> element [
	<gtExample>
	| aTabGroup aTab |
	aTabGroup := super element.
	
	self assert: aTabGroup phlow entity label equals: 'I am labelled view'.
	self assert: aTabGroup viewModel tabs size equals: 1.
	aTab := aTabGroup viewModel tabs anyOne widget.
	self assert: aTab isNotNil.
	self assert: aTab label asString equals: 'I am labelled view'.
	
	^ aTabGroup
]

{ #category : #'examples - element' }
GtPhlowLabelledViewExamples >> expectedElementClass [
	^ BrTabGroup
]

{ #category : #'gt-extensions' }
GtPhlowLabelledViewExamples >> gtLabelledFor: aView [
	<gtView>
	^ aView labelled
		title: 'Empty';
		label: 'I am labelled view'
]

{ #category : #'gt-extensions' }
GtPhlowLabelledViewExamples >> gtLabelledWithComposedViewFor: aView [
	<gtView>
	^ ((GtPhlowCompositeViewExamples new gtPhlowViewFor: aView)
		labelled: 'I am labelled view')
			title: 'Composite'
]

{ #category : #'gt-extensions' }
GtPhlowLabelledViewExamples >> gtLabelledWithRandomBackgroundFor: aView [
	<gtView>
	^ ((GtPhlowExplicitViewExamples new gtUpdatingFor: aView)	
		labelled: 'I am labelled view')
			title: 'Explicit'
]

{ #category : #'gt-extensions' }
GtPhlowLabelledViewExamples >> gtLabelledWithTextEditorViewFor: aView [
	<gtView>
	^ ((GtPhlowTextEditorViewExamples new gtAutoUpdatingFor: aView)
		labelled: 'I am labelled view')
			title: 'Text Editor'
]

{ #category : #'gt-extensions' }
GtPhlowLabelledViewExamples >> itself [
	<gtExample>
	^ self
]

{ #category : #'examples - view' }
GtPhlowLabelledViewExamples >> phlowView [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtLabelledWithComposedViewFor:.
	
	self assert: aView hasBuildContext.
	self assert: aView label equals: 'I am labelled view'.
	
	^ aView
]

{ #category : #'examples - updating' }
GtPhlowLabelledViewExamples >> updateLabel [
	<gtExample>
	| aTabGroup aView aCommand aTab |
	aTabGroup := self element.
	aView := aTabGroup phlow entity.
	
	"Simulate a view label change"
	aView label: 'a new label'.
	
	aCommand := GtPhlowUpdateLabelledViewTitle new
		elementContext: aTabGroup phlow.
	BlUseAsyncFeatures disableDuring: [ 
		aCommand execute ].
	
	self assert: aTabGroup phlow entity equals: aView.
	self assert: aTabGroup viewModel tabs size equals: 1.
	aTab := aTabGroup viewModel tabs anyOne widget.
	self assert: aTab isNotNil.
	self assert: aTab label asString equals: 'a new label'.
	self assert: aTab phlow entity equals: aView.
	self assert: aView label equals: 'a new label'.
	
	^ aTabGroup
]
