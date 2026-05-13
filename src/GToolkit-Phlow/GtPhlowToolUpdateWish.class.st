"
I am {{gtMethod:BlElement>>#fireEvent:|label=fired}} when a user wish to update a whole tool, e.g., {{gtClass:GtInspector}}. Element tools should use {{gtClass:GtPhlowToolUpdateEventHandler}} to handle me properly update wish events.


"
Class {
	#name : #GtPhlowToolUpdateWish,
	#superclass : #BrWish,
	#instVars : [
		'isCurrentToolOnly'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'api - convenience' }
GtPhlowToolUpdateWish class >> onlyCurrentTool [
	^ self new onlyCurrentTool
]

{ #category : #testing }
GtPhlowToolUpdateWish >> isCurrentToolOnly [
	^ isCurrentToolOnly ifNil: [ false ]
]

{ #category : #initialization }
GtPhlowToolUpdateWish >> isCurrentToolOnly: aBoolean [
	isCurrentToolOnly := aBoolean
]

{ #category : #initialization }
GtPhlowToolUpdateWish >> onlyCurrentTool [
	isCurrentToolOnly := true
]

{ #category : #sending }
GtPhlowToolUpdateWish >> sendTo: anObject [ 
	^ anObject phlowToolUpdateWish: self
]
