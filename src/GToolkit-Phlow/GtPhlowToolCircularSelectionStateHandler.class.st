Class {
	#name : #GtPhlowToolCircularSelectionStateHandler,
	#superclass : #Object,
	#traits : 'TGtPhlowToolSelectionStateHandler',
	#classTraits : 'TGtPhlowToolSelectionStateHandler classTrait',
	#instVars : [
		'selectionStates',
		'maxSelectionStates'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #private }
GtPhlowToolCircularSelectionStateHandler >> addSelectionState: aState [
	aState ifNil: [ ^ self ].
	aState = GtPhlowToolNullSelectionState uniqueInstance ifTrue: [ ^ self ].

	selectionStates addFirst: aState.

	selectionStates size <= self maxSelectionStates ifTrue: [ ^ self ].
	selectionStates removeLast
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

{ #category : #'gt - extensions' }
GtPhlowToolCircularSelectionStateHandler >> gtSelectionStatesFor: aView [
	<gtView>
	selectionStates ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Selection states';
		items: [ selectionStates ifNil: [ #() ] ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #initialization }
GtPhlowToolCircularSelectionStateHandler >> initialize [
	super initialize.
	
	self resetStoredSelectionState.
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandler >> maxSelectionStates [
	^ maxSelectionStates ifNil: [ maxSelectionStates := 20 ]
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandler >> maxSelectionStates: anInteger [
	self
		assert: [ anInteger isInteger ]
		description: [ 'Maximum selection states must be an integer' format: {anInteger} ].

	maxSelectionStates := anInteger max: 1
]

{ #category : #private }
GtPhlowToolCircularSelectionStateHandler >> moveSelectionState: aState [
	aState ifNil: [ ^ self ].
	aState = GtPhlowToolNullSelectionState uniqueInstance ifTrue: [ ^ self ].

	selectionStates remove: aState.
	selectionStates addFirst: aState
]

{ #category : #copying }
GtPhlowToolCircularSelectionStateHandler >> postSimilarSelectionStateHandler [
	selectionStates := selectionStates copy
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
