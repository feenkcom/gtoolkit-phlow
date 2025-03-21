Class {
	#name : #GtPhlowListContextMenuStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'itemType',
		'itemElement',
		'itemObject',
		'itemPosition'
	],
	#category : #'GToolkit-Phlow-Support - List utilities'
}

{ #category : #testing }
GtPhlowListContextMenuStencilBuilder class >> isDeprecated [
	"Use GtPhlowListContextMenuItemsStencilBuilder instead"

	^ true
]

{ #category : #'api - instantiation' }
GtPhlowListContextMenuStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ BlElement new
]

{ #category : #accessing }
GtPhlowListContextMenuStencilBuilder >> itemElement [

	^ itemElement
]

{ #category : #accessing }
GtPhlowListContextMenuStencilBuilder >> itemElement: anObject [

	itemElement := anObject
]

{ #category : #accessing }
GtPhlowListContextMenuStencilBuilder >> itemObject [

	^ itemObject
]

{ #category : #accessing }
GtPhlowListContextMenuStencilBuilder >> itemObject: anObject [

	itemObject := anObject
]

{ #category : #accessing }
GtPhlowListContextMenuStencilBuilder >> itemPosition [

	^ itemPosition
]

{ #category : #accessing }
GtPhlowListContextMenuStencilBuilder >> itemPosition: anObject [

	itemPosition := anObject
]

{ #category : #accessing }
GtPhlowListContextMenuStencilBuilder >> itemType [

	^ itemType
]

{ #category : #accessing }
GtPhlowListContextMenuStencilBuilder >> itemType: anObject [

	itemType := anObject
]

{ #category : #'api - instantiation' }
GtPhlowListContextMenuStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self itemElement;
		push: self itemObject;
		push: self itemPosition;
		push: self itemType
]

{ #category : #accessing }
GtPhlowListContextMenuStencilBuilder >> reset [
	itemType := nil.
	itemElement := nil.
	itemObject := nil.
	itemPosition := nil
]
