Class {
	#name : 'GtPhlowListContextMenuStencilBuilder',
	#superclass : 'BrStencilBuilder',
	#instVars : [
		'itemType',
		'itemElement',
		'itemObject',
		'itemPosition'
	],
	#category : 'GToolkit-Phlow-Support - Lists'
}

{ #category : 'api - instantiation' }
GtPhlowListContextMenuStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ BlElement new
]

{ #category : 'accessing' }
GtPhlowListContextMenuStencilBuilder >> itemElement [

	^ itemElement
]

{ #category : 'accessing' }
GtPhlowListContextMenuStencilBuilder >> itemElement: anObject [

	itemElement := anObject
]

{ #category : 'accessing' }
GtPhlowListContextMenuStencilBuilder >> itemObject [

	^ itemObject
]

{ #category : 'accessing' }
GtPhlowListContextMenuStencilBuilder >> itemObject: anObject [

	itemObject := anObject
]

{ #category : 'accessing' }
GtPhlowListContextMenuStencilBuilder >> itemPosition [

	^ itemPosition
]

{ #category : 'accessing' }
GtPhlowListContextMenuStencilBuilder >> itemPosition: anObject [

	itemPosition := anObject
]

{ #category : 'accessing' }
GtPhlowListContextMenuStencilBuilder >> itemType [

	^ itemType
]

{ #category : 'accessing' }
GtPhlowListContextMenuStencilBuilder >> itemType: anObject [

	itemType := anObject
]
