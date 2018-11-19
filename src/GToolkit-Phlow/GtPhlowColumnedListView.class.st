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
			| aComputedValue aColumnElement  |
			
			aComputedValue := eachColumn computation valueWithEnoughArguments: { theItems first . 1 }.
			aColumnElement := eachColumn stencil valueWithEnoughArguments: { aComputedValue . theItems first . eachColumn }.
			aColumnElement visibility: BlVisibility hidden.

			eachColumn resizer ifNotNil: [ :aLayoutResizer |
				aColumnElement constraintsDo: [ :c |
					c horizontal resizer: aLayoutResizer.
					c vertical matchParent ].
				aWrapper constraintsDo: [ :c | c horizontal resizer: aLayoutResizer ].
				aColumnElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
				aColumnElement dispatchEvent: (BrLayoutVerticalResizerWish matchParent) ].
			
			aWrapper addChild: aColumnElement	].
		
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
				| aComputedValue aColumnElement |
				
				aComputedValue := eachPhlowColumn computation valueWithEnoughArguments: { eachItem . eachIndex }.
				aColumnElement := eachPhlowColumn stencil valueWithEnoughArguments: { aComputedValue . eachItem . eachPhlowColumn }.

				eachPhlowColumn resizer ifNotNil: [ :aLayoutResizer |
					aColumnElement constraintsDo: [ :c |
						c horizontal resizer: aLayoutResizer.
						c vertical matchParent ].
					aColumnElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
					aColumnElement dispatchEvent: (BrLayoutVerticalResizerWish matchParent) ].
				aColumnElement ] ].
		
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
GtPhlowColumnedListView >> send: anOneArgBlock [
	self
		assert: [ anOneArgBlock notNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	self
		assert: [ anOneArgBlock numArgs = 1 ]
		description: [ 'Send transformation block must receive one argument'  ].
	^ transformation
]
