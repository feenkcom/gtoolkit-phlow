"
I search for defining methods on the stack, stopping when I find a method with the `<gtCollector>` pragma. 

For example, I am used in {{gtMethod:name=GtPhlowProtoView>>#empty}}, and the pragma is used in {{gtMethod:name=GtPhlowView>>#on:perform:}}, which performs the view methods. This way the collector starts where the factory method is called, and stops where the view method is performed.
"
Class {
	#name : #GtPhlowDefiningMethodsCollector,
	#superclass : #Object,
	#instVars : [
		'stack',
		'methods'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #accessing }
GtPhlowDefiningMethodsCollector class >> forContext: aContext [
	^self new stack: (aContext stackOfSize: self stackLimit)
]

{ #category : #accessing }
GtPhlowDefiningMethodsCollector class >> stackLimit [
	^5
]

{ #category : #actions }
GtPhlowDefiningMethodsCollector >> collect [
	| aMethods |
	aMethods := OrderedCollection new.
	2
		to: self stack size
		do: [ :anIndex | 
			| aCompiledMethod |
			aCompiledMethod := (self stack at: anIndex) blocDefiningMethod.
			(aCompiledMethod hasPragmaNamed: #gtCollector)
				ifTrue: [ ^ self definingMethodsFrom: aMethods ].
			aMethods addFirst: aCompiledMethod asRingDefinition ].

	2
		to: self stack size
		do: [ :anIndex | 
			| aCompiledMethod |
			aCompiledMethod := (self stack at: anIndex) blocDefiningMethod.
			aCompiledMethod isDoIt
				ifTrue: [  "For doits right now we return the compiled method, 
				as wrapping doits in a Ring definition does work ok"^ aCompiledMethod ].
			(aCompiledMethod hasPragmaNamed: 'gtExample')
				ifTrue: [ ^ aCompiledMethod asRingDefinition ] ].

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
