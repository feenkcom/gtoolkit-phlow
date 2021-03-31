"
I display a label tooltip.
If a user clicks on the action, a defining method is displayed.
"
Class {
	#name : #GtPhlowLabelTooltipAptitude,
	#superclass : #BrGlamorousWithLabelTooltipAptitude,
	#category : #'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #'instance creation' }
GtPhlowLabelTooltipAptitude >> newLabelWithText: aTextOrString [
	^ (super newLabelWithText: aTextOrString)
		when: BlClickEvent do: [ :anEvent | 
			self widgetDo: [ :aWidget | aWidget phlow spawnDefiningMethod ] ]
]
