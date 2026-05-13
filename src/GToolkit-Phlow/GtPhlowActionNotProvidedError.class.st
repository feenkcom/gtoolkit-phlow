Class {
	#name : #GtPhlowActionNotProvidedError,
	#superclass : #Error,
	#instVars : [
		'object',
		'selector',
		'arguments',
		'parentAction',
		'returnedObject'
	],
	#category : #'GToolkit-Phlow-Support - Exceptions'
}

{ #category : #'ui - building' }
GtPhlowActionNotProvidedError >> actionMethod [
	^ object class lookupSelector: selector
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> arguments [
	^ arguments
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> object [
	^ object
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> object: anObject [
	object := anObject
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> parentAction [
	^ parentAction
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> parentAction: anObject [
	parentAction := anObject
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> returnedObject [
	^ returnedObject
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> returnedObject: anObject [
	returnedObject := anObject
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> selector [
	^ selector
]

{ #category : #accessing }
GtPhlowActionNotProvidedError >> selector: anObject [
	selector := anObject
]
