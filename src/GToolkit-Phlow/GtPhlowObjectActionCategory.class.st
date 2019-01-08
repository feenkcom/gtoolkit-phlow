Class {
	#name : #GtPhlowObjectActionCategory,
	#superclass : #GtPhlowActionTarget,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Phlow-Action Targets'
}

{ #category : #cleanup }
GtPhlowObjectActionCategory class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
GtPhlowObjectActionCategory class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
GtPhlowObjectActionCategory class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
