"
I attach a label tooltip to a given element.

1. # Examples 


{{gtExample:GtPhlowActionExamples>>#buttonWithIconAndLabelAndTooltip}}

{{gtExample:GtPhlowActionExamples>>#buttonWithLabelWithTooltip}}

{{gtExample:GtPhlowActionExamples>>#buttonWithIconAndTooltip}}


"
Class {
	#name : #GtPhlowTooltipLabelBuilder,
	#superclass : #GtPhlowTooltipBuilder,
	#instVars : [
		'text'
	],
	#category : 'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #building }
GtPhlowTooltipLabelBuilder >> applyOn: anElement [
	anElement addAptitude: (GtPhlowLabelTooltipAptitude new text: self text)
]

{ #category : #building }
GtPhlowTooltipLabelBuilder >> applyOn: anElement hostElement: aTargetElement [
	self applyOn: anElement
]

{ #category : #asserting }
GtPhlowTooltipLabelBuilder >> assertText: aStringOrText [
	self 
		assert: [ aStringOrText isNotNil ]
		description: [ 'Tooltip text must be non-nil' ].
	self 
		assert: [ aStringOrText isString or: [ aStringOrText isKindOf: BlText ] ] 
		description: [ 'Tooltip text must be a string or a BlText instance' ].
	self 
		assert: [ aStringOrText size isZero not ] 
		description: [ 'Tooltip text must be a non-zero character long' ].
	
]

{ #category : #initialization }
GtPhlowTooltipLabelBuilder >> initialize [
	super initialize.
	text := 'Tooltip'
]

{ #category : #accessing }
GtPhlowTooltipLabelBuilder >> text [
	^ text
]

{ #category : #accessing }
GtPhlowTooltipLabelBuilder >> text: aStringOrText [
	self assertText: aStringOrText.
	text := aStringOrText
]
