Class {
	#name : #GtPhlowToolClassType,
	#superclass : #Object,
	#traits : 'TGtPhlowToolType',
	#classTraits : 'TGtPhlowToolType classTrait',
	#instVars : [
		'type'
	],
	#category : #'GToolkit-Phlow-Tool - Navigation'
}

{ #category : #'instance creation' }
GtPhlowToolClassType class >> forClass: aClass [
	^ self new type: aClass
]

{ #category : #printing }
GtPhlowToolClassType >> gtDisplayOn: aStream [
	self type gtDisplayOn: aStream
]

{ #category : #accessing }
GtPhlowToolClassType >> type [
	^ type
]

{ #category : #accessing }
GtPhlowToolClassType >> type: anObject [
	type := anObject
]
