Class {
	#name : #GtPhlowActionStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'actionElement',
		'targetElement'
	],
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #accessing }
GtPhlowActionStencilBuilder >> actionElement [
	^ actionElement
]

{ #category : #accessing }
GtPhlowActionStencilBuilder >> actionElement: anElement [
	actionElement := anElement
]

{ #category : #'api - instantiation' }
GtPhlowActionStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	^ BlElement new
]

{ #category : #accessing }
GtPhlowActionStencilBuilder >> paramsOn: aStencilExecutor [

	self actionElement ifNotNil: [ 
		aStencilExecutor push: self actionElement ].
	aStencilExecutor push: self targetElement.
]

{ #category : #accessing }
GtPhlowActionStencilBuilder >> reset [
	actionElement := nil.
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
