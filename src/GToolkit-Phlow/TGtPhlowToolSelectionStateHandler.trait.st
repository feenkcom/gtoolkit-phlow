Trait {
	#name : #TGtPhlowToolSelectionStateHandler,
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #actions }
TGtPhlowToolSelectionStateHandler >> applySelectionState: aSelectionState to: aToolElement [
	"Apply an explicitly defined selected state to an element"

	<return: #GtPhlowToolSelectionStateResponse>
	aToolElement phlow isTool
		ifFalse: [ ^ GtPhlowToolSelectionStateResponse notApplied ].
	aSelectionState ifNil: [ ^ GtPhlowToolSelectionStateResponse notApplied ].

	^ aToolElement phlow entity
		applySelectionState: aSelectionState
		toElement: aToolElement
]

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
