Class {
	#name : #GtPhlowTextNullStylerSpecification,
	#superclass : #GtPhlowTextStylerSpecification,
	#category : #'GToolkit-Phlow-Text - Styling'
}

{ #category : #testing }
GtPhlowTextNullStylerSpecification >> canAffectText [
	^ false
]

{ #category : #styling }
GtPhlowTextNullStylerSpecification >> createBlStyler [
	^ BlTextNullStyler new
]
