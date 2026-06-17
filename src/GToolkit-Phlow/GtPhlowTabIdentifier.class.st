Class {
	#name : #GtPhlowTabIdentifier,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #printing }
GtPhlowTabIdentifier >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn:  aStream ]
]

{ #category : #printing }
GtPhlowTabIdentifier >> descriptionOn: aStream [
]

{ #category : #testing }
GtPhlowTabIdentifier >> matchesTab: aTabModel [
	<return: #Boolean>
	^ self subclassResponsibility
]
