Class {
	#name : #GtPhlowNullTabIdentifier,
	#superclass : #GtPhlowTabIdentifier,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #accessing }
GtPhlowNullTabIdentifier >> applySelectionTo: anInspectorElement [
	<return: #GtPhlowToolSelectionStateResponse>
	^ GtPhlowToolSelectionStateResponse notApplied
]

{ #category : #printing }
GtPhlowNullTabIdentifier >> descriptionOn: aStream [
	aStream nextPutAll: 'Null identifier'
]

{ #category : #testing }
GtPhlowNullTabIdentifier >> matchesTab: aTabModel [
	^ false
]

{ #category : #printing }
GtPhlowNullTabIdentifier >> printOn: aStream [
	self descriptionOn: aStream
]
