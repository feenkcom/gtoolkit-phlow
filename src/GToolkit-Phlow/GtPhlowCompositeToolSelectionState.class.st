Class {
	#name : #GtPhlowCompositeToolSelectionState,
	#superclass : #GtPhlowToolSelectionState,
	#instVars : [
		'selectedToolSelectionState',
		'selectedToolTabIdentifier'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #accessing }
GtPhlowCompositeToolSelectionState >> applyCompositeSelectionStateToElement: aTabGroupElement [
	<return: #GtPhlowToolSelectionStateResponse>
	| isToolSelected |
	isToolSelected := self selectToolTabInElement: aTabGroupElement.

	^ isToolSelected
		ifFalse: [ GtPhlowToolSelectionStateResponse notApplied ]
		ifTrue: [ self applySelectionStateInToolContainedIn: aTabGroupElement ]
]

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
	| isToolSelected |
	isToolSelected := self selectToolTabInElement: aTabGroupElement.

	^ isToolSelected
		ifFalse: [ GtPhlowToolSelectionStateResponse notApplied ]
		ifTrue: [ self applySelectionStateInToolContainedIn: aTabGroupElement ]
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
