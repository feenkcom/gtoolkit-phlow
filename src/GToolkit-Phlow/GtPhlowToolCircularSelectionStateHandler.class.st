Class {
	#name : #GtPhlowToolCircularSelectionStateHandler,
	#superclass : #Object,
	#traits : 'TGtPhlowToolSelectionStateHandler',
	#classTraits : 'TGtPhlowToolSelectionStateHandler classTrait',
	#instVars : [
		'selectionStates'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #private }
GtPhlowToolCircularSelectionStateHandler >> addSelectionState: aState [
	aState ifNil: [ ^ self ].
	aState = GtPhlowToolNullSelectionState uniqueInstance ifTrue: [ ^ self ].

	selectionStates addFirst: aState.

	selectionStates size < 21 ifTrue: [ ^ self ].
	selectionStates removeLast.
]

{ #category : #actions }
GtPhlowToolCircularSelectionStateHandler >> applySelectionStateTo: aToolElement [
	aToolElement phlow isTool ifFalse: [ ^ self ].
	selectionStates ifNil: [ ^ self ].
	selectionStates ifEmpty: [ ^ self ].

	selectionStates
		do: [ :eachState | 
			| aResult |
			aResult := self applySelectionState: eachState to: aToolElement.
			aResult
				ifApplied: [ 
					self moveSelectionState: eachState.
					^ self ]
				ifNotApplied: [  ] ]
]

{ #category : #initialization }
GtPhlowToolCircularSelectionStateHandler >> initialize [
	super initialize.
	
	self resetStoredSelectionState.
]

{ #category : #private }
GtPhlowToolCircularSelectionStateHandler >> moveSelectionState: aState [
	aState ifNil: [ ^ self ].
	aState = GtPhlowToolNullSelectionState uniqueInstance ifTrue: [ ^ self ].

	selectionStates remove: aState.
	selectionStates addFirst: aState
]

{ #category : #initialization }
GtPhlowToolCircularSelectionStateHandler >> resetStoredSelectionState [
	selectionStates := LinkedList
			with: GtPhlowToolNullSelectionState uniqueInstance
]

{ #category : #actions }
GtPhlowToolCircularSelectionStateHandler >> storeSelectionStateFrom: aToolElement [
	| aState |
	aToolElement phlow isTool ifFalse: [ ^ self ].

	aState := aToolElement phlow entity
			extractSelectionStateFromElement: aToolElement.
	self addSelectionState: aState.

	GtPhlowStoreToolSelectionSignal new
		toolElement: aToolElement;
		phlowView: aToolElement phlow entity;
		selectionState: selectionStates first;
		emit
]
