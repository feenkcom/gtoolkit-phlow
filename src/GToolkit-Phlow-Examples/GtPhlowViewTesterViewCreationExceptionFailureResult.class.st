Class {
	#name : #GtPhlowViewTesterViewCreationExceptionFailureResult,
	#superclass : #GtPhlowViewTesterExceptionFailureResult,
	#instVars : [
		'exceptionElement'
	],
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterViewCreationExceptionFailureResult >> exceptionElement [
	^ exceptionElement
]

{ #category : #accessing }
GtPhlowViewTesterViewCreationExceptionFailureResult >> exceptionElement: anException [
	exceptionElement := anException
]

{ #category : #accessing }
GtPhlowViewTesterViewCreationExceptionFailureResult >> exceptionElements [
	^ { self enclosedElement }
]
