"
I am a basic value holder, identifying an existing value.
Users can use {{gtMethod:GtCoderObject>>#ifDefined:ifNone:}} to distinguish between defined and undefined values.

"
Class {
	#name : #GtPhlowObject,
	#superclass : #Object,
	#traits : 'TGtPhlowObject',
	#classTraits : 'TGtPhlowObject classTrait',
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Phlow-Object Holder'
}

{ #category : #'instance creation' }
GtPhlowObject class >> forValue: anObject [
	^ self new value: anObject
]

{ #category : #comparing }
GtPhlowObject >> = anObject [
	self == anObject ifTrue: [ ^ true ].

	^ self class = anObject class and: [ self value = anObject value ]
]

{ #category : #printing }
GtPhlowObject >> gtDisplayOn: aStream [
	self value gtDisplayOn: aStream
]

{ #category : #comparing }
GtPhlowObject >> hash [
	^ self value hash
]

{ #category : #'api - accessing' }
GtPhlowObject >> ifDefined: definedBlock ifNone: noneBlock [
	^ definedBlock cull: value
]

{ #category : #printing }
GtPhlowObject >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: value;
		nextPut: $)
]

{ #category : #accessing }
GtPhlowObject >> value [
	^ value
]

{ #category : #accessing }
GtPhlowObject >> value: anObject [
	value := anObject
]
