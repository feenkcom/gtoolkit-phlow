Class {
	#name : #GtPhlowExplicitAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowExplicitAction >> asElement: aBlock withHostElement: aTargetElement [
	| anElement |
	anElement := [ 
			| button |
			stencilBuilder targetElement: aTargetElement.
			button := stencilBuilder asElement.
			button phlow 
				beAction;
				entity: self.
			button ]
		on: Error
		do: [ :error | 
			error freeze.
			GtPhlowActionWithError new
				error: error;
				definingMethod: self definingMethod;
				asElement: [ :errorElement | errorElement ]
					withHostElement: aTargetElement ].
	self attachShowDefinitionEventHandler: anElement.
	^ aBlock value: anElement
]

{ #category : #initialization }
GtPhlowExplicitAction >> initialize [
	super initialize.
	stencilBuilder := nil.
]

{ #category : #accessing }
GtPhlowExplicitAction >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder: GtPhlowActionStencilBuilder  
]

{ #category : #accessing }
GtPhlowExplicitAction >> stencilBuilder [
	^ stencilBuilder
]
