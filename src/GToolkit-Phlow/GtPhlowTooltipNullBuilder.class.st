"
I do not attach any tooltip.


"
Class {
	#name : #GtPhlowTooltipNullBuilder,
	#superclass : #GtPhlowTooltipBuilder,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #building }
GtPhlowTooltipNullBuilder >> applyAsLabelOnMenuLabeledItem: aMenuItem hostElement: aTargetElement [
	"ignore"

	
]

{ #category : #building }
GtPhlowTooltipNullBuilder >> applyOn: anElement [
	"ignore"
]

{ #category : #building }
GtPhlowTooltipNullBuilder >> applyOn: anElement hostElement: aTargetElement [
	"ignore"
]

{ #category : #accessing }
GtPhlowTooltipNullBuilder >> text [
	"I am a convenience method to easily inspect a tooltip value.
	Please, use corresponding `apply*` method to apply the tooltip (e.g., to a button)."

	<return: #String or: #BlText>
	^ ''
]
