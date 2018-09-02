Class {
	#name : #GtPhlowActionStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'stencilBuilder',
		'targetElement'
	],
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #accessing }
GtPhlowActionStencilBuilder >> paramsOn: aStencilExecutor [

	aStencilExecutor
		push: self targetElement
]

{ #category : #accessing }
GtPhlowActionStencilBuilder >> targetElement [
	^ targetElement
]

{ #category : #accessing }
GtPhlowActionStencilBuilder >> targetElement: anElement [
	targetElement := anElement 
]
