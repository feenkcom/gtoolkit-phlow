Class {
	#name : #GtPhlowColumn,
	#superclass : #Object,
	#instVars : [
		'resizer',
		'rowStencil',
		'title',
		'titleStencil',
		'itemComputation',
		'cellStencil',
		'dataBinder',
		'width'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'private - building' }
GtPhlowColumn >> buildHeaderElementFor: aText forColumn: aPhlowColumn [
	| aLabel |
	aLabel := BrLabel new
		look: BrGlamorousLabelLook;
		text: (aText asRopedText foreground: BrGlamorousColors defaultButtonTextColor).
	self cellWidth applyOn: aLabel.
	^ aLabel
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

{ #category : #'private - accessing' }
GtPhlowColumn >> cellStencil [
	^ cellStencil
]

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> cellStencil: aBlockOrSymbol [
	cellStencil := aBlockOrSymbol
]

{ #category : #'private - accessing' }
GtPhlowColumn >> cellWidth [
	^ width
]

{ #category : #'api - building' }
GtPhlowColumn >> configureColumn: aBrColumn [
	aBrColumn 
		title: self title;
		cellStencil: self cellStencil;
		dataBinder: self dataBinder;
		cellWidth: self cellWidth.
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

{ #category : #'private - accessing' }
GtPhlowColumn >> dataBinder [
	^ dataBinder
]

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> dataBinder: aBlockOrSymbol [ 
	dataBinder := aBlockOrSymbol
]

{ #category : #defaults }
GtPhlowColumn >> defaultItemComputation [
	^ [ :eachItem :eachRowIndex :eachColumnIndex | eachItem ]
]

{ #category : #defaults }
GtPhlowColumn >> defaultTextStencil [
	^ [ :anItem :aRowIndex :aColumnIndex :aBrLabel :aGtPhlowColumn | anItem ]
]

{ #category : #'scripting - deprecated' }
GtPhlowColumn >> evaluated: aBlock [
	self 
		deprecated: 'Please use #item: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver item: `@statements'.
	self item: aBlock
]

{ #category : #'api - scripting cell width' }
GtPhlowColumn >> fitContent [
	self resizer: BlLayoutResizer fitContent
]

{ #category : #initialization }
GtPhlowColumn >> initialize [
	super initialize.
	resizer := BlLayoutResizer matchParent.
	title := 'Column'.
	titleStencil := [ :aTitle :aPhlowColumn | self buildHeaderElementFor: aTitle forColumn: aPhlowColumn ].
	itemComputation := self defaultItemComputation.
	width := BrColumnUndefinedWidth new.
	self text: self defaultTextStencil.
	
]

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> item: aBlockOrSymbol [
	itemComputation := aBlockOrSymbol
]

{ #category : #'private - accessing' }
GtPhlowColumn >> itemComputation [
	^ itemComputation
]

{ #category : #'scripting - deprecated' }
GtPhlowColumn >> itemFormat: aBlockOrSymbol [
	self 
		deprecated: 'Please use #text: instead.'
		transformWith: '`@receiver itemFormat: `@argument' -> '`@receiver text: `@argument'.
	self text: aBlockOrSymbol
]

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> itemStencil: aRowStencil [
	self rowStencil: aRowStencil
]

{ #category : #'api - scripting cell width' }
GtPhlowColumn >> matchParent [
	self resizer: BlLayoutResizer matchParent
]

{ #category : #'private - building' }
GtPhlowColumn >> newItemLabel [
	^ BrLabel new
		look: BrGlamorousListLabelLook;
		hMatchParent;
		vFitContent
]

{ #category : #'api - scripting cell width' }
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

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> rowStencil: aRowStencil [
	rowStencil := aRowStencil
]

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> stencil: aBlock [
	"aStencil is a BlockClosure of type [ :aRowObject :aRowIndex :aCellIndex ]"

	self cellStencil: [
		| aCellWrapper |
		aCellWrapper := BlElement new
			layout: BlFrameLayout new;
			constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal matchParent ].
		aCellWrapper ].
	self dataBinder: [ :_ :aRowObject :aRowIndex :aRowHolder :aColumnIndex |
		(aRowHolder columnElements at: aColumnIndex)
			removeChildren
			addChild: (aBlock cull: aRowObject cull: aRowIndex cull: aColumnIndex) asElement ]
]

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> text: aBlockOrSymbol [
	self cellStencil: [ self newItemLabel ].
	self dataBinder: [ :aLabel :anItem :aRowIndex :aRowHolder :aColumnIndex |
		| aValue aText |
		aValue := self itemComputation phlowValue: anItem withEnoughArguments: { anItem. aRowIndex. aColumnIndex. aLabel. self }.
		aText := aBlockOrSymbol phlowValue: aValue withEnoughArguments: { aValue. aRowIndex. aColumnIndex. aLabel. self }.
		aLabel text: aText asRopedText. ]
]

{ #category : #'private - accessing' }
GtPhlowColumn >> title [
	^ title
]

{ #category : #'api - scripting' }
GtPhlowColumn >> title: anObject [
	title := anObject
]

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> titleStencil: aStencil [
	titleStencil := aStencil
]

{ #category : #'api - scripting cell width' }
GtPhlowColumn >> weight: aNumber [
	"Make a column match parent with a given proportion as a number (usually between 0 and 1)"

	width := BrColumnProportionalWidth new weight: aNumber
]

{ #category : #'api - scripting cell width' }
GtPhlowColumn >> width: aNumber [
	"Make column occupy a fixed space defined by aNumber"

	width := BrColumnFixedWidth new width: aNumber.
	self resizer: (BlLayoutResizer exact: aNumber asFloat).
]
