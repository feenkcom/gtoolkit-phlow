Class {
	#name : #GtPhlowTreeView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'itemsBuilder',
		'itemStencil',
		'transformation',
		'childrenBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowTreeView >> asElementDo: aBlock [
	| tree |
	
	tree := BrColumnedTree new.
	
	tree items: self itemsBuilder value children: self childrenBuilder.
	tree addEventHandler: (GtInspectorListToSelectHandler new transformation: [ :aNode | self send value: aNode value ]).
	tree constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].
	tree rowStencil: (BrColumnedTreeRowStencilBuilder new
		cellSpacing: 2;
		padding: (BlInsets left: 0)).

	tree column
		title: 'Item';
		stencil: [ :aNode :index | 
			| itemElement |
			itemElement := self itemStencil value: aNode value.
			itemElement padding: (BlInsets top: 3 left: 0 bottom: 3 right: 0) ].

	tree phlow 
		beView; 
		entity: self.

	^ aBlock value: tree
]

{ #category : #'private - building' }
GtPhlowTreeView >> buildTextElementFor: aString [
	^ BrLabel new
		look: BrGlamorousListLabelLook;
		text: aString.
]

{ #category : #accessing }
GtPhlowTreeView >> children: anObject [
	childrenBuilder := anObject
]

{ #category : #accessing }
GtPhlowTreeView >> childrenBuilder [
	^ childrenBuilder
]

{ #category : #'scripting - deprecated' }
GtPhlowTreeView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowTreeView >> format: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemFormat: instead.'
		transformWith: '`@receiver format: `@statements' -> '`@receiver itemFormat: `@statements'.
	self itemFormat: aBlockOrSymbol
]

{ #category : #initialization }
GtPhlowTreeView >> initialize [
	super initialize.
	itemStencil := [ :anObject | 
		self buildTextElementFor: anObject gtDisplayText ].
	itemsBuilder := [ { } ].
	childrenBuilder := [ :each | { } ].
	transformation := [ :aValue | "by default there is no transformation" aValue ].
]

{ #category : #'scripting - deprecated' }
GtPhlowTreeView >> itemElement: anObject [
	self 
		deprecated: 'Please use #itemStencil: instead.'
		transformWith: '`@receiver itemElement: `@statements' -> '`@receiver itemStencil: `@statements'.
	itemStencil := anObject
]

{ #category : #'scripting - utils' }
GtPhlowTreeView >> itemFormat: aBlockOrSymbol [
	self itemStencil: [ :anObject |
		self buildTextElementFor: (aBlockOrSymbol phlowValue: anObject) ]
]

{ #category : #accessing }
GtPhlowTreeView >> itemStencil [
	^ itemStencil
]

{ #category : #accessing }
GtPhlowTreeView >> itemStencil: anElementStencil [
	itemStencil := anElementStencil
]

{ #category : #accessing }
GtPhlowTreeView >> items: anObject [
	itemsBuilder := anObject
]

{ #category : #accessing }
GtPhlowTreeView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : #accessing }
GtPhlowTreeView >> send [
	^ transformation
]

{ #category : #accessing }
GtPhlowTreeView >> send: anOneArgBlock [
	self
		assert: [ anOneArgBlock notNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	self
		assert: [ anOneArgBlock numArgs = 1 ]
		description: [ 'Send transformation block must receive one argument'  ].
	transformation := anOneArgBlock
]
