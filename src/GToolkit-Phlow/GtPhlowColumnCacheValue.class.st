Class {
	#name : #GtPhlowColumnCacheValue,
	#superclass : #Object,
	#instVars : [
		'futureResultHolder',
		'exceptionResultHolder',
		'successResultHolder'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowColumnCacheValue >> exceptionResult [
	^ exceptionResultHolder value
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> exceptionResult: anObject [
	exceptionResultHolder := GtPhlowObject forValue: anObject
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> exceptionResultHolder [
	^ exceptionResultHolder
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> futureResult [
	^ futureResultHolder value
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> futureResult: anObject [
	futureResultHolder := GtPhlowObject forValue: anObject
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> futureResultHolder [
	^ futureResultHolder
]

{ #category : #'as yet unclassified' }
GtPhlowColumnCacheValue >> initialize [
	super initialize.

	futureResultHolder := GtPhlowUndefinedObject default.
	exceptionResultHolder := GtPhlowUndefinedObject default.
	successResultHolder := GtPhlowUndefinedObject default
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> successResult [
	^ successResultHolder value
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> successResult: anObject [
	successResultHolder := GtPhlowObject forValue: anObject
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> successResultHolder [
	^ successResultHolder
]
