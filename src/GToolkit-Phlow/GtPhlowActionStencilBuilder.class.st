Class {
	#name : #GtPhlowActionStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'targetElement'
	],
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #'api - instantiation' }
GtPhlowActionStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	^ BlElement new
]

{ #category : #accessing }
GtPhlowActionStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.

	aStencilExecutor push: self targetElement.
]

{ #category : #accessing }
GtPhlowActionStencilBuilder >> reset [
	targetElement := nil
]

{ #category : #accessing }
GtPhlowActionStencilBuilder >> targetElement [
	^ targetElement
]

{ #category : #accessing }
GtPhlowActionStencilBuilder >> targetElement: anElement [
	targetElement := anElement 
]
