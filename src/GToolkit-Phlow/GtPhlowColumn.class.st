"
I keep information to configure ${class:BrColumn}$ instances.
I am used by ${class:GtPhlowColumnedListView}$ and ${class:GtPhlowColumnedTreeView}$.

"
Class {
	#name : #GtPhlowColumn,
	#superclass : #Object,
	#traits : 'TGtPhlowErrorTolerantCell - {#errorTreatedCellTypeFor:}',
	#classTraits : 'TGtPhlowErrorTolerantCell classTrait',
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
	cellStencil := self errorTreatedCellStencilFor: aBlockOrSymbol
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
	dataBinder := self errorTreatedCellDataBinderFor: aBlockOrSymbol
]

{ #category : #defaults }
GtPhlowColumn >> defaultHeaderElementBuilder [
	^ [ :aTitle :aPhlowColumn | self buildHeaderElementFor: aTitle forColumn: aPhlowColumn ]
]

{ #category : #defaults }
GtPhlowColumn >> defaultItemComputation [
	^ [ :eachItem :eachRowIndex :eachColumnIndex | eachItem ]
]

{ #category : #defaults }
GtPhlowColumn >> defaultResizer [
	^ BlLayoutResizer matchParent
]

{ #category : #defaults }
GtPhlowColumn >> defaultTextStencil [
	^ [ :anItem :aRowIndex :aColumnIndex :aBrLabel :aGtPhlowColumn | anItem ]
]

{ #category : #defaults }
GtPhlowColumn >> defaultTitle [
	^ 'Column'
]

{ #category : #defaults }
GtPhlowColumn >> defaultWidth [
	^ GtPhlowColumnProportionalWidth new
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

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> icon: aBlockOrSymbol [
	self cellStencil: [ self newIconContainer ].
	self dataBinder: [ :anIconContainer :anItem :aRowIndex :aRowHolder :aColumnIndex |
		| aValue anIcon anElement |
		aValue := self itemComputation phlowValue: anItem withEnoughArguments: { anItem. aRowIndex. aColumnIndex. anIconContainer. self }.
		anIcon := aBlockOrSymbol phlowValue: aValue withEnoughArguments: { aValue. aRowIndex. aColumnIndex. anIconContainer. self }.
		anElement := anIcon asElement labeled: 'Icon'.
		anIconContainer
			removeChildren;
			addChild: anElement. ]
]

{ #category : #initialization }
GtPhlowColumn >> initialize [
	super initialize.
	title := self defaultTitle.
	titleStencil := self defaultHeaderElementBuilder.
	itemComputation := self defaultItemComputation.
	width := self defaultWidth.
	resizer := self defaultResizer.
	self text: self defaultTextStencil
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

{ #category : #'scripting - deprecated' }
GtPhlowColumn >> itemStencil: aRowStencil [
	self 
		deprecated: 'Please use #stencil: instead.'
		transformWith: '`@receiver itemStencil: `@statements' -> '`@receiver stencil: `@statements'.
	self stencil: aRowStencil
]

{ #category : #'api - scripting cell width' }
GtPhlowColumn >> matchParent [
	self weight: 1.
	self resizer: BlLayoutResizer matchParent
]

{ #category : #'private - building' }
GtPhlowColumn >> newIconContainer [
	^ BrHorizontalPane new
	 	alignCenter;
		fitContent
]

{ #category : #'private - building' }
GtPhlowColumn >> newItemLabel [
	^ BrLabel new
		look: BrGlamorousListLabelLook;
		alignCenterLeft;
		hMatchParent;
		vFitContent
]

{ #category : #'api - scripting cell width' }
GtPhlowColumn >> noResize [
	resizer := nil.
	width := BrColumnUndefinedWidth new.
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

{ #category : #'scripting - deprecated' }
GtPhlowColumn >> rowStencil: aRowStencil [
	self 
		deprecated: 'Please use #stencil: instead.'
		transformWith: '`@receiver rowStencil: `@statements' -> '`@receiver stencil: `@statements'.
	self stencil: aRowStencil
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
	self dataBinder: [ :aCellWrapper :aRowObject :aRowIndex :aRowHolder :aColumnIndex |
		aCellWrapper
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

	width := GtPhlowColumnProportionalWidth new weight: aNumber
]

{ #category : #'api - scripting cell width' }
GtPhlowColumn >> width: aNumber [
	"Make column occupy a fixed space defined by aNumber"

	width := BrColumnFixedWidth new width: aNumber.
	self resizer: (BlLayoutResizer exact: aNumber asFloat).
]
