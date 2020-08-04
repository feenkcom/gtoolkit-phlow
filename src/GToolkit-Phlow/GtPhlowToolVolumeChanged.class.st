Class {
	#name : #GtPhlowToolVolumeChanged,
	#superclass : #BrStateChangedEvent,
	#instVars : [
		'dimension'
	],
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #accessing }
GtPhlowToolVolumeChanged >> dimension [
	^ dimension
]

{ #category : #accessing }
GtPhlowToolVolumeChanged >> dimension: anObject [
	dimension := anObject
]

{ #category : #initialization }
GtPhlowToolVolumeChanged >> initialize [
	super initialize.
	
	dimension := GtPhlowToolVolumeState undefinedName.
]

{ #category : #testing }
GtPhlowToolVolumeChanged >> isUndefined [
	^ self dimension = GtPhlowToolVolumeState undefinedName
]

{ #category : #accessing }
GtPhlowToolVolumeChanged >> state: anObject [
	"Override me to properly set the given state"

	self dimension: anObject
]
