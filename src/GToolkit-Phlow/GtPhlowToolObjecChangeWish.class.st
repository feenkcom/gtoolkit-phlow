"
I am fired by ${class:GtPhlowTool}$ widgets to inform that user changed a displayed object and would like to reflect the change in other composed tool widgets of a ${class:GtPhlowCompositeTool}$.
"
Class {
	#name : #GtPhlowToolObjecChangeWish,
	#superclass : #BrWish,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #visiting }
GtPhlowToolObjecChangeWish >> acceptPhlowHandler: aHandler [
	^ aHandler visitToolObjectChangeWish: self
]

{ #category : #'api - accessing' }
GtPhlowToolObjecChangeWish >> object [
	^ object
]

{ #category : #'api - accessing' }
GtPhlowToolObjecChangeWish >> object: anObject [
	object := anObject
]
