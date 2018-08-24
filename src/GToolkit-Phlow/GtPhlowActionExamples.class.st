Class {
	#name : #GtPhlowActionExamples,
	#superclass : #Object,
	#category : 'GToolkit-Phlow'
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
	debugButton := self gtActions last asElementDo: [ :x | x ].
	self assert: (debugButton isKindOf: BrButton).
	^ debugButton 
]
