Class {
	#name : #GtPhlowColumn,
	#superclass : #Object,
	#instVars : [
		'resizer',
		'stencil',
		'title',
		'computation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #private }
GtPhlowColumn >> computation [
	^ computation
]

{ #category : #accessing }
GtPhlowColumn >> evaluated: aBlock [
	computation := aBlock
]

{ #category : #accessing }
GtPhlowColumn >> fitContent [
	self resizer: BlLayoutResizer fitContent
]

{ #category : #initialization }
GtPhlowColumn >> initialize [
	super initialize.
	
	resizer := BlLayoutResizer fitContent.
	title := 'Column'.

	computation := [ :eachItem :eachIndex | eachItem ].

	stencil := [ :eachColumnItem :eachItem :currentColumn |
		| columnElement |
		
		columnElement := BrLabel new
			look: BrGlamorousLabelLook;
			text: (eachColumnItem isString
				ifTrue: [ eachColumnItem ]
				ifFalse: [ (eachColumnItem isKindOf: BlText)
					ifTrue: [ eachColumnItem ]
					ifFalse: [ eachColumnItem gtDisplayString ] ]).
			
		(currentColumn resizer notNil and: [ currentColumn resizer isMatchParent ])
			ifTrue: [
				columnElement addChild: (BlElement new
					background: (BlLinearGradientPaint horizontal from: (Color white alpha: 0) to: Color white);
					constraintsDo: [ :c |
						c ignoreByLayout.
						c ignored horizontal alignRight.
						c vertical matchParent.
						c horizontal exact: 30 ]) ].
		columnElement ]
]

{ #category : #accessing }
GtPhlowColumn >> matchParent [
	self resizer: BlLayoutResizer matchParent
]

{ #category : #accessing }
GtPhlowColumn >> noResize [
	resizer := nil
]

{ #category : #private }
GtPhlowColumn >> resizer [
	^ resizer
]

{ #category : #private }
GtPhlowColumn >> resizer: aBlLayoutResizer [
	resizer := aBlLayoutResizer
]

{ #category : #private }
GtPhlowColumn >> stencil [
	^ stencil
]

{ #category : #accessing }
GtPhlowColumn >> stencil: aColumnStencilBuilder [
	stencil := aColumnStencilBuilder
]

{ #category : #private }
GtPhlowColumn >> title [
	^ title
]

{ #category : #accessing }
GtPhlowColumn >> title: anObject [
	title := anObject
]

{ #category : #accessing }
GtPhlowColumn >> width: aNumber [
	self resizer: (BlLayoutResizer exact: aNumber)
]
