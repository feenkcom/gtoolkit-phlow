Class {
	#name : #GtPhlowTabbedToolSelectionState,
	#superclass : #GtPhlowSingleToolSelectionState,
	#instVars : [
		'tabIdentifier'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #actions }
GtPhlowTabbedToolSelectionState >> applySelectionStateToElement: aToolElement [
	aToolElement selectTabWithIdentifier: self tabIdentifier
]

{ #category : #accessing }
GtPhlowTabbedToolSelectionState >> tabIdentifier [
	^ tabIdentifier
]

{ #category : #accessing }
GtPhlowTabbedToolSelectionState >> tabIdentifier: aTabIdentifier [
	tabIdentifier := aTabIdentifier
]
