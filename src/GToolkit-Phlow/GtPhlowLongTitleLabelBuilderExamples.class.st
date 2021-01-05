"
I exemplify ${class:GtPhlowLongTitleLabelBuilder}$.
"
Class {
	#name : #GtPhlowLongTitleLabelBuilderExamples,
	#superclass : #GtPhlowTitleLabelBuilderExamples,
	#category : #'GToolkit-Phlow-Tool - Title Examples'
}

{ #category : #'examples - builder' }
GtPhlowLongTitleLabelBuilderExamples >> basicBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := GtPhlowLongTitleLabelBuilder new.
	self assert: aBuilder block isNil.
	self assert: aBuilder build isNotNil.
	self assert: aBuilder build isEmpty.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowLongTitleLabelBuilderExamples >> longTitle [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicBuilder.
	aText := 'Very loooooooooooooooooooooooooooooooooooooooong title'.
	aBuilder block: aText.
	self 
		assert: aBuilder build asString 
		equals: 'Very loooooo...ooooong title'.
	^ aBuilder
]

{ #category : #accessing }
GtPhlowLongTitleLabelBuilderExamples >> longTitle_Block [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicBuilder.
	aText := 'Very loooooooooooooooooooooooooooooooooooooooong title'.
	aBuilder block: [ aText ].
	self 
		assert: aBuilder build asString 
		equals: 'Very loooooo...ooooong title'.
	^ aBuilder
]

{ #category : #accessing }
GtPhlowLongTitleLabelBuilderExamples >> longTitle_RopedText [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicBuilder.
	aText := 'Very loooooooooooooooooooooooooooooooooooooooong title'.
	aBuilder block: aText asRopedText.
	self 
		assert: aBuilder build asString 
		equals: 'Very loooooo...ooooong title'.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowLongTitleLabelBuilderExamples >> shortTitle [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicBuilder.
	aText := 'Short title'.
	aBuilder block: aText.
	self assert: aBuilder build asString equals: aText.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowLongTitleLabelBuilderExamples >> shortTitle_Block [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicBuilder.
	aText := 'Short title'.
	aBuilder block: [ aText ].
	self assert: aBuilder build asString equals: aText.
	^ aBuilder
]
