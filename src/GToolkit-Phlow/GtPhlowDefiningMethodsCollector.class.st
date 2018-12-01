Class {
	#name : #GtPhlowDefiningMethodsCollector,
	#superclass : #Object,
	#instVars : [
		'stack',
		'methods'
	],
	#category : #'GToolkit-Phlow-Builders'
}

{ #category : #actions }
GtPhlowDefiningMethodsCollector >> collect [
	| aMethods |
	aMethods := OrderedCollection new.
	2 to: (self stack size min: 5) do: [ :anIndex | 
		| aCompiledMethod |
		aCompiledMethod := (self stack at: anIndex) method.
		(aCompiledMethod hasPragmaNamed: #gtCollector)
			ifTrue: [ ^ self definingMethodsFrom: aMethods ].
		aMethods addFirst: aCompiledMethod asRingDefinition ].
	^ self definingMethodsFrom: aMethods 
]

{ #category : #actions }
GtPhlowDefiningMethodsCollector >> definingMethodsFrom: aMethods [
	aMethods size = 1 ifTrue: [ ^ aMethods first ].
	^ GtPhlowDefiningMethods new methods: aMethods
]

{ #category : #initialization }
GtPhlowDefiningMethodsCollector >> initialize [
	super initialize.
	methods := OrderedCollection new.
	stack := nil.
]

{ #category : #accessing }
GtPhlowDefiningMethodsCollector >> stack [
	^ stack
]

{ #category : #accessing }
GtPhlowDefiningMethodsCollector >> stack: anObject [
	stack := anObject
]
