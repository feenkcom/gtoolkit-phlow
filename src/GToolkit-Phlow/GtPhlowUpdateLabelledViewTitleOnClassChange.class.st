Class {
	#name : #GtPhlowUpdateLabelledViewTitleOnClassChange,
	#superclass : #GtPhlowUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #subscriptions }
GtPhlowUpdateLabelledViewTitleOnClassChange >> installOn: aTabGroup [
	super installOn: aTabGroup.
	GtPhlowChangeClassSystemAnnouncerListener installOnLabelledElement: aTabGroup
]
