Class {
	#name : #GtPhlowToolNullTabIdentifier,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'toolName',
		'toolClassName'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #testing }
GtPhlowToolNullTabIdentifier >> matchesTab: aTabModel [
	<return: #Boolean>
	^ false
]
