Class {
	#name : #GtPhlowToolDetailPositionChanged,
	#superclass : #BlElementStateEvent,
	#instVars : [
		'position'
	],
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #accessing }
GtPhlowToolDetailPositionChanged >> position [
	^ position
]

{ #category : #accessing }
GtPhlowToolDetailPositionChanged >> position: anObject [
	position := anObject
]

{ #category : #printing }
GtPhlowToolDetailPositionChanged >> printOn: aStream [
	aStream
		nextPutAll: 'Tool detail position changed: ';
		print: (self position ifNotNil: #position)
]
