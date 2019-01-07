Class {
	#name : #GtPhlowListView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'itemsBuilder',
		'itemStencil',
		'transformation'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowListView >> asElementDo: aBlock [
	| list |
	
	list := BrColumnedList new display: self itemsBuilder value.
	list addEventHandler: (GtInspectorListToSelectHandler new transformation: self send).
	list constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].

	list column
		title: 'Item';
		stencil: [ :aNode :index | 
			| itemElement |
			itemElement := self itemStencil value: aNode.
			itemElement constraintsDo: [ :c | 
				c horizontal matchParent. 
				c padding: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ] ].

	list phlow 
		beView; 
		entity: self.

	^ aBlock value: list
]

{ #category : #'private - building' }
GtPhlowListView >> buildTextElementFor: aString [
	^ BrLabel new
		look: BrGlamorousLabelLook;
		text: aString.
]

{ #category : #'scripting - deprecated' }
GtPhlowListView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowListView >> format: aBlockOrSymbol [
	self 
		deprecated: 'Please use #itemFormat: instead.'
		transformWith: '`@receiver format: `@statements' -> '`@receiver itemFormat: `@statements'.
	self itemFormat: aBlockOrSymbol
]

{ #category : #initialization }
GtPhlowListView >> initialize [
	super initialize.
	itemStencil := [ :anObject | 
		self buildTextElementFor: anObject gtDisplayString ].
	itemsBuilder := [ { } ].
	transformation := [ :aValue | "by default there is no transformation" aValue ].
]

{ #category : #'scripting - deprecated' }
GtPhlowListView >> itemElement: anObject [
	self 
		deprecated: 'Please use #itemStencil: instead.'
		transformWith: '`@receiver itemElement: `@statements' -> '`@receiver itemStencil: `@statements'.
	itemStencil := anObject
]

{ #category : #'scripting - utils' }
GtPhlowListView >> itemFormat: aBlockOrSymbol [
	self itemStencil: [ :anObject |
		self buildTextElementFor: (aBlockOrSymbol phlowValue: anObject) ]
]

{ #category : #accessing }
GtPhlowListView >> itemStencil [
	^ itemStencil
]

{ #category : #accessing }
GtPhlowListView >> itemStencil: anElementStencil [
	itemStencil := anElementStencil
]

{ #category : #accessing }
GtPhlowListView >> items: anObject [
	itemsBuilder := anObject
]

{ #category : #accessing }
GtPhlowListView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : #accessing }
GtPhlowListView >> send [
	^ transformation
]

{ #category : #accessing }
GtPhlowListView >> send: anOneArgBlock [
	self
		assert: [ anOneArgBlock notNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	self
		assert: [ anOneArgBlock numArgs = 1 ]
		description: [ 'Send transformation block must receive one argument'  ].
	transformation := anOneArgBlock
]
