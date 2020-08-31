Class {
	#name : #GtPhlowToolChangedObjectWish,
	#superclass : #BrWish,
	#instVars : [
		'object',
		'hasObject'
	],
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #visiting }
GtPhlowToolChangedObjectWish >> acceptPhlowHandler: aHandler [
	^ aHandler visitToolChangedObjectWish: self
]

{ #category : #'api - testing' }
GtPhlowToolChangedObjectWish >> hasObject [
	^ hasObject
]

{ #category : #initialization }
GtPhlowToolChangedObjectWish >> initialize [
	super initialize.
	hasObject := false.
]

{ #category : #'api - accessing' }
GtPhlowToolChangedObjectWish >> object [
	^ object
]

{ #category : #'api - accessing' }
GtPhlowToolChangedObjectWish >> object: anObject [
	object := anObject.
	hasObject := true.
	self consumed: true.
]
