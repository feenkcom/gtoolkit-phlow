Class {
	#name : #GtPhlowObjectEvent,
	#superclass : #BlEvent,
	#instVars : [
		'object',
		'sourceElement'
	],
	#category : 'GToolkit-Phlow'
}

{ #category : #accessing }
GtPhlowObjectEvent >> object [
	^ object
]

{ #category : #accessing }
GtPhlowObjectEvent >> object: anObject [
	object := anObject
]

{ #category : #accessing }
GtPhlowObjectEvent >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
GtPhlowObjectEvent >> sourceElement: anElement [
	sourceElement := anElement
]
