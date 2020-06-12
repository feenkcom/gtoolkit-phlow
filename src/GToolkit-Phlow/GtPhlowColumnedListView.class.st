Class {
	#name : #GtPhlowColumnedListView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'columns',
		'transformation',
		'itemsBuilder'
	],
	#category : #'GToolkit-Phlow-! Views and Actions'
}

{ #category : #converting }
GtPhlowColumnedListView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aContainer header list theItems |
	theItems := self
		itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	aContainer := BlElement new.
	aContainer
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aContainer layout: BlLinearLayout vertical.
	header := self buildHeaderForItems: theItems.
	list := BrColumnedList new items: theItems.
	list
		addEventHandler: (GtInspectorListToSelectHandler new transformation: self send).
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

{ #category : #private }
GtPhlowColumnedListView >> buildColumnsInList: aList [
	columns do: [ :eachPhlowColumn |
		aList column
			title: eachPhlowColumn title;
			stencil: [ :eachItem :eachIndex |
				| aRowElement |

				aRowElement := self performBlock: [ 
					eachPhlowColumn createRowElementFor: eachItem atIndex: eachIndex ].
				
				eachPhlowColumn resizer ifNotNil: [ :aLayoutResizer |
					aRowElement constraintsDo: [ :c |
						c horizontal resizer: aLayoutResizer.
						c vertical matchParent ].
					aRowElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
					aRowElement dispatchEvent: (BrLayoutVerticalResizerWish matchParent) ].
				aRowElement ] ].
]

{ #category : #private }
GtPhlowColumnedListView >> buildHeaderForItems: theItems [
	| aHeader |
	aHeader := BlElement new.
	aHeader layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: 10).
	aHeader padding: (BlInsets top: 5 bottom: 5).
	aHeader constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self buildHeaderItems: theItems inHeader: aHeader.
	^ aHeader
]

{ #category : #private }
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

{ #category : #copying }
GtPhlowColumnedListView >> copySendFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
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

{ #category : #accessing }
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

{ #category : #updating }
GtPhlowColumnedListView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"
	
	| aParent |
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		| theItems aList |
		theItems := self itemsOnExceptionErrorElement: [ :anErrorElement | 
			^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		aList := aCurrentElement children second.
		self enqueueAction: [ aList items: theItems ] in: aList ].
]
