Class {
	#name : #GtPhlowExplicitAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowExplicitAction >> asElementDo: aBlock withParentElement: aTargetElement [
	| anElement |
	anElement := [ 
			stencilBuilder targetElement: aTargetElement.
			stencilBuilder asElement ]
		on: Error
		do: [ :error | 
			error freeze.
			GtPhlowActionWithError new
				error: error;
				definingMethod: self definingMethod;
				asElementDo: [ :errorElement | errorElement ]
					withParentElement: aTargetElement ].
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
