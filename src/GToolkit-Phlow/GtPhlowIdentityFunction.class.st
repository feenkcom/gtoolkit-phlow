Class {
	#name : #GtPhlowIdentityFunction,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #cleanup }
GtPhlowIdentityFunction class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
GtPhlowIdentityFunction class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #evaluation }
GtPhlowIdentityFunction >> phlowValue: aReceiver withEnoughArguments: anArray [
	^ aReceiver
]
