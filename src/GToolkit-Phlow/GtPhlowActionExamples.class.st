Class {
	#name : #GtPhlowActionExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #private }
GtPhlowActionExamples >> errorActionFor: aView [
	<gtAction>
	1 / 0
]

{ #category : #private }
GtPhlowActionExamples >> errorExample [
	<gtExample>
	| debugButton |
	debugButton := self gtActions last asElementDo: [ :x | x ] withElement: nil.
	self assert: (debugButton isKindOf: BrButton).
	^ debugButton 
]
