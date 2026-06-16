Class {
	#name : #GtPhlowCompositeToolSelectionState,
	#superclass : #GtPhlowToolSelectionState,
	#instVars : [
		'selectedToolSelectionState',
		'selectedToolTabIdentifier'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #private }
GtPhlowCompositeToolSelectionState >> applySelectionStateInToolContainedIn: aTabGroupElement [
	<return: #GtPhlowToolSelectionStateResponse>
	| containedToolElement |
	containedToolElement := aTabGroupElement content children first.
	containedToolElement phlow isTool ifFalse: [ 
		 ^ GtPhlowToolSelectionStateResponse notApplied  ].

	GtPhlowApplyToolSelectionSignal new
		toolElement: containedToolElement;
		phlowView: containedToolElement phlow entity;
		selectionState: selectedToolSelectionState;
		emit.

	^ containedToolElement phlow entity
		applySelectionState: selectedToolSelectionState
		toElement: containedToolElement
]

{ #category : #accessing }
GtPhlowCompositeToolSelectionState >> applySelectionStateToElement: aTabGroupElement [
	<return: #GtPhlowToolSelectionStateResponse>
	| isToolSelected aSelectionResponse |
	isToolSelected := self selectToolTabInElement: aTabGroupElement.
	aSelectionResponse := self
			applySelectionStateInToolContainedIn: aTabGroupElement.

	^ isToolSelected
		ifFalse: [ GtPhlowToolSelectionStateResponse notApplied ]
		ifTrue: [ aSelectionResponse ]
]

{ #category : #private }
GtPhlowCompositeToolSelectionState >> selectToolTabInElement: aTabGroupElement [
	selectedToolTabIdentifier ifNil: [ ^ false ].
	
	^ aTabGroupElement viewModel tabs
		detect: [ :aTabModel | 
			selectedToolTabIdentifier matchesTab: aTabModel ]
		ifFound: [ :aTabModel | aTabModel select. true ]
		ifNone: [ false ]
]

{ #category : #accessing }
GtPhlowCompositeToolSelectionState >> selectedToolSelectionState: anObject [
	selectedToolSelectionState := anObject
]

{ #category : #accessing }
GtPhlowCompositeToolSelectionState >> selectedToolTabIdentifier: aToolTabIdentifier [
	selectedToolTabIdentifier := aToolTabIdentifier
]
