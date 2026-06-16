Class {
	#name : #GtPhlowToolSelectionStateNotAppliedResponse,
	#superclass : #GtPhlowToolSelectionStateResponse,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #'as yet unclassified' }
GtPhlowToolSelectionStateNotAppliedResponse >> ifApplied: anAppliedBlock ifNotApplied: aNotAppliedBlock [
	^ aNotAppliedBlock value
]
