Class {
	#name : #GtPhlowTextFutureColumnContext,
	#superclass : #GtPhlowColumnContext,
	#instVars : [
		'result',
		'successText',
		'exceptionText',
		'futureException',
		'pendingException',
		'successException'
	],
	#category : 'GToolkit-Phlow-Support'
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
GtPhlowTextFutureColumnContext >> futureException [
	^ futureException
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> futureException: anException [
	futureException := anException
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> pendingException [
	^ pendingException
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> pendingException: anObject [
	pendingException := anObject
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
GtPhlowTextFutureColumnContext >> successException [
	^ successException
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> successException: anObject [
	successException := anObject
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> successText [
	^ successText
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> successText: anObject [
	successText := anObject
]
