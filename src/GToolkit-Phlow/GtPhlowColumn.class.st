Class {
	#name : #GtPhlowColumn,
	#superclass : #Object,
	#instVars : [
		'resizer',
		'stencil',
		'title',
		'itemComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowColumn >> evaluated: aBlock [
	self 
		deprecated: 'Please use #item: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver item: `@statements'.
	self item: aBlock
]

{ #category : #accessing }
GtPhlowColumn >> fitContent [
	self resizer: BlLayoutResizer fitContent
]

{ #category : #initialization }
GtPhlowColumn >> initialize [
	super initialize.
	
	resizer := BlLayoutResizer fitContent.
	title := 'Column'.

	itemComputation := [ :eachItem :eachIndex | eachItem ].

	stencil := [ :eachColumnItem :eachItem :currentColumn |
		| columnElement |
		
		columnElement := BrLabel new
			look: BrGlamorousLabelLook;
			text: (eachColumnItem isString
				ifTrue: [ eachColumnItem ]
				ifFalse: [ (eachColumnItem isKindOf: BlText)
					ifTrue: [ eachColumnItem ]
					ifFalse: [ eachColumnItem gtDisplayString ] ]).
			
		(currentColumn resizer notNil and: [ currentColumn resizer isMatchParent ])
			ifTrue: [
				columnElement addChild: (BlElement new
					background: (BlLinearGradientPaint horizontal from: (Color white alpha: 0) to: Color white);
					constraintsDo: [ :c |
						c ignoreByLayout.
						c ignored horizontal alignRight.
						c vertical matchParent.
						c horizontal exact: 30 ]) ].
		columnElement ]
]

{ #category : #accessing }
GtPhlowColumn >> item: aBlockOrSymbol [
	itemComputation := aBlockOrSymbol
]

{ #category : #private }
GtPhlowColumn >> itemComputation [
	^ itemComputation
]

{ #category : #accessing }
GtPhlowColumn >> matchParent [
	self resizer: BlLayoutResizer matchParent
]

{ #category : #accessing }
GtPhlowColumn >> noResize [
	resizer := nil
]

{ #category : #private }
GtPhlowColumn >> resizer [
	^ resizer
]

{ #category : #private }
GtPhlowColumn >> resizer: aBlLayoutResizer [
	resizer := aBlLayoutResizer
]

{ #category : #private }
GtPhlowColumn >> stencil [
	^ stencil
]

{ #category : #accessing }
GtPhlowColumn >> stencil: aColumnStencilBuilder [
	stencil := aColumnStencilBuilder
]

{ #category : #private }
GtPhlowColumn >> title [
	^ title
]

{ #category : #accessing }
GtPhlowColumn >> title: anObject [
	title := anObject
]

{ #category : #accessing }
GtPhlowColumn >> width: aNumber [
	self resizer: (BlLayoutResizer exact: aNumber)
]
