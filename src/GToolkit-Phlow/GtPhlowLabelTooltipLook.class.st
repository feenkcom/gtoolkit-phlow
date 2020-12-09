"
I display a label tooltip.
If a user clicks on the action, a defining method is displayed.
"
Class {
	#name : #GtPhlowLabelTooltipLook,
	#superclass : #BrGlamorousWithLabelTooltipLook,
	#category : #'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #'instance creation' }
GtPhlowLabelTooltipLook >> newLabelWithText: aTextOrString [
	^ (super newLabelWithText: aTextOrString)
		when: BlClickEvent do: [ :anEvent | 
			self widgetDo: [ :aWidget | aWidget phlow spawnDefiningMethod ] ]
]
