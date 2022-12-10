Class {
	#name : #GtPhlowExplicitAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'GToolkit-Phlow-! Actions'
}

{ #category : #converting }
GtPhlowExplicitAction >> asElement: aBlock withHostElement: aTargetElement [
	| anElement |
	anElement := [ 
		self newExplicitElementWithTargetElement: aTargetElement.
	]	on: Error
		do: [ :anError | 
			self 
				newErrorElementFor: anError 
				targetElement: aTargetElement ].
	id ifNotNil: [ anElement id: self id ].
	self attachShowDefinitionEventHandler: anElement.
	^ aBlock value: anElement
]

{ #category : #'instance creation' }
GtPhlowExplicitAction >> newErrorElementFor: anError targetElement: aTargetElement [
	anError freeze.
	^ GtPhlowActionWithError new
		error: anError;
		definingMethod: self definingMethod;
		asElement: [ :errorElement | errorElement ]
			withHostElement: aTargetElement
]

{ #category : #'instance creation' }
GtPhlowExplicitAction >> newExplicitElementWithTargetElement: aTargetElement [
	| anExplicitElement |
	stencilBuilder targetElement: aTargetElement.
	anExplicitElement := stencilBuilder asElement.
	anExplicitElement phlow
		beAction;
		entity: self.
	self 
		attachTooltipFor: anExplicitElement 
		hostElement: aTargetElement.
	^ anExplicitElement
]

{ #category : #accessing }
GtPhlowExplicitAction >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder: GtPhlowActionStencilBuilder  
]

{ #category : #accessing }
GtPhlowExplicitAction >> stencilBuilder [
	^ stencilBuilder
]
