Class {
	#name : #GtPhlowExplicitTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'name',
		'stencil',
		'icon',
		'tabLook'
	],
	#category : #'GToolkit-Phlow-Tool - Core'
}

{ #category : #'api - converting' }
GtPhlowExplicitTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."

	| anElement |
	anElement := [ self stencil value asElement ]
			onErrorDo: [ :anError | anError asDebuggableElement ].
	self
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'Valuable tool must create an element on #asElementDo: call' ].

	^ aOneArgBlock cull: anElement cull: self
]

{ #category : #'api - converting' }
GtPhlowExplicitTool >> canRecreateToolElement [
	^ (self stencil isKindOf: BlElement) not
]

{ #category : #'private - accessing' }
GtPhlowExplicitTool >> defaultTabLook [
	^ BrGlamorousTabSwitcherWithLabelAptitude
]

{ #category : #accessing }
GtPhlowExplicitTool >> icon [
	^ icon ifNil: [ super icon ]
]

{ #category : #accessing }
GtPhlowExplicitTool >> icon: anIconStencil [
	icon := anIconStencil asStencil
]

{ #category : #initialization }
GtPhlowExplicitTool >> initialize [
	super initialize.
	stencil := [ BrFrame new matchParent ] asStencil.
	name := 'Exlicit'.
	icon := nil.
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

{ #category : #'private - accessing' }
GtPhlowExplicitTool >> tabLook [
	^ tabLook ifNil: [ 
		self defaultTabLook ]
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

{ #category : #configuring }
GtPhlowExplicitTool >> withIconAptitude [
	tabLook := BrGlamorousTabSwitcherWithIconAptitude
]

{ #category : #configuring }
GtPhlowExplicitTool >> withLabelAndIconAptitude [
	tabLook := BrGlamorousTabSwitcherWithLabelAndIconAptitude
]

{ #category : #configuring }
GtPhlowExplicitTool >> withLabelAptitude [
	tabLook := BrGlamorousTabSwitcherWithLabelAptitude
]
