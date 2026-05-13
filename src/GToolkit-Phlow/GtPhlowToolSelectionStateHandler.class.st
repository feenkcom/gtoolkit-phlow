Class {
	#name : #GtPhlowToolSelectionStateHandler,
	#superclass : #Object,
	#instVars : [
		'selectionState'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #actions }
GtPhlowToolSelectionStateHandler >> applySelectionStateTo: aToolElement [
	aToolElement phlow isTool ifFalse: [ ^ self ].
	selectionState ifNil: [ ^ self ].
	
	aToolElement phlow entity 
		applySelectionState: selectionState toElement: aToolElement
]

{ #category : #'initialization ' }
GtPhlowToolSelectionStateHandler >> initialize [
	super initialize.
	
	self resetStoredSelectionState.
]

{ #category : #actions }
GtPhlowToolSelectionStateHandler >> resetStoredSelectionState [
	selectionState := GtPhlowToolNullSelectionState uniqueInstance.
]

{ #category : #actions }
GtPhlowToolSelectionStateHandler >> storeSelectionStateFrom: aToolElement [
	| aState |
	aToolElement phlow isTool ifFalse: [ ^ self ].

	aState := aToolElement phlow entity
			extractSelectionStateFromElement: aToolElement.
	(aState isNotNil and: [ aState ~= GtPhlowToolNullSelectionState uniqueInstance ]) 
		ifTrue: [ selectionState := aState ].

	GtPhlowStoreToolSelectionSignal new
		toolElement: aToolElement;
		phlowView: aToolElement phlow entity;
		selectionState: selectionState;
		emit
]
