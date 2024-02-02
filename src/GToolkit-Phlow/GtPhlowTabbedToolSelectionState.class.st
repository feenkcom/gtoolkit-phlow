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

{ #category : #printing }
GtPhlowTabbedToolSelectionState >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		 self tabIdentifier descriptionOn: aStream ]
]

{ #category : #accessing }
GtPhlowTabbedToolSelectionState >> tabIdentifier [
	^ tabIdentifier
]

{ #category : #accessing }
GtPhlowTabbedToolSelectionState >> tabIdentifier: aTabIdentifier [
	tabIdentifier := aTabIdentifier
]
