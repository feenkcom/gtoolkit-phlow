Class {
	#name : #GtPhlowTextStylerComputableSpecification,
	#superclass : #GtPhlowTextStylerSpecification,
	#instVars : [
		'stylerComputation'
	],
	#category : #'GToolkit-Phlow-Text - Styling'
}

{ #category : #styling }
GtPhlowTextStylerComputableSpecification >> createBlStyler [
	^ self stylerComputation value
]

{ #category : #accessing }
GtPhlowTextStylerComputableSpecification >> stylerComputation [
	^ stylerComputation
]

{ #category : #accessing }
GtPhlowTextStylerComputableSpecification >> stylerComputation: aComputation [
	stylerComputation := aComputation
]
