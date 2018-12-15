Class {
	#name : #GtPhlowColumn,
	#superclass : #Object,
	#instVars : [
		'resizer',
		'rowStencil',
		'title',
		'itemComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'private - building' }
GtPhlowColumn >> buildRowElementFor: aStringOrText forColumn: aPhlowColumn [
	| rowElement |
		
	rowElement := BrLabel new
		look: BrGlamorousLabelLook;
		text: aStringOrText.
			
	(aPhlowColumn resizer notNil and: [ aPhlowColumn resizer isMatchParent ])
		ifTrue: [
			rowElement addChild: (BlElement new
				background: (BlLinearGradientPaint horizontal from: (Color white alpha: 0) to: Color white);
				constraintsDo: [ :c |
					c ignoreByLayout.
					c ignored horizontal alignRight.
					c vertical matchParent.
					c horizontal exact: 30 ]) ].
	^ rowElement 
]

{ #category : #building }
GtPhlowColumn >> createRowElementFor: anItem atIndex: anIndex [
	| computedValue |
	computedValue := self itemComputation phlowValue: anItem  withEnoughArguments: { anItem . anIndex }.
	^ self rowStencil valueWithEnoughArguments: { computedValue . self }
]

{ #category : #accessing }
GtPhlowColumn >> evaluated: aBlock [
	self 
		deprecated: 'Please use #item: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver item: `@statements'.
	self item: aBlock
]

{ #category : #scripting }
GtPhlowColumn >> fitContent [
	self resizer: BlLayoutResizer fitContent
]

{ #category : #initialization }
GtPhlowColumn >> initialize [
	super initialize.
	
	resizer := BlLayoutResizer matchParent.
	title := 'Column'.
	itemComputation := [ :eachItem :eachIndex | eachItem ].
	rowStencil := [ :eachColumnItem :phlowColumn | 
		| valueToDisplay |
		valueToDisplay := eachColumnItem isString
			ifTrue: [ eachColumnItem ]
			ifFalse: [ (eachColumnItem isKindOf: BlText)
				ifTrue: [ eachColumnItem ]
				ifFalse: [ eachColumnItem gtDisplayString ] ].
		self 
			buildRowElementFor: valueToDisplay
			forColumn: phlowColumn ].
]

{ #category : #scripting }
GtPhlowColumn >> item: aBlockOrSymbol [
	itemComputation := aBlockOrSymbol
]

{ #category : #private }
GtPhlowColumn >> itemComputation [
	^ itemComputation
]

{ #category : #scripting }
GtPhlowColumn >> itemFormat: aBlockOrSymbol [
	self rowStencil: [ :eachColumnItem :phlowColumn | 
		self buildRowElementFor: (aBlockOrSymbol phlowValue: eachColumnItem) forColumn: phlowColumn ]
]

{ #category : #scripting }
GtPhlowColumn >> itemStencil: aRowStencil [
	self rowStencil: aRowStencil
]

{ #category : #scripting }
GtPhlowColumn >> matchParent [
	self resizer: BlLayoutResizer matchParent
]

{ #category : #scripting }
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
GtPhlowColumn >> rowStencil [
	^ rowStencil
]

{ #category : #scripting }
GtPhlowColumn >> rowStencil: aRowStencil [
	rowStencil := aRowStencil
]

{ #category : #scripting }
GtPhlowColumn >> stencil: aRowStencil [
	self 
		deprecated: 'Please use #rowStencil: instead.'
		transformWith: '`@receiver stencil: `@statements' -> '`@receiver rowStencil: `@statements'.
	self rowStencil: aRowStencil
]

{ #category : #private }
GtPhlowColumn >> title [
	^ title
]

{ #category : #scripting }
GtPhlowColumn >> title: anObject [
	title := anObject
]

{ #category : #scripting }
GtPhlowColumn >> width: aNumber [
	self resizer: (BlLayoutResizer exact: aNumber)
]
