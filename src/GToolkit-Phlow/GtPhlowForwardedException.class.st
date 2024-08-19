Class {
	#name : #GtPhlowForwardedException,
	#superclass : #Object,
	#traits : 'TGtPhlowForwardedObject',
	#classTraits : 'TGtPhlowForwardedObject classTrait',
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowForwardedException >> exception [
	^ exception
]

{ #category : #accessing }
GtPhlowForwardedException >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
GtPhlowForwardedException >> freeze: anException [
	self exception: (GtSystemUtility freeze: anException)
]
