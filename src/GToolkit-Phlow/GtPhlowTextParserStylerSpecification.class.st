Class {
	#name : #GtPhlowTextParserStylerSpecification,
	#superclass : #GtPhlowTextStylerSpecification,
	#instVars : [
		'parserClassName'
	],
	#category : #'GToolkit-Phlow-Text - Styling'
}

{ #category : #styling }
GtPhlowTextParserStylerSpecification >> createBlStyler [
	^ self parserClassName asClass gtStyler
]

{ #category : #accessing }
GtPhlowTextParserStylerSpecification >> parserClassName [
	^ parserClassName
]

{ #category : #accessing }
GtPhlowTextParserStylerSpecification >> parserClassName: aClassName [
	parserClassName := aClassName
]
