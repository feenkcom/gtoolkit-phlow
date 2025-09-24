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

{ #category : #enumerating }
GtPhlowActionUniqueTarget class >> actionsForObject: anObject do: aBlock [
	self default actionsForObject: anObject do: aBlock
]

{ #category : #converting }
GtPhlowActionUniqueTarget class >> asPhlowTarget [
	^ self default
]

{ #category : #converting }
GtPhlowActionUniqueTarget class >> menuItemsForObject: anObject hostElement: aHostElement [
	<return: #BrMenuItems>
	^ self default menuItemsForObject: anObject hostElement: aHostElement
]

{ #category : #converting }
GtPhlowActionUniqueTarget class >> menuItemsForObject: anObject inContext: aPhlowContext hostElement: aHostElement [
	<return: #BrMenuItems>
	^ self default menuItemsForObject: anObject inContext: aPhlowContext hostElement: aHostElement
]
