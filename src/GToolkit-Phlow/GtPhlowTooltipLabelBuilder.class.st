"
I attach a label tooltip to a given element.

!! Examples 

${example:GtPhlowActionExamples>>#buttonWithIconAndLabelAndTooltip}$

${example:GtPhlowActionExamples>>#buttonWithLabelWithTooltip}$

${example:GtPhlowActionExamples>>#buttonWithIconAndTooltip}$

"
Class {
	#name : #GtPhlowTooltipLabelBuilder,
	#superclass : #GtPhlowTooltipBuilder,
	#instVars : [
		'text'
	],
	#category : #'GToolkit-Phlow-Tooltip'
}

{ #category : #building }
GtPhlowTooltipLabelBuilder >> applyOn: anElement hostElement: aTargetElement [
	anElement addLook: (GtPhlowLabelTooltipLook new text: self text)
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
