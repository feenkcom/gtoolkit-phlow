Class {
	#name : #GtPhlowTextStylerSpecification,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Text - Styling'
}

{ #category : #testing }
GtPhlowTextStylerSpecification >> canAffectText [
	^ true
]

{ #category : #styling }
GtPhlowTextStylerSpecification >> createBlStyler [
	^ self subclassResponsibility
]
