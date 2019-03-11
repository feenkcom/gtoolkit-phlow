Class {
	#name : #GtPhlowColumnedTreeView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'columns',
		'transformation',
		'itemsBuilder',
		'childrenBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowColumnedTreeView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"
	| aContainer header tree theItems |
	
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

		aLabel := BrLabel new
			look: BrGlamorousLabelLook;
			text: (eachColumn title asRopedText foreground: BrGlamorousColors defaultButtonTextColor).

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
	
	tree := BrColumnedTree new.
	tree items: theItems children: self childrenBuilder.
	tree addEventHandler: (GtInspectorListToSelectHandler new transformation: self send).
	tree rowStencil: (BrColumnedTreeRowStencilBuilder new).

	columns do: [ :eachPhlowColumn |
		tree column
			title: eachPhlowColumn title;
			stencil: [ :eachNode :eachIndex |
				| aRowElement |
				
				aRowElement := eachPhlowColumn createRowElementFor: eachNode value atIndex: eachIndex.
				eachPhlowColumn resizer ifNotNil: [ :aLayoutResizer |
					aRowElement constraintsDo: [ :c |
						c horizontal resizer: aLayoutResizer.
						c vertical matchParent ].
					aRowElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
					aRowElement dispatchEvent: (BrLayoutVerticalResizerWish matchParent) ].
				aRowElement ] ].
		
	aContainer addChildren: { header . tree }.

	aContainer phlow beView; entity: self.

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

{ #category : #accessing }
GtPhlowColumnedTreeView >> send [
	^ transformation
]

{ #category : #accessing }
GtPhlowColumnedTreeView >> send: anOneArgBlock [
	self
		assert: [ anOneArgBlock notNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	self
		assert: [ anOneArgBlock numArgs = 1 or: [ anOneArgBlock isSymbol and: [ anOneArgBlock isUnary ] ] ]
		description: [ 'Send transformation block must receive one argument'  ].
	transformation := anOneArgBlock
]
