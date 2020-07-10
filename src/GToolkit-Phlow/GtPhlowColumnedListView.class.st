Class {
	#name : #GtPhlowColumnedListView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'columns',
		'transformation',
		'itemsBuilder'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowColumnedListView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aContainer header list theItems |
	theItems := self
		itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	aContainer := self elementClass new.
	aContainer
		labeled: 'Columned List Container';
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aContainer layout: BlLinearLayout vertical.
	header := self buildHeaderForItems: theItems.
	list := self columnedListClass new items: theItems.
	list
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self send).
	list
		rowStencil:
			(BrListClickableRowStencilBuilder new
				cellSpacing: 10;
				padding: (BlInsets top: 4 bottom: 4)).
	self buildColumnsInList: list.
	aContainer
		addChildren:
			{header.
			list}.
	self beViewElement: aContainer.
	^ aBlock value: aContainer
]

{ #category : #'private - building' }
GtPhlowColumnedListView >> buildColumnsInList: aList [
	columns do: [ :eachPhlowColumn |
		eachPhlowColumn configureColumn: aList column ]
		"aList column
			title: eachPhlowColumn title;
			cellStencil: eachPhlowColumn cellStencil;
			dataBinder: eachPhlowColumn dataBinder;
			stencil: [ :eachItem :eachIndex |
				| aRowElement |

				aRowElement := self performBlock: [ 
					eachPhlowColumn createRowElementFor: eachItem atIndex: eachIndex ].
				
				eachPhlowColumn resizer ifNotNil: [ :aLayoutResizer |
					aRowElement constraintsDo: [ :c |
						c horizontal resizer: aLayoutResizer.
						c vertical fitContent ].
					aRowElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
					aRowElement dispatchEvent: (BrLayoutVerticalResizerWish fitContent) ].
				aRowElement ] ]."
]

{ #category : #'private - building' }
GtPhlowColumnedListView >> buildHeaderForItems: theItems [
	| aHeader |
	aHeader := BlElement new.
	aHeader layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: 10).
	aHeader padding: (BlInsets top: 5 bottom: 5).
	aHeader labeled: 'Columned List Header'.
	aHeader constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self buildHeaderItems: theItems inHeader: aHeader.
	^ aHeader
]

{ #category : #'private - building' }
GtPhlowColumnedListView >> buildHeaderItems: theItems inHeader: aHeader [

	aHeader addChildren: (columns collect: [ :eachColumn |
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
			aRowElement := self performBlock: [ 
				eachColumn createRowElementFor: theItems first atIndex: 1 ].
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
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column [
	<return: #GtPhlowColumn>
	| aColumn |
	
	aColumn := GtPhlowColumn new.
	columns add: aColumn.
	^ aColumn
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column: aTitleString do: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aBlock value: aColumn
]

{ #category : #'scripting - deprecated' }
GtPhlowColumnedListView >> column: aTitleString evaluated: aBlock [
	self 
		deprecated: 'Please use #column:item: instead.'
		transformWith: '`@receiver column: `@one evaluated: `@two' -> '`@receiver column: `@one item: `@two'.
	^ self column: aTitleString item: aBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowColumnedListView >> column: aTitleString format: aBlock [
	self 
		deprecated: 'Please use #column:text: instead.'
		transformWith: '`@receiver column: `@one format: `@two' -> '`@receiver column: `@one text: `@two'.
	self column: aTitleString text: aBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowColumnedListView >> column: aTitleString format: aBlock width: aNumber [
	self 
		deprecated: 'Please use #column:text:width: instead.'
		transformWith: '`@receiver column: `@one format: `@two width: `@three' 
			-> '`@receiver column: `@one text: `@two width: `@three'.
	self column: aTitleString text: aBlock width: aNumber
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column: aTitleString item: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: aBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowColumnedListView >> column: aTitleString item: anItemComputation format: aFormatBlocOrSymbol [
	self 
		deprecated: 'Please use #column:item:text: instead.'
		transformWith: '`@receiver column: `@one item: `@two format: `@three' -> '`@receiver column: `@one item: `@two text: `@three'.
	self column: aTitleString item: anItemComputation text: aFormatBlocOrSymbol
]

{ #category : #'scripting - deprecated' }
GtPhlowColumnedListView >> column: aTitleString item: anItemComputation format: aFormatBlocOrSymbol width: aNumber [
	self 
		deprecated: 'Please use #column:item:text:width. instead.'
		transformWith: '`@receiver column: `@one item: `@two format: `@three width: `@four'
			-> '`@receiver column: `@one item: `@two text: `@three width: `@four'.
	self column: aTitleString item: anItemComputation text: aFormatBlocOrSymbol width: aNumber
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column: aTitleString item: anItemComputation text: aFormatBlocOrSymbol [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn text: aFormatBlocOrSymbol
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column: aTitleString item: anItemComputation text: aFormatBlocOrSymbol width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn text: aFormatBlocOrSymbol.
	aColumn width: aNumber.
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column: aTitleString item: aBlock width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: aBlock.
	aColumn width: aNumber.
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column: aTitleString text: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn text: aBlock
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column: aTitleString text: aBlock width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn text: aBlock.
	aColumn width: aNumber.
]

{ #category : #'private - testing' }
GtPhlowColumnedListView >> columnedListClass [
	^ BrColumnedList
]

{ #category : #copying }
GtPhlowColumnedListView >> copySendFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowColumnedListView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> elementClass [
	^ BlElement
]

{ #category : #initialization }
GtPhlowColumnedListView >> initialize [
	super initialize.
	
	columns := OrderedCollection new.
	itemsBuilder := [ { } ].
	transformation := [ :aValue | "by default there is no transformation" aValue ].
]

{ #category : #'private - testing' }
GtPhlowColumnedListView >> isExpectedElement: aCurrentElement [
	aCurrentElement class = self elementClass ifFalse: [ ^ false ].
	aCurrentElement childrenCount = 2 ifFalse: [ ^ false ].
	(aCurrentElement childAt: 2) class = self columnedListClass ifFalse: [ ^ false ].
	^ true
]

{ #category : #'api - scripting' }
GtPhlowColumnedListView >> items: aValuable [
	itemsBuilder := aValuable
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> itemsOnExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ self itemsBuilder value ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> send [
	^ transformation
]

{ #category : #'api - scripting' }
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

{ #category : #'api - updating' }
GtPhlowColumnedListView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"
	
	| aParent |
	(self isExpectedElement: aCurrentElement) ifFalse: [ 
		^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		| theItems aList |
		theItems := self itemsOnExceptionErrorElement: [ :anErrorElement | 
			^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		aList := aCurrentElement children second.
		self enqueueAction: [ aList items: theItems ] in: aList ].
]
