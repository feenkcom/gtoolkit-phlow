"
I am a {{gtClass:BrWish}}.
I am fired by {{gtClass:GtPhlowTool}} to inform which object (domain model) should be displayed. See {{gtClass:GtPhlowToolChangedObjectHandler}} and {{gtClass:GtPhlowToolObjectChangeHandler}} for more information.
1. # Example

See a complete example in the {{gtClass:GtPhlowCompositeTool}} class comment.


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
