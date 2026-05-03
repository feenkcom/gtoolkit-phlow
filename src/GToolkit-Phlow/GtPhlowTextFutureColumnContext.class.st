Class {
	#name : #GtPhlowTextFutureColumnContext,
	#superclass : #GtPhlowColumnContext,
	#instVars : [
		'result'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> result [
	"Return result of the future execution"

	^ result
]

{ #category : #accessing }
GtPhlowTextFutureColumnContext >> result: anObject [
	result := anObject
]
