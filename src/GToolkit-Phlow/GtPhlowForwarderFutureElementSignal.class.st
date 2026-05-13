Class {
	#name : #GtPhlowForwarderFutureElementSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'phlowView',
		'futureElement',
		'future'
	],
	#category : #'GToolkit-Phlow-Beacon'
}

{ #category : #testing }
GtPhlowForwarderFutureElementSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #accessing }
GtPhlowForwarderFutureElementSignal >> future [
	^ future
]

{ #category : #accessing }
GtPhlowForwarderFutureElementSignal >> future: anObject [
	future := anObject
]

{ #category : #accessing }
GtPhlowForwarderFutureElementSignal >> futureElement [
	^ futureElement
]

{ #category : #accessing }
GtPhlowForwarderFutureElementSignal >> futureElement: anObject [
	futureElement := anObject
]

{ #category : #accessing }
GtPhlowForwarderFutureElementSignal >> phlowView [
	^ phlowView
]

{ #category : #accessing }
GtPhlowForwarderFutureElementSignal >> phlowView: anObject [
	phlowView := anObject
]
