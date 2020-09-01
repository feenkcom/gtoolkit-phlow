"
I am a ${class:BrWish}$.
I am fired by ${class:GtPhlowTool}$ to inform which object (domain model) should be displayed. See ${class:GtPhlowToolChangedObjectHandler}$ and ${class:GtPhlowToolObjectChangeHandler}$ for more information.
!! Example
See a complete example in the ${class:GtPhlowCompositeTool}$ class comment.

"
Class {
	#name : #GtPhlowToolChangedObjectWish,
	#superclass : #BrWish,
	#instVars : [
		'object',
		'hasObject'
	],
	#category : #'GToolkit-Phlow-Tool - Object Changer'
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
