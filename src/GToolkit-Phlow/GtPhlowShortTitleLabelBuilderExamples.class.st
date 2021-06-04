"
I exemplify {{gtClass:GtPhlowShortTitleLabelBuilder}}.


"
Class {
	#name : #GtPhlowShortTitleLabelBuilderExamples,
	#superclass : #GtPhlowTitleLabelBuilderExamples,
	#category : #'GToolkit-Phlow-Tool - Title Examples'
}

{ #category : #'examples - builder' }
GtPhlowShortTitleLabelBuilderExamples >> basicBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := GtPhlowShortTitleLabelBuilder new.
	self assert: aBuilder block isNil.
	self assert: aBuilder build isNotNil.
	self assert: aBuilder build isEmpty.
	^ aBuilder
]

{ #category : #accessing }
GtPhlowShortTitleLabelBuilderExamples >> longText [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicBuilder.
	aText := 'Very loooooooooooooooooooooooooooooooooooooooong title'.
	aBuilder block: aText.
	self assert: aBuilder build equals: aText.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowShortTitleLabelBuilderExamples >> shortText [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicBuilder.
	aText := 'Short title'.
	aBuilder block: aText.
	self assert: aBuilder build equals: aText.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowShortTitleLabelBuilderExamples >> shortText_Block [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicBuilder.
	aText := 'Short title'.
	aBuilder block: [ aText ].
	self assert: aBuilder build equals: aText.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowShortTitleLabelBuilderExamples >> shortText_RopedText [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicBuilder.
	aText := 'Short title' asRopedText.
	aBuilder block: aText.
	self assert: aBuilder build equals: aText.
	^ aBuilder
]
