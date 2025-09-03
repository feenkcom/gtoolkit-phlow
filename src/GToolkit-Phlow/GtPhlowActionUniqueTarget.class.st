Class {
	#name : #GtPhlowActionUniqueTarget,
	#superclass : #GtPhlowActionTarget,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Action Targets'
}

{ #category : #composing }
GtPhlowActionUniqueTarget class >> + aTarget [
	^ self default + aTarget
]

{ #category : #enumerating }
GtPhlowActionUniqueTarget class >> actionsForObject: anObject [
	^ self default actionsForObject: anObject
]

{ #category : #enumerating }
GtPhlowActionUniqueTarget class >> actionsForObject: anObject collect: aBlock [
	^ self default actionsForObject: anObject collect: aBlock
]

{ #category : #converting }
GtPhlowActionUniqueTarget class >> asPhlowTarget [
	^ self default
]
