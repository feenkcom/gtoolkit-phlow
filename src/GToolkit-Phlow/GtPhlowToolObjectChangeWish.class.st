"
I am a {{gtClass:BrWish}}.
I am fired by {{gtClass:GtPhlowTool}} widgets to inform that user changed a displayed object (domain model) and would like to reflect the change in other  {{gtClass:GtPhlowCompositeTool|label=composed}} tool widgets. See {{gtClass:GtPhlowToolChangedObjectHandler}} and {{gtClass:GtPhlowToolObjectChangeHandler}} for more information.
1. # Example

See a complete example in the {{gtClass:GtPhlowCompositeTool}} class comment.


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

{ #category : #sending }
GtPhlowToolObjectChangeWish >> sendTo: anObject [
	^ anObject phlowToolObjectChangeWish: self
]
