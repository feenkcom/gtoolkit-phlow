Class {
	#name : #GtPhlowRenderingStencil,
	#superclass : #BrStencil,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'text'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'api - instantiation' }
GtPhlowRenderingStencil >> create [
	<return: #Object>

	^ BlElement new
		layout: BlFrameLayout new;
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: self newProgressElement.
]

{ #category : #initialization }
GtPhlowRenderingStencil >> defaultText [
	^ 'Rendering...' asRopedText 
			foreground: Color gray lighter;
			fontSize: 12
]

{ #category : #initialization }
GtPhlowRenderingStencil >> initialize [
	super initialize.
	text := self defaultText.
]

{ #category : #'instance creation' }
GtPhlowRenderingStencil >> newProgressElement [
	| aProgressElement |
	aProgressElement := BlElement new.
	aProgressElement
		layout: BlFrameLayout new;
		addChild:
			(BlTextElement new
				text: self text;
				geometry: (BlRectangle cornerRadius: 7);
				padding:
					(BlInsets
						top: 10
						left: 20
						bottom: 10
						right: 20);
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ])
			as: #progressText.
	aProgressElement
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	^ aProgressElement
]

{ #category : #accessing }
GtPhlowRenderingStencil >> text [
	<return: #BlRopedText>
	^ text
]

{ #category : #accessing }
GtPhlowRenderingStencil >> text: aStringOrText [
	text := aStringOrText asRopedText
]
