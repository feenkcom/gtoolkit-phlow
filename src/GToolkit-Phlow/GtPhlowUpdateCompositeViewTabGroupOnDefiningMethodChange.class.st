Class {
	#name : #GtPhlowUpdateCompositeViewTabGroupOnDefiningMethodChange,
	#superclass : #GtPhlowUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #subscriptions }
GtPhlowUpdateCompositeViewTabGroupOnDefiningMethodChange >> installOn: aTabGroup [
	super installOn: aTabGroup.
	GtPhlowChangeMethodSystemAnnouncerListener installOnCompositeElement: aTabGroup
]
