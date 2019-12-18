Class {
	#name : #GtPhlowColumnedListView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'columns',
		'transformation',
		'itemsBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowColumnedListView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"
	| aContainer header list theItems |
	
	aContainer := BlElement new.
	aContainer layout: BlLinearLayout vertical.
	aContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	theItems := self itemsBuilder value.
	
	header := BlElement new.
	header layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: 10).
	header padding: (BlInsets top: 5 bottom: 5).
	header constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	
	header addChildren: (columns collect: [ :eachColumn |
		| aWrapper aLabel aScaledLabel |
		
		aWrapper := BlElement new.
		aWrapper layout: BlLinearLayout vertical.
		aWrapper constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical matchParent ].
		
		aLabel := eachColumn createHeaderRowElement.

		aScaledLabel := aLabel asScalableElement.
		aScaledLabel maxScale: 1.
		aScaledLabel constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c ignoreByLayout ].
		
		theItems ifNotEmpty: [
			| aRowElement  |
			aRowElement := eachColumn createRowElementFor: theItems first atIndex: 1.
			aRowElement visibility: BlVisibility hidden.

			eachColumn resizer ifNotNil: [ :aLayoutResizer |
				aRowElement constraintsDo: [ :c |
					c horizontal resizer: aLayoutResizer.
					c vertical matchParent ].
				aWrapper constraintsDo: [ :c | c horizontal resizer: aLayoutResizer ].
				aRowElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
				aRowElement dispatchEvent: (BrLayoutVerticalResizerWish matchParent) ].
			
			aWrapper addChild: aRowElement	].
		
		aWrapper addChild: aScaledLabel.
		aWrapper
	]).
	
	list := BrColumnedList new display: theItems.
	list addEventHandler: (GtInspectorListToSelectHandler new transformation: self send).
	list rowStencil: (BrListClickableRowStencilBuilder new
		cellSpacing: 10;
		padding: (BlInsets top: 4 bottom: 4)).

	columns do: [ :eachPhlowColumn |
		list column
			title: eachPhlowColumn title;
			stencil: [ :eachItem :eachIndex |
				| aRowElement |
				
				aRowElement := eachPhlowColumn createRowElementFor: eachItem atIndex: eachIndex.
				eachPhlowColumn resizer ifNotNil: [ :aLayoutResizer |
					aRowElement constraintsDo: [ :c |
						c horizontal resizer: aLayoutResizer.
						c vertical matchParent ].
					aRowElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
					aRowElement dispatchEvent: (BrLayoutVerticalResizerWish matchParent) ].
				aRowElement ] ].
		
	aContainer addChildren: { header . list }.

	aContainer phlow beView; entity: self.

	^ aBlock value: aContainer
]

{ #category : #accessing }
GtPhlowColumnedListView >> column [
	<return: #GtPhlowColumn>
	| aColumn |
	
	aColumn := GtPhlowColumn new.
	columns add: aColumn.
	^ aColumn
]

{ #category : #accessing }
GtPhlowColumnedListView >> column: aTitleString do: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aBlock value: aColumn
]

{ #category : #accessing }
GtPhlowColumnedListView >> column: aTitleString evaluated: aBlock [
	^ self column: aTitleString item: aBlock
]

{ #category : #accessing }
GtPhlowColumnedListView >> column: aTitleString format: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn itemFormat: aBlock
]

{ #category : #accessing }
GtPhlowColumnedListView >> column: aTitleString format: aBlock width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn itemFormat: aBlock.
	aColumn width: aNumber.
]

{ #category : #accessing }
GtPhlowColumnedListView >> column: aTitleString item: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: aBlock
]

{ #category : #accessing }
GtPhlowColumnedListView >> column: aTitleString item: anItemComputation format: aFormatBlocOrSymbol [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn itemFormat: aFormatBlocOrSymbol
]

{ #category : #accessing }
GtPhlowColumnedListView >> column: aTitleString item: anItemComputation format: aFormatBlocOrSymbol width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn itemFormat: aFormatBlocOrSymbol.
	aColumn width: aNumber.
]

{ #category : #accessing }
GtPhlowColumnedListView >> column: aTitleString item: aBlock width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: aBlock.
	aColumn width: aNumber.
]

{ #category : #deprecated }
GtPhlowColumnedListView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #initialization }
GtPhlowColumnedListView >> initialize [
	super initialize.
	
	columns := OrderedCollection new.
	itemsBuilder := [ { } ].
	transformation := [ :aValue | "by default there is no transformation" aValue ].
]

{ #category : #accessing }
GtPhlowColumnedListView >> items: aValuable [
	itemsBuilder := aValuable
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : #accessing }
GtPhlowColumnedListView >> send [
	^ transformation
]

{ #category : #accessing }
GtPhlowColumnedListView >> send: aBlock [
	self
		assert: [ aBlock notNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	aBlock isSymbol ifTrue: [ 
		self 
			assert: [ aBlock isUnary ]
			description: [ 'Send transformation symbol must be unary' ].
		transformation := [ :obj | aBlock value: obj ].
		^self ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
	transformation := aBlock
]
