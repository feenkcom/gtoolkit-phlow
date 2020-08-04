Class {
	#name : #GtPhlowToolVolumeState,
	#superclass : #BrInteractionState,
	#instVars : [
		'dimension'
	],
	#category : #'GToolkit-Phlow-Tool - State'
}

{ #category : #'instance creation' }
GtPhlowToolVolumeState class >> detailed [
	^ self new dimension: self detailedName
]

{ #category : #accessing }
GtPhlowToolVolumeState class >> detailedName [
	^ #detailed
]

{ #category : #'instance creation' }
GtPhlowToolVolumeState class >> normal [
	^ self new dimension: self normalName
]

{ #category : #accessing }
GtPhlowToolVolumeState class >> normalName [
	^ #normal
]

{ #category : #'instance creation' }
GtPhlowToolVolumeState class >> undefined [
	^ self new dimension: self undefinedName
]

{ #category : #accessing }
GtPhlowToolVolumeState class >> undefinedName [
	^ #undefined
]

{ #category : #'instance creation' }
GtPhlowToolVolumeState class >> volume: aNamedVolume [
	^ self new dimension: aNamedVolume
]

{ #category : #comparing }
GtPhlowToolVolumeState >> = anotherState [
	^ anotherState class = self class
		and: [ anotherState dimension = self dimension ]
]

{ #category : #accessing }
GtPhlowToolVolumeState >> dimension [
	^ dimension
]

{ #category : #accessing }
GtPhlowToolVolumeState >> dimension: anObject [
	dimension := anObject
]

{ #category : #comparing }
GtPhlowToolVolumeState >> hash [
	^ self class hash bitXor: self dimension hash
]

{ #category : #initialization }
GtPhlowToolVolumeState >> initialize [
	super initialize.

	dimension := self class normalName
]

{ #category : #testing }
GtPhlowToolVolumeState >> isUndefined [
	^ self dimension = self class undefinedName
]

{ #category : #printing }
GtPhlowToolVolumeState >> printOn: aStream [
	aStream
		nextPutAll: 'Tool Volume State: ';
		print: self dimension
]
