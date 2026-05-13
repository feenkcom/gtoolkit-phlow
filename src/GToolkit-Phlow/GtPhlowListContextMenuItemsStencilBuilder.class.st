"
I build {{gtClass:BrMenu}} sub-instances.
"
Class {
	#name : #GtPhlowListContextMenuItemsStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'itemType',
		'itemElement',
		'itemObject',
		'itemPosition'
	],
	#category : #'GToolkit-Phlow-Support - List utilities'
}

{ #category : #'api - instantiation' }
GtPhlowListContextMenuItemsStencilBuilder >> buildDefault [
	<return: #BrMenu of: #nil>
	^ nil
]

{ #category : #accessing }
GtPhlowListContextMenuItemsStencilBuilder >> itemElement [

	^ itemElement
]

{ #category : #accessing }
GtPhlowListContextMenuItemsStencilBuilder >> itemElement: anObject [

	itemElement := anObject
]

{ #category : #accessing }
GtPhlowListContextMenuItemsStencilBuilder >> itemObject [

	^ itemObject
]

{ #category : #accessing }
GtPhlowListContextMenuItemsStencilBuilder >> itemObject: anObject [

	itemObject := anObject
]

{ #category : #accessing }
GtPhlowListContextMenuItemsStencilBuilder >> itemPosition [

	^ itemPosition
]

{ #category : #accessing }
GtPhlowListContextMenuItemsStencilBuilder >> itemPosition: anObject [

	itemPosition := anObject
]

{ #category : #accessing }
GtPhlowListContextMenuItemsStencilBuilder >> itemType [

	^ itemType
]

{ #category : #accessing }
GtPhlowListContextMenuItemsStencilBuilder >> itemType: anObject [

	itemType := anObject
]

{ #category : #'api - instantiation' }
GtPhlowListContextMenuItemsStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self itemElement;
		push: self itemObject;
		push: self itemPosition;
		push: self itemType
]

{ #category : #accessing }
GtPhlowListContextMenuItemsStencilBuilder >> reset [
	itemType := nil.
	itemElement := nil.
	itemObject := nil.
	itemPosition := nil
]
