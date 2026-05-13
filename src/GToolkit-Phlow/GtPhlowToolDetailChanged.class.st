"
I am used to inform an element about a level of information detail level changes.
See {{gtClass:GtPhlowToolDetailState}} for more details.


"
Class {
	#name : #GtPhlowToolDetailChanged,
	#superclass : #BlElementStateEvent,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #accessing }
GtPhlowToolDetailChanged >> level [
	<return: #Symbol>
	^ level
]

{ #category : #accessing }
GtPhlowToolDetailChanged >> level: aSymbol [
	level := aSymbol.
]

{ #category : #printing }
GtPhlowToolDetailChanged >> printOn: aStream [
	aStream
		nextPutAll: 'Tool Volume Changed: ';
		print: self level
]

{ #category : #accessing }
GtPhlowToolDetailChanged >> state: anObject [
	"Override me to properly set the given state"

	self level: anObject
]
