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
