Class {
	#name : #GtPhlowToolCommonViewModel,
	#superclass : #Object,
	#traits : 'TGtPhlowToolViewModel',
	#classTraits : 'TGtPhlowToolViewModel classTrait',
	#instVars : [
		'context',
		'viewModelSelector',
		'objectSelector',
		'type'
	],
	#category : #'GToolkit-Phlow-Tool - Navigation'
}

{ #category : #accessing }
GtPhlowToolCommonViewModel >> context [
	<return: #GtPhlowElementContext>
	^ context
]

{ #category : #accessing }
GtPhlowToolCommonViewModel >> context: anObject [
	context := anObject
]

{ #category : #'api - accessing' }
GtPhlowToolCommonViewModel >> element [
	^ self context element
]

{ #category : #'api - accessing' }
GtPhlowToolCommonViewModel >> object [
	"Return a tool view model"

	^ self element perform: self objectSelector
]

{ #category : #accessing }
GtPhlowToolCommonViewModel >> objectSelector [
	^ objectSelector
]

{ #category : #accessing }
GtPhlowToolCommonViewModel >> objectSelector: anObject [
	objectSelector := anObject
]

{ #category : #accessing }
GtPhlowToolCommonViewModel >> type [
	^ type
]

{ #category : #accessing }
GtPhlowToolCommonViewModel >> type: anObject [
	type := anObject
]

{ #category : #'api - accessing' }
GtPhlowToolCommonViewModel >> viewModel [
	"Return a tool view model"

	^ self element perform: self viewModelSelector
]

{ #category : #accessing }
GtPhlowToolCommonViewModel >> viewModelSelector [
	^ viewModelSelector
]

{ #category : #accessing }
GtPhlowToolCommonViewModel >> viewModelSelector: anObject [
	viewModelSelector := anObject
]
