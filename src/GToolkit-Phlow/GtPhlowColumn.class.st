Class {
	#name : #GtPhlowColumn,
	#superclass : #Object,
	#instVars : [
		'resizer',
		'rowStencil',
		'title',
		'titleStencil',
		'itemComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'private - building' }
GtPhlowColumn >> buildHeaderElementFor: aText forColumn: aPhlowColumn [
	^ BrLabel new
		look: BrGlamorousLabelLook;
		text: (aText asRopedText foreground: BrGlamorousColors defaultButtonTextColor)
]

{ #category : #'private - building' }
GtPhlowColumn >> buildRowElementFor: aStringOrText forColumn: aPhlowColumn [
	| rowElement |
		
	rowElement := BrLabel new
		look: BrGlamorousListLabelLook;
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

{ #category : #'api - building' }
GtPhlowColumn >> createHeaderRowElement [
	^ (titleStencil valueWithEnoughArguments: {self title . self}) asElement
]

{ #category : #'api - building' }
GtPhlowColumn >> createRowElementFor: anItem atIndex: anIndex [
	"Return an element that represents a cell in the columned list for a given item.
	The amount of cells in a row is equal to amount of columns"
	| computedValue |

	computedValue := self itemComputation phlowValue: anItem  withEnoughArguments: { anItem . anIndex }.
	^ (self rowStencil valueWithEnoughArguments: { computedValue . self }) asElement
]

{ #category : #'api - scripting' }
GtPhlowColumn >> evaluated: aBlock [
	self 
		deprecated: 'Please use #item: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver item: `@statements'.
	self item: aBlock
]

{ #category : #'api - scripting' }
GtPhlowColumn >> fitContent [
	self resizer: BlLayoutResizer fitContent
]

{ #category : #initialization }
GtPhlowColumn >> initialize [
	super initialize.
	
	resizer := BlLayoutResizer matchParent.
	title := 'Column'.
	itemComputation := [ :eachItem :eachIndex | eachItem ].
	
	titleStencil := [ :aTitle :aPhlowColumn | 
		self buildHeaderElementFor: aTitle forColumn: aPhlowColumn ].
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

{ #category : #'api - scripting' }
GtPhlowColumn >> item: aBlockOrSymbol [
	itemComputation := aBlockOrSymbol
]

{ #category : #'private - accessing' }
GtPhlowColumn >> itemComputation [
	^ itemComputation
]

{ #category : #'api - scripting' }
GtPhlowColumn >> itemFormat: aBlockOrSymbol [
	self rowStencil: [ :eachColumnItem :phlowColumn | 
		self buildRowElementFor: (aBlockOrSymbol phlowValue: eachColumnItem) forColumn: phlowColumn ]
]

{ #category : #'api - scripting' }
GtPhlowColumn >> itemStencil: aRowStencil [
	self rowStencil: aRowStencil
]

{ #category : #'api - scripting' }
GtPhlowColumn >> matchParent [
	self resizer: BlLayoutResizer matchParent
]

{ #category : #'api - scripting' }
GtPhlowColumn >> noResize [
	resizer := nil
]

{ #category : #'private - accessing' }
GtPhlowColumn >> resizer [
	^ resizer
]

{ #category : #'private - accessing' }
GtPhlowColumn >> resizer: aBlLayoutResizer [
	resizer := aBlLayoutResizer
]

{ #category : #'private - accessing' }
GtPhlowColumn >> rowStencil [
	^ rowStencil
]

{ #category : #'api - scripting' }
GtPhlowColumn >> rowStencil: aRowStencil [
	rowStencil := aRowStencil
]

{ #category : #'api - scripting' }
GtPhlowColumn >> stencil: aRowStencil [
	self 
		deprecated: 'Please use #rowStencil: instead.'
		transformWith: '`@receiver stencil: `@statements' -> '`@receiver rowStencil: `@statements'.
	self rowStencil: aRowStencil
]

{ #category : #'private - accessing' }
GtPhlowColumn >> title [
	^ title
]

{ #category : #'api - scripting' }
GtPhlowColumn >> title: anObject [
	title := anObject
]

{ #category : #'api - scripting' }
GtPhlowColumn >> titleStencil: aStencil [
	titleStencil := aStencil
]

{ #category : #'api - scripting' }
GtPhlowColumn >> width: aNumber [
	self resizer: (BlLayoutResizer exact: aNumber asFloat)
]
