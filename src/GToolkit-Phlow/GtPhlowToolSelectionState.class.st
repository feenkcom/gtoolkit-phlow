Class {
	#name : #GtPhlowToolSelectionState,
	#superclass : #Object,
	#instVars : [
		'targetToolIdentifier'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #testing }
GtPhlowToolSelectionState >> appliesToTool: aPhlowTool [
	^ targetToolIdentifier = aPhlowTool toolTabIdentifier 
]

{ #category : #actions }
GtPhlowToolSelectionState >> applySelectionStateToElement: aToolElement [
	"Specific subclasses should override this method to apply the selection to the given element"
]

{ #category : #accessing }
GtPhlowToolSelectionState >> targetToolIdentifier: anToolIdentifier [
	self assert: [ anToolIdentifier notNil ].
	
	targetToolIdentifier := anToolIdentifier
]
