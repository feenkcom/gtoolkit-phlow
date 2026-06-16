Class {
	#name : #GtPhlowToolSelectionStateAppliedResponse,
	#superclass : #GtPhlowToolSelectionStateResponse,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #'as yet unclassified' }
GtPhlowToolSelectionStateAppliedResponse >> ifApplied: anAppliedBlock ifNotApplied: aNotAppliedBlock [
	^ anAppliedBlock value
]
