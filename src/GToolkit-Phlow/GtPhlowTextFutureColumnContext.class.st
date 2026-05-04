Class {
	#name : #GtPhlowTextFutureColumnContext,
	#superclass : #GtPhlowColumnContext,
	#instVars : [
		'result',
		'successText',
		'exceptionText'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> exceptionText [
	^ exceptionText
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> exceptionText: anObject [
	exceptionText := anObject
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> result [
	"Return result of the future execution"

	^ result
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> result: anObject [
	result := anObject
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> successText [
	^ successText
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> successText: anObject [
	successText := anObject
]
