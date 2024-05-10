Class {
	#name : #GtPhlowOverviewItem,
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'value'
	],
	#category : #'GToolkit-Phlow-Convenience and Utilities'
}

{ #category : #accessing }
GtPhlowOverviewItem >> description [
	^ description ifNil: [ description := '' ]
]

{ #category : #accessing }
GtPhlowOverviewItem >> description: anObject [
	description := anObject
]

{ #category : #convenience }
GtPhlowOverviewItem >> if: aBoolean description: aStringOrBlText [
	aBoolean ifFalse: [ ^ self ].
	self description: aStringOrBlText
]

{ #category : #convenience }
GtPhlowOverviewItem >> if: aBoolean subduedDescription: aStringOrBlText [
	| aText |
	aBoolean ifFalse: [ ^ self ].
	aText := aStringOrBlText asRopedText foreground: BrGlamorousColors disabledButtonTextColor.
	self description: aText 
]

{ #category : #accessing }
GtPhlowOverviewItem >> name [
	^ name ifNil: [ name := '' ]
]

{ #category : #accessing }
GtPhlowOverviewItem >> name: anObject [
	name := anObject
]

{ #category : #convenience }
GtPhlowOverviewItem >> toCollection: aCollection [
	aCollection add: self
]

{ #category : #convenience }
GtPhlowOverviewItem >> toStream: aStream [
	aStream nextPut: self
]

{ #category : #accessing }
GtPhlowOverviewItem >> value [
	^ value
]

{ #category : #accessing }
GtPhlowOverviewItem >> value: anObject [
	value := anObject
]
