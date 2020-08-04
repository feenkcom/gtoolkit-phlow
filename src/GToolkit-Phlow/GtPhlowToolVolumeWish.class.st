Class {
	#name : #GtPhlowToolVolumeWish,
	#superclass : #BrWish,
	#instVars : [
		'dimension'
	],
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #'instance creation' }
GtPhlowToolVolumeWish class >> beDetailedTool [
	^ self new dimension: GtPhlowToolVolumeState detailedName
]

{ #category : #'instance creation' }
GtPhlowToolVolumeWish class >> beNormalTool [
	^ self new dimension: GtPhlowToolVolumeState normalName
]

{ #category : #'instance creation' }
GtPhlowToolVolumeWish class >> beVolume: aNamedVolume [
	^ self new dimension: aNamedVolume
]

{ #category : #accessing }
GtPhlowToolVolumeWish >> dimension [
	^ dimension
]

{ #category : #accessing }
GtPhlowToolVolumeWish >> dimension: anObject [
	dimension := anObject
]

{ #category : #initialization }
GtPhlowToolVolumeWish >> initialize [
	super initialize.
	
	dimension := GtPhlowToolVolumeState normalName.
]

{ #category : #printing }
GtPhlowToolVolumeWish >> printOn: aStream [
	aStream
		nextPutAll: 'Tool Volume Wish: ';
		print: self dimension
]
