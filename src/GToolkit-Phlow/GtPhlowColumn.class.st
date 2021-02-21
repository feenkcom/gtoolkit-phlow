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
		'index',
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

{ #category : #'api - building' }
GtPhlowColumn >> buildHeaderElement [
	| aLabel |
	aLabel := (titleStencil valueWithEnoughArguments: {self title. self}) asElement.
	self cellWidth applyOn: aLabel.
	^ aLabel
]

{ #category : #'private - building' }
GtPhlowColumn >> buildHeaderElementFor: aText [
	| aLabel |
	aLabel := BrLabel new
		look: BrGlamorousLabelLook;
		alignCenterLeft;
		padding: self newCellPaddingInsets;
		text: (aText asRopedText foreground: BrGlamorousColors defaultButtonTextColor).
	^ aLabel
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

{ #category : #'private - accessing' }
GtPhlowColumn >> dataBinder [
	^ dataBinder
]

{ #category : #'api - scripting cell content' }
GtPhlowColumn >> dataBinder: aBlockOrSymbol [ 
	dataBinder := self errorTreatedCellDataBinderFor: aBlockOrSymbol
]

{ #category : #defaults }
GtPhlowColumn >> defaultColumnIndex [
	^ 1
]

{ #category : #defaults }
GtPhlowColumn >> defaultHeaderElementBuilder [
	^ [ :aTitle :aPhlowColumn | self buildHeaderElementFor: aTitle ]
]

{ #category : #defaults }
GtPhlowColumn >> defaultItemComputation [
	^ [ :eachItem :eachRowIndex :eachColumnIndex | eachItem ]
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

{ #category : #'scripting - deprecated' }
GtPhlowColumn >> fitContent [
	self 
		deprecated: 'Please use #width: instead.'
		transformWith: '`@receiver fitContent' -> '`@receiver width: 50'.
	self width: 50
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

{ #category : #'private - accessing' }
GtPhlowColumn >> index [
	^ index
]

{ #category : #'private - accessing' }
GtPhlowColumn >> index: anObject [
	index := anObject
]

{ #category : #initialization }
GtPhlowColumn >> initialize [
	super initialize.
	
	index := self defaultColumnIndex.
	title := self defaultTitle.
	titleStencil := self defaultHeaderElementBuilder.
	itemComputation := self defaultItemComputation.
	width := self defaultWidth.
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

{ #category : #'scripting - deprecated' }
GtPhlowColumn >> matchParent [
	self 
		deprecated: 'Please use #weight: instead.'
		transformWith: '`@receiver matchParent' -> '`@receiver weight: 1'.
	self weight: 1.
]

{ #category : #'private - building' }
GtPhlowColumn >> newCellPaddingInsets [
	^ BlInsets empty
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

{ #category : #'scripting - deprecated' }
GtPhlowColumn >> noResize [
	self 
		deprecated: 'Please use #noWidth instead.'
		transformWith: '`@receiver noResize' -> '`@receiver noWidth'.
	self noWidth
]

{ #category : #'api - scripting cell width' }
GtPhlowColumn >> noWidth [
	width := BrColumnUndefinedWidth new.
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
	"I am a part of the `toy` api. It is inefficient to use me because I always create a new
	element for each new cell which may be expensive. It is much better to split it in two (or three)
	steps:
		- cell element creation using #cellStencil: (the items are reused when they go out of the viewport)
		- data binding using #dataBinder: (to update just a part of the reused item element).
	aStencil is a BlockClosure of type [ :aRowObject :aRowIndex :aCellIndex ]"

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
		aLabel text: aText gtDisplayText asRopedText. ]
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
]
