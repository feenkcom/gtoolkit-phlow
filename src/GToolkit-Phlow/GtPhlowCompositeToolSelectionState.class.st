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
GtPhlowCompositeToolSelectionState >> applySelectionStateInToolContainedIn: aTabGroupElement [
	| containedToolElement |
	containedToolElement := aTabGroupElement content children first.
	containedToolElement phlow isTool ifFalse: [ ^ self ].

	containedToolElement phlow entity
		applySelectionState: selectedToolSelectionState
		toElement: containedToolElement
]

{ #category : #accessing }
GtPhlowCompositeToolSelectionState >> applySelectionStateToElement: aTabGroupElement [
	self selectToolTabInElement: aTabGroupElement.
	self applySelectionStateInToolContainedIn: aTabGroupElement
]

{ #category : #accessing }
GtPhlowCompositeToolSelectionState >> selectToolTabInElement: aTabGroupElement [
	selectedToolTabIdentifier ifNil: [ ^ self  ].
	
	aTabGroupElement viewModel tabs
		detect: [ :aTabModel | 
			selectedToolTabIdentifier matchesTab: aTabModel ]
		ifFound: [ :aTabModel | aTabModel select ]
		ifNone: [  "do nothing" ]
]

{ #category : #accessing }
GtPhlowCompositeToolSelectionState >> selectedToolSelectionState: anObject [
	selectedToolSelectionState := anObject
]

{ #category : #accessing }
GtPhlowCompositeToolSelectionState >> selectedToolTabIdentifier: aToolTabIdentifier [
	selectedToolTabIdentifier := aToolTabIdentifier
]
