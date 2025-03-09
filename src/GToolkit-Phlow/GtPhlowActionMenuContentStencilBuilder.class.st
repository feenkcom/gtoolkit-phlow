Class {
	#name : #GtPhlowActionMenuContentStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'actionElement',
		'targetElement'
	],
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #accessing }
GtPhlowActionMenuContentStencilBuilder >> actionElement [
	^ actionElement
]

{ #category : #accessing }
GtPhlowActionMenuContentStencilBuilder >> actionElement: anElement [
	actionElement := anElement
]

{ #category : #'api - instantiation' }
GtPhlowActionMenuContentStencilBuilder >> buildDefault [
	<return: #BrMenu or: nil>
	^ nil
]

{ #category : #accessing }
GtPhlowActionMenuContentStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.

	aStencilExecutor push: self actionElement.
	aStencilExecutor push: self targetElement.
]

{ #category : #accessing }
GtPhlowActionMenuContentStencilBuilder >> reset [
	actionElement := nil.
	targetElement := nil
]

{ #category : #accessing }
GtPhlowActionMenuContentStencilBuilder >> targetElement [
	^ targetElement
]

{ #category : #accessing }
GtPhlowActionMenuContentStencilBuilder >> targetElement: anElement [
	targetElement := anElement 
]
