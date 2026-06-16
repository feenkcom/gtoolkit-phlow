Trait {
	#name : #TGtPhlowToolSelectionStateHandler,
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #actions }
TGtPhlowToolSelectionStateHandler >> applySelectionStateTo: aToolElement [
	"Apply a stored selected state to an element"

	self explicitRequirement
]

{ #category : #actions }
TGtPhlowToolSelectionStateHandler >> storeSelectionStateFrom: aToolElement [
	"Store tool element's selected state"

	self explicitRequirement
]
