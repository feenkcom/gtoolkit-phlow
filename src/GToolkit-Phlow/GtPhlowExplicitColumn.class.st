"
I keep information to configure {{gtClass:BrColumn}} instances.
I am used by {{gtClass:GtPhlowColumnedListView}} and {{gtClass:GtPhlowColumnedTreeView}}.


"
Class {
	#name : #GtPhlowExplicitColumn,
	#superclass : #GtPhlowColumn,
	#instVars : [
		'cellStencil',
		'dataBinder',
		'spawnObjectComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'private - accessing' }
GtPhlowExplicitColumn >> cellStencil [
	^ cellStencil
]

{ #category : #'api - configuration' }
GtPhlowExplicitColumn >> cellStencil: aBlockOrSymbol [
	cellStencil := aBlockOrSymbol asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #'api - building' }
GtPhlowExplicitColumn >> configureColumn: aBrColumn [
	super configureColumn: aBrColumn.

	aBrColumn
		cellStencil: (self computeDecoratedCellStencil: self cellStencil);
		dataBinder: (self computeDecoratedDataBinder: self dataBinder)
]

{ #category : #'private - accessing' }
GtPhlowExplicitColumn >> dataBinder [
	^ dataBinder
]

{ #category : #'api - configuration' }
GtPhlowExplicitColumn >> dataBinder: aBlockOrSymbol [
	dataBinder := aBlockOrSymbol asStencilBuilder: BrColumnCellDataBinder
]

{ #category : #defaults }
GtPhlowExplicitColumn >> defaultTextStencil [
	^ [ :anItem :aRowIndex :aColumnIndex | anItem ]
]

{ #category : #'api - cell content' }
GtPhlowExplicitColumn >> icon: aBlockOrSymbol [
	self item: aBlockOrSymbol.
	self cellStencil: GtPhlowListIconElementStencilBuilder new.
	self dataBinder: GtPhlowListIconDataBinder new
]

{ #category : #'api - cell content' }
GtPhlowExplicitColumn >> iconName: anIconNameComputation [
	self item: anIconNameComputation.
	self cellStencil: GtPhlowListIconElementStencilBuilder new.
	self dataBinder: GtPhlowListIconNamedDataBinder new
]

{ #category : #initialization }
GtPhlowExplicitColumn >> initialize [
	super initialize.

	self text: self defaultTextStencil
]

{ #category : #testing }
GtPhlowExplicitColumn >> isSpawningObject [
	^ self asGtDeclarativeColumnDataType isTextLinkListingType
]

{ #category : #accessing }
GtPhlowExplicitColumn >> spawnObjectComputation [
	^ spawnObjectComputation
]

{ #category : #'api - configuration' }
GtPhlowExplicitColumn >> stencil: aBlock [
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

{ #category : #'api - cell content' }
GtPhlowExplicitColumn >> text: aBlockOrSymbol [
	self item: aBlockOrSymbol.
	self cellStencil: GtPhlowListTextElementStencilBuilder new.
	self dataBinder: GtPhlowListTextDataBinder new
]

{ #category : #'api - cell content' }
GtPhlowExplicitColumn >> text: aBlockOrSymbol spawn: aSpawnObjectComputation [
	self item: aBlockOrSymbol.
	spawnObjectComputation := aSpawnObjectComputation.
	self cellStencil: (GtPhlowListTextualLinkBuilder new 
		spawnObjectComputation: aSpawnObjectComputation).
	self dataBinder: GtPhlowListTextualLinkDataBinder new
]
