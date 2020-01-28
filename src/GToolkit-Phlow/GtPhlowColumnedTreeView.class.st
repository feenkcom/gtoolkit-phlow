Class {
	#name : #GtPhlowColumnedTreeView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'columns',
		'transformation',
		'itemsBuilder',
		'childrenBuilder',
		'expandUpTo'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowColumnedTreeView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aContainer aHeader aTree theItems |
	theItems := self 
		performBlock: [ self itemsBuilder value ]
		onExceptionErrorElement: [ :anElement |
			^ aBlock value: anElement ].
	aContainer := self newContainer.
	aHeader := self newHeader.
	aHeader addChildren: (self newColumnElementsForItems: theItems).
	aTree := BrColumnedTree new.
	
	self 
		performBlock: [ aTree items: theItems children: self childrenBuilder ] 
		onExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	
	aTree
		addEventHandler:
			(GtInspectorListToSelectHandler new
				transformation: [ :aNode | self send value: aNode value ]).
	aTree
		rowStencil:
			(BrColumnedTreeRowStencilBuilder new
				cellSpacing: 2;
				padding: (BlInsets top: 2 bottom: 2)).
	columns
		do: [ :eachPhlowColumn | 
			aTree column
				title: eachPhlowColumn title;
				stencil: [ :eachNode :eachIndex | 
					| aRowElement |
					aRowElement := eachPhlowColumn
						createRowElementFor: eachNode value
						atIndex: eachIndex.
					eachPhlowColumn resizer
						ifNotNil: [ :aLayoutResizer | 
							aRowElement
								constraintsDo: [ :c | 
									c horizontal resizer: aLayoutResizer.
									c vertical matchParent ].
							aRowElement
								dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
							aRowElement
								dispatchEvent: BrLayoutVerticalResizerWish matchParent ].
					aRowElement ] ].
	self expandTree: aTree.
	aContainer
		addChildren:
			{aHeader.
			aTree}.
	aContainer phlow
		beView;
		entity: self.
	^ aBlock value: aContainer
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> children: aValuable [
	childrenBuilder := aValuable
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> childrenBuilder [
	^ childrenBuilder
]

{ #category : #'expanding-collapsing' }
GtPhlowColumnedTreeView >> collapseAll [
	expandUpTo := nil.
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> column [
	<return: #GtPhlowColumn>
	| aColumn |
	
	aColumn := GtPhlowColumn new.
	columns add: aColumn.
	^ aColumn
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> column: aTitleString do: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aBlock value: aColumn
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> column: aTitleString evaluated: aBlock [
	^ self column: aTitleString item: aBlock
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> column: aTitleString format: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn itemFormat: aBlock
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> column: aTitleString format: aBlock width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn itemFormat: aBlock.
	aColumn width: aNumber.
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> column: aTitleString item: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: aBlock
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> column: aTitleString item: anItemComputation format: aFormatBlocOrSymbol [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn itemFormat: aFormatBlocOrSymbol
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> column: aTitleString item: anItemComputation format: aFormatBlocOrSymbol width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn itemFormat: aFormatBlocOrSymbol.
	aColumn width: aNumber.
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> column: aTitleString item: aBlock width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: aBlock.
	aColumn width: aNumber.
]

{ #category : #deprecated }
GtPhlowColumnedTreeView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #'expanding-collapsing' }
GtPhlowColumnedTreeView >> expandAll [
	self expandUpTo: 20
]

{ #category : #'expanding-collapsing' }
GtPhlowColumnedTreeView >> expandOneLevel [
	self expandUpTo: 1
]

{ #category : #'private - actions' }
GtPhlowColumnedTreeView >> expandTree: aBrColumnedTree [ 
	expandUpTo ifNil: [ ^ self ].
	aBrColumnedTree expandUpTo: expandUpTo
]

{ #category : #'expanding-collapsing' }
GtPhlowColumnedTreeView >> expandUpTo: aLevelIndex [
	self 
		assert: [ aLevelIndex isInteger and: [ aLevelIndex > 0 ] ] 
		description: [ 'Level index must be a natural number' ].
	expandUpTo := aLevelIndex.
]

{ #category : #initialization }
GtPhlowColumnedTreeView >> initialize [
	super initialize.
	
	columns := OrderedCollection new.
	itemsBuilder := [ { } ].
	childrenBuilder := [ :each | { } ].
	transformation := [ :aValue | "by default there is no transformation" aValue ].
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> items: aValuable [
	itemsBuilder := aValuable
]

{ #category : #'private - accessing' }
GtPhlowColumnedTreeView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : #'instance creation' }
GtPhlowColumnedTreeView >> newColumnElementsForItems: theItems [
	^ columns
		collect: [ :eachColumn | 
			| aWrapper aLabel aScaledLabel |
			aWrapper := self newWrapper.
			aLabel := BrLabel new
				look: BrGlamorousLabelLook;
				text:
					(eachColumn title asRopedText
						foreground: BrGlamorousColors defaultButtonTextColor).
			aScaledLabel := aLabel asScalableElement.
			aScaledLabel maxScale: 1.
			aScaledLabel
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c ignoreByLayout ].
			theItems
				ifNotEmpty: [ | aRowElement |
					aRowElement := eachColumn
						createRowElementFor: theItems first
						atIndex: 1.
					aRowElement visibility: BlVisibility hidden.
					eachColumn resizer
						ifNotNil: [ :aLayoutResizer | 
							aRowElement
								constraintsDo: [ :c | 
									c horizontal resizer: aLayoutResizer.
									c vertical matchParent ].
							aWrapper
								constraintsDo: [ :c | c horizontal resizer: aLayoutResizer ].
							aRowElement
								dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
							aRowElement
								dispatchEvent: BrLayoutVerticalResizerWish matchParent ].
					aWrapper addChild: aRowElement ].
			aWrapper addChild: aScaledLabel.
			aWrapper ]
]

{ #category : #'instance creation' }
GtPhlowColumnedTreeView >> newContainer [
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
]

{ #category : #'instance creation' }
GtPhlowColumnedTreeView >> newHeader [
	^ BlElement new
		layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: 10);
		padding: (BlInsets top: 5 bottom: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
]

{ #category : #'instance creation' }
GtPhlowColumnedTreeView >> newWrapper [
	| aWrapper |
	aWrapper := BlElement new.
	aWrapper layout: BlLinearLayout vertical.
	aWrapper
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical matchParent ].
	^ aWrapper
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> send [
	^ transformation
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> send: aBlock [
	self
		assert: [ aBlock notNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	aBlock isSymbol ifTrue: [ 
		self 
			assert: [ aBlock isUnary ]
			description: [ 'Send transformation symbol must be unary' ].
		transformation := [ :obj :event | aBlock value: obj ].
		^self ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
	transformation := aBlock
]
