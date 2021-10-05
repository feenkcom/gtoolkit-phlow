"
I exemplify {{gtClass:GtPhlowNoTitleLabelBuilder}}.


"
Class {
	#name : #GtPhlowNoTitleLabelBuilderExamples,
	#superclass : #GtPhlowTitleLabelBuilderExamples,
	#category : 'GToolkit-Phlow-Tool - Title Examples'
}

{ #category : #'examples - builder' }
GtPhlowNoTitleLabelBuilderExamples >> basicBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := GtPhlowTitleLabelBuilder null.
	self assert: aBuilder build isEmpty.
	^ aBuilder
]
