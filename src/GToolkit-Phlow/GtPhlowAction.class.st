Class {
	#name : #GtPhlowAction,
	#superclass : #Object,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowAction >> asElementDo: aBlock withElement: aTargetElement [
	| element |
	element := [ stencilBuilder targetElement: aTargetElement. stencilBuilder asElement ] 
		on: Error 
		do: [ :error | 
			error freeze.
			GtPhlowActionWithError new 
				error: error; 
				asElementDo: [ :errorElement | errorElement ] withElement: aTargetElement ].
	^ aBlock value: element.
]

{ #category : #accessing }
GtPhlowAction >> explicit [
	^ GtPhlowAction new
]

{ #category : #accessing }
GtPhlowAction >> noAction [
	^ GtPhlowNoAction new
]

{ #category : #accessing }
GtPhlowAction >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder: GtPhlowActionStencilBuilder  
]

{ #category : #accessing }
GtPhlowAction >> stencilBuilder [
	^ stencilBuilder
]
