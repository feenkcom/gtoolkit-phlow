Class {
	#name : #GtPhlowColumnCacheKey,
	#superclass : #Object,
	#instVars : [
		'rowItem',
		'rowIndex'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #comparing }
GtPhlowColumnCacheKey >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ self rowIndex = anObject rowIndex and: [ self rowItem = anObject rowItem ]
]

{ #category : #comparing }
GtPhlowColumnCacheKey >> hash [
	^ (self class hash hashMultiply bitXor: self rowIndex hash hashMultiply)
		bitXor: self rowItem hash hashMultiply
]

{ #category : #printing }
GtPhlowColumnCacheKey >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: ', row: ';
		print: rowIndex;
		nextPutAll: ', value: ';
		print: rowItem;
		nextPut: $)
]

{ #category : #accessing }
GtPhlowColumnCacheKey >> rowIndex [
	^ rowIndex
]

{ #category : #accessing }
GtPhlowColumnCacheKey >> rowIndex: anObject [
	rowIndex := anObject
]

{ #category : #accessing }
GtPhlowColumnCacheKey >> rowItem [
	^ rowItem
]

{ #category : #accessing }
GtPhlowColumnCacheKey >> rowItem: anObject [
	rowItem := anObject
]
