Class {
	#name : #GtPhlowColumn,
	#superclass : #Object,
	#instVars : [
		'index',
		'title',
		'titleStencil',
		'width',
		'itemComputation',
		'backgroundComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #testing }
GtPhlowColumn class >> isAbstract [
	^ self name = #GtPhlowColumn
]

{ #category : #'api - configuration' }
GtPhlowColumn >> background: aBlock [
	"Configure the background of a cell based on the cell or row value.
	aBlock may accept the following arguments:
		[ :eachCellValue :eachRowValue :eachRowIndex :eachColumnIndex | a color ]"

	backgroundComputation := aBlock
]

{ #category : #'private - accessing' }
GtPhlowColumn >> backgroundComputation [
	^ backgroundComputation ifNil: [
		backgroundComputation := self defaultBackgroundComputation ]
]

{ #category : #'private - building' }
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
		aptitude: BrGlamorousLabelAptitude;
		alignCenterLeft;
		padding: self newCellPaddingInsets;
		text: (aText asRopedText foreground: BrGlamorousColors defaultButtonTextColor).
	^ aLabel
]

{ #category : #'private - accessing' }
GtPhlowColumn >> cellWidth [
	^ width
]

{ #category : #'private - building' }
GtPhlowColumn >> computeDecoratedCellStencil: aCellStencil [
	^ GtPhlowColumnErrorHandlingCellStencilBuilder new
		cellStencil: aCellStencil;
		cellSpacing: self newCellPaddingInsets
]

{ #category : #'private - building' }
GtPhlowColumn >> computeDecoratedDataBinder: aSourceDataBinder [
	| aDataBinder |

	aDataBinder := aSourceDataBinder.

	aDataBinder := GtPhlowColumnCellItemComputationDataBinder new
		dataBinder: aDataBinder;
		itemComputation: itemComputation;
		backgroundComputation: self backgroundComputation.

	aDataBinder := GtPhlowColumnErrorHandlingDataBinder new
		dataBinder: aDataBinder.

	^ aDataBinder
]

{ #category : #'api - building' }
GtPhlowColumn >> configureColumn: aBrColumn [
	aBrColumn
		title: self title;
		cellWidth: self cellWidth
]

{ #category : #defaults }
GtPhlowColumn >> defaultBackgroundComputation [
	^ [ :eachCellValue :eachRowValue :eachRowIndex :eachColumnIndex | Color transparent ]
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
	"^ [ :rowItem :rowIndex :columnIndex | rowItem ]"

	^ GtPhlowIdentityFunction uniqueInstance
]

{ #category : #defaults }
GtPhlowColumn >> defaultTitle [
	^ 'Column'
]

{ #category : #defaults }
GtPhlowColumn >> defaultWidth [
	^ BrColumnProportionalWidth new
]

{ #category : #'private - accessing' }
GtPhlowColumn >> hasBackgroundComputation [
	^ backgroundComputation notNil
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
	width := self defaultWidth.
	itemComputation := self defaultItemComputation.
]

{ #category : #testing }
GtPhlowColumn >> isSpawningObject [
	^ false
]

{ #category : #'api - configuration' }
GtPhlowColumn >> item: aBlockOrSymbol [
	"Assign a computation to be used to compute the value of a domain cell object from a row object.
	The computation object must understand #phlowValue:withEnoughArguments:
	and accept up to 3 arguments: row object, row index, column index.
	By default, the item computation is an identity function.
	The return value of the computation can be any domain Object, without any type constraint.
	Based on a type of the column, the cell object will be passed to the corresponding rendering logic."

	itemComputation := aBlockOrSymbol
]

{ #category : #'private - accessing' }
GtPhlowColumn >> itemComputation [
	^ itemComputation
]

{ #category : #'private - building' }
GtPhlowColumn >> newCellPaddingInsets [
	^ BlInsets empty
]

{ #category : #'api - cell width' }
GtPhlowColumn >> noWidth [
	width := BrColumnUndefinedWidth new.
]

{ #category : #'private - accessing' }
GtPhlowColumn >> title [
	^ title
]

{ #category : #'api - configuration' }
GtPhlowColumn >> title: anObject [
	title := anObject
]

{ #category : #'api - configuration' }
GtPhlowColumn >> titleStencil: aStencil [
	titleStencil := aStencil
]

{ #category : #'api - cell width' }
GtPhlowColumn >> weight: aNumber [
	"Make a column match parent with a given proportion as a number (usually between 0 and 1)"

	width := BrColumnProportionalWidth new weight: aNumber
]

{ #category : #'api - cell width' }
GtPhlowColumn >> width: aNumber [
	"Make column occupy a fixed space defined by aNumber"

	width := BrColumnFixedWidth new width: aNumber.
]
