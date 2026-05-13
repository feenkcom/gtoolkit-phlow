"
I attach a tooltip to a given element.
I am an abstract class.


"
Class {
	#name : #GtPhlowTooltipBuilder,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Support - Tooltip'
}

{ #category : #factory }
GtPhlowTooltipBuilder class >> null [
	^ GtPhlowTooltipNullBuilder default 
]

{ #category : #factory }
GtPhlowTooltipBuilder class >> text: aText [
	^ GtPhlowTooltipLabelBuilder new text: aText
]

{ #category : #building }
GtPhlowTooltipBuilder >> actionContextMenuPreviewLabel [
	<return: #String or: nil>
	^ nil
]

{ #category : #building }
GtPhlowTooltipBuilder >> applyAsLabelOnMenuLabeledItem: aMenuItem hostElement: aTargetElement [
	"Set menu item's label using tooltip label"

	self subclassResponsibility
]

{ #category : #building }
GtPhlowTooltipBuilder >> applyOn: anElement [
	"Attach a tooltip into anElement"
	self subclassResponsibility
]

{ #category : #building }
GtPhlowTooltipBuilder >> applyOn: anElement hostElement: aTargetElement [
	"Attach a tooltip into anElement"
	self subclassResponsibility
]

{ #category : #accessing }
GtPhlowTooltipBuilder >> text [
	"I am a convenience method to easily inspect a tooltip value.
	Please, use corresponding `apply*` method to apply the tooltip (e.g., to a button)."

	<return: #String or: #BlText>
	^ self subclassResponsibility
]
