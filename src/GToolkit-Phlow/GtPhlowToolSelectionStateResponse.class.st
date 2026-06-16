Class {
	#name : #GtPhlowToolSelectionStateResponse,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #factory }
GtPhlowToolSelectionStateResponse class >> applied [
	^ GtPhlowToolSelectionStateAppliedResponse default
]

{ #category : #factory }
GtPhlowToolSelectionStateResponse class >> notApplied [
	^ GtPhlowToolSelectionStateNotAppliedResponse default
]

{ #category : #testing }
GtPhlowToolSelectionStateResponse >> ifApplied: anAppliedBlock ifNotApplied: aNotAppliedBlock [
	^ self subclassResponsibility
]
