Class {
	#name : #GtPhlowToolCircularSelectionStateHandler,
	#superclass : #Object,
	#traits : 'TGtPhlowToolSelectionStateHandler',
	#classTraits : 'TGtPhlowToolSelectionStateHandler classTrait',
	#instVars : [
		'selectionStates',
		'maxSelectionStates',
		'announcer'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #private }
GtPhlowToolCircularSelectionStateHandler >> addSelectionState: aState [
	aState ifNil: [ ^ self ].
	aState = GtPhlowToolNullSelectionState uniqueInstance ifTrue: [ ^ self ].

	selectionStates removeAllSuchThat: [ :eachState | eachState = aState ].
	selectionStates addFirst: aState.

	selectionStates size <= self maxSelectionStates ifTrue: [ ^ self ].
	selectionStates removeLast
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandler >> announcer [
	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
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
					^ self ]
				ifNotApplied: [  ] ]
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandler >> decreaseMaxSelectionStates [
	self maxSelectionStates: self maxSelectionStates - 1
]

{ #category : #printing }
GtPhlowToolCircularSelectionStateHandler >> gtDisplayOn: aStream [
	selectionStates ifNil: [ ^ super gtDisplayOn: aStream ].

	aStream
		nextPutAll: 'Circular selection state: ';
		print: selectionStates size;
		nextPutAll: (' item' asPluralBasedOn: selectionStates size);
		nextPutAll: ', max: ';
		print: self maxSelectionStates
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

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandler >> increaseMaxSelectionStates [
	self maxSelectionStates: self maxSelectionStates + 1
]

{ #category : #initialization }
GtPhlowToolCircularSelectionStateHandler >> initialize [
	super initialize.
	
	maxSelectionStates := 1.
	announcer := Announcer new.
	self resetStoredSelectionState.
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandler >> maxSelectionStates [
	^ maxSelectionStates ifNil: [ maxSelectionStates := 1 ]
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandler >> maxSelectionStates: anInteger [
	| anOldMaxSelectionStates aNewMaxSelectionStates |
	self
		assert: [ anInteger isInteger ]
		description: [ 'Maximum selection states must be an integer' format: {anInteger} ].

	aNewMaxSelectionStates := anInteger max: 1.
	maxSelectionStates = aNewMaxSelectionStates ifTrue: [ ^ self ].

	anOldMaxSelectionStates := maxSelectionStates.
	maxSelectionStates := aNewMaxSelectionStates.
	self shrinkSelectionStatesToMaxSelectionStates.

	self announcer
		announce: (GtPhlowToolCircularSelectionStateHandlerMaxSelectionStatesChanged new
				selectionStateHandler: self;
				oldMaxSelectionStates: anOldMaxSelectionStates;
				maxSelectionStates: aNewMaxSelectionStates)
]

{ #category : #private }
GtPhlowToolCircularSelectionStateHandler >> moveSelectionState: aState [
	aState ifNil: [ ^ self ].
	aState = GtPhlowToolNullSelectionState uniqueInstance ifTrue: [ ^ self ].

	selectionStates remove: aState.
	selectionStates addFirst: aState
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandler >> numberOfSelectionStates [
	^ selectionStates size
]

{ #category : #copying }
GtPhlowToolCircularSelectionStateHandler >> postSimilarSelectionStateHandler [
	selectionStates := selectionStates copy.
	announcer := Announcer new
]

{ #category : #printing }
GtPhlowToolCircularSelectionStateHandler >> printOn: aStream [
	super printOn: aStream.
	selectionStates ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		print: selectionStates size;
		nextPutAll: (' item' asPluralBasedOn: selectionStates size);
		nextPutAll: ', max: ';
		print: self maxSelectionStates;
		nextPut: $)
]

{ #category : #initialization }
GtPhlowToolCircularSelectionStateHandler >> resetStoredSelectionState [
	selectionStates := LinkedList new
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandler >> shrinkSelectionStatesToMaxSelectionStates [
	[ selectionStates size > self maxSelectionStates ]
		whileTrue: [ selectionStates removeLast ]
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
