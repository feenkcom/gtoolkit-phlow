Class {
	#name : #GtPhlowExplicitTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'name',
		'stencil'
	],
	#category : #'GToolkit-Phlow-Tool - Core'
}

{ #category : #'api - converting' }
GtPhlowExplicitTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	| anElement |
	anElement := self stencil value asElement.
	self 
		assert: [ anElement isKindOf: BlElement ] 
		description: [ 'Valuable tool must create an element on #asElementDo: call' ].
	
	^ aOneArgBlock cull: anElement cull: self
]

{ #category : #initialization }
GtPhlowExplicitTool >> initialize [
	super initialize.
	stencil := [ BrFrame new matchParent ] asStencil.
	name := 'Exlicit'.
]

{ #category : #accessing }
GtPhlowExplicitTool >> name [
	^ name
]

{ #category : #accessing }
GtPhlowExplicitTool >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtPhlowExplicitTool >> stencil [
	^ stencil
]

{ #category : #accessing }
GtPhlowExplicitTool >> stencil: aStencil [
	stencil := aStencil asStencil
]

{ #category : #accessing }
GtPhlowExplicitTool >> valuable [
	self
		deprecated: 'Please use #stencil instead.'
		transformWith: '`@receiver valuable' -> '`@receiver stencil'.
	^ self stencil
]

{ #category : #accessing }
GtPhlowExplicitTool >> valuable: aStencil [
	self
		deprecated: 'Please use stencil: instead.'
		transformWith:
			'`@receiver valuable: `@statements1'
				-> '`@receiver stencil: `@statements1'.
	self stencil: aStencil
]
