"
I exemplify {{gtClass:GtPhlowToolTitleLabelBuilder}}.


"
Class {
	#name : #GtPhlowToolTitleLabelBuilderExamples,
	#superclass : #GtPhlowTitleLabelBuilderExamples,
	#category : #'GToolkit-Phlow-Examples-Tool'
}

{ #category : #'examples - builder' }
GtPhlowToolTitleLabelBuilderExamples >> builder [
	<gtExample>
	| aBuilder |
	aBuilder := GtPhlowToolTitleLabelBuilder new.
	self assert: aBuilder toolName isNil.
	self assert: aBuilder subjectName isNil.
	self assert: aBuilder build isNotNil.
	self assert: aBuilder build isEmpty.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowToolTitleLabelBuilderExamples >> emptySubjectName [
	<gtExample>
	| aBuilder aTitle |
	aBuilder := self builder.
	aBuilder toolName: 'My Tool'.
	aBuilder subjectName: ''.
	aTitle := aBuilder build.
	self assert: aTitle asString equals: 'My Tool'.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowToolTitleLabelBuilderExamples >> longTitle [
	<gtExample>
	| aBuilder aTitle |
	aBuilder := self builder.
	aBuilder toolName: 'My Tool'.
	aBuilder subjectName: 'My very loooooooooooooooooooooooooooooooooooooooong subject name'.
	aTitle := aBuilder build.
	self assert: aTitle asString equals: 'My Tool: My very looo... subject name'.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowToolTitleLabelBuilderExamples >> longTitle_Block [
	<gtExample>
	| aBuilder aTitle |
	aBuilder := self builder.
	aBuilder toolName: [ 'My Tool' ].
	aBuilder subjectName: [ 'My very loooooooooooooooooooooooooooooooooooooooong subject name' ].
	aTitle := aBuilder build.
	self assert: aTitle asString equals: 'My Tool: My very looo... subject name'.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowToolTitleLabelBuilderExamples >> longTitle_RopedText [
	<gtExample>
	| aBuilder aTitle |
	aBuilder := self builder.
	aBuilder toolName: 'My Tool' asRopedText.
	aBuilder subjectName: 'My very loooooooooooooooooooooooooooooooooooooooong subject name' asRopedText.
	aTitle := aBuilder build.
	self assert: aTitle asString equals: 'My Tool: My very looo... subject name'.
	self assert: aBuilder toolName asString equals: 'My Tool'.
	self 
		assert: aBuilder subjectName asString 
		equals: 'My very loooooooooooooooooooooooooooooooooooooooong subject name'.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowToolTitleLabelBuilderExamples >> noSubjectName [
	<gtExample>
	| aBuilder aTitle |
	aBuilder := self builder.
	aBuilder toolName: 'My Tool'.
	aTitle := aBuilder build.
	self assert: aTitle asString equals: 'My Tool'.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowToolTitleLabelBuilderExamples >> noToolName [
	<gtExample>
	| aBuilder aTitle |
	aBuilder := self builder.
	aBuilder subjectName: 'My Subject'.
	aTitle := aBuilder build.
	self assert: aTitle asString equals: ''.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowToolTitleLabelBuilderExamples >> shortTitle [
	<gtExample>
	| aBuilder aTitle |
	aBuilder := self builder.
	aBuilder toolName: 'My Tool'.
	aBuilder subjectName: 'My Subject'.
	aTitle := aBuilder build.
	self assert: aTitle asString equals: 'My Tool: My Subject'.
	^ aBuilder
]

{ #category : #'examples - builder' }
GtPhlowToolTitleLabelBuilderExamples >> shortTitle_Block [
	<gtExample>
	| aBuilder aTitle |
	aBuilder := self builder.
	aBuilder toolName: [ 'My Tool' ].
	aBuilder subjectName: [ 'My Subject' ].
	aTitle := aBuilder build.
	self assert: aTitle asString equals: 'My Tool: My Subject'.
	^ aBuilder
]
