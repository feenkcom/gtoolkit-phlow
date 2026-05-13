Class {
	#name : #GtPhlowTextClassStylerSpecification,
	#superclass : #GtPhlowTextStylerSpecification,
	#instVars : [
		'stylerClassName'
	],
	#category : #'GToolkit-Phlow-Text - Styling'
}

{ #category : #styling }
GtPhlowTextClassStylerSpecification >> createBlStyler [
	^ self stylerClassName asClass new
]

{ #category : #accessing }
GtPhlowTextClassStylerSpecification >> stylerClassName [
	^ stylerClassName
]

{ #category : #accessing }
GtPhlowTextClassStylerSpecification >> stylerClassName: aClassName [
	stylerClassName := aClassName
]
