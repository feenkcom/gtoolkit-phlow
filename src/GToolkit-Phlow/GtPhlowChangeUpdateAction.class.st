Class {
	#name : #GtPhlowChangeUpdateAction,
	#superclass : #Object,
	#traits : 'TGtPhlowChangeUpdateAction',
	#classTraits : 'TGtPhlowChangeUpdateAction classTrait',
	#instVars : [
		'preparationResult',
		'changeContext',
		'changeAction'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #accessing }
GtPhlowChangeUpdateAction >> changeAction [
	^ changeAction
]

{ #category : #accessing }
GtPhlowChangeUpdateAction >> changeAction: anObject [
	changeAction := anObject
]

{ #category : #accessing }
GtPhlowChangeUpdateAction >> changeContext [
	^ changeContext
]

{ #category : #accessing }
GtPhlowChangeUpdateAction >> changeContext: anObject [
	changeContext := anObject
]

{ #category : #'api - execution' }
GtPhlowChangeUpdateAction >> execute [
	self changeAction ifNil: [ ^ self ].
	self changeContext ifNil: [ ^ self ].

	self changeAction 
		update: self preparationResult 
		on: self changeContext
]

{ #category : #accessing }
GtPhlowChangeUpdateAction >> preparationResult [
	^ preparationResult
]

{ #category : #accessing }
GtPhlowChangeUpdateAction >> preparationResult: anObject [
	preparationResult := anObject
]
