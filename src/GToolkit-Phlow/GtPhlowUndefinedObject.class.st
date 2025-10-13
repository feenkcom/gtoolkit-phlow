"
I am a basic value holder, identifying that a value does not exist.
Users can use {{gtMethod:GtCoderUndefinedObject>>#ifDefined:ifNone:}} to distinguish between defined and undefined values.

"
Class {
	#name : #GtPhlowUndefinedObject,
	#superclass : #Object,
	#traits : 'TGtPhlowObject + TGtUniqueInstance',
	#classTraits : 'TGtPhlowObject classTrait + TGtUniqueInstance classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Phlow-Object Holder'
}

{ #category : #printing }
GtPhlowUndefinedObject >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Missing object'
]

{ #category : #'api - accessing' }
GtPhlowUndefinedObject >> ifDefined: definedBlock ifNone: noneBlock [
	^ noneBlock value
]

{ #category : #printing }
GtPhlowUndefinedObject >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: 'Missing object';
		nextPut: $)
]
