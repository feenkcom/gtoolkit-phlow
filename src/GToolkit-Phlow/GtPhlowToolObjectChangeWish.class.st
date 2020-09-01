"
I am a ${class:BrWish}$.
I am fired by ${class:GtPhlowTool}$ widgets to inform that user changed a displayed object (domain model) and would like to reflect the change in other  ${class:GtPhlowCompositeTool|label=composed}$ tool widgets. See ${class:GtPhlowToolChangedObjectHandler}$ and ${class:GtPhlowToolObjectChangeHandler}$ for more information.
!! Example
See a complete example in the ${class:GtPhlowCompositeTool}$ class comment.

"
Class {
	#name : #GtPhlowToolObjectChangeWish,
	#superclass : #BrWish,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Phlow-Tool - Object Changer'
}

{ #category : #visiting }
GtPhlowToolObjectChangeWish >> acceptPhlowHandler: aHandler [
	^ aHandler visitToolObjectChangeWish: self
]

{ #category : #'api - accessing' }
GtPhlowToolObjectChangeWish >> object [
	^ object
]

{ #category : #'api - accessing' }
GtPhlowToolObjectChangeWish >> object: anObject [
	object := anObject
]
