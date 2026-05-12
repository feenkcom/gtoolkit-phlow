Class {
	#name : #GtPhlowListTextualLinkDataBinder,
	#superclass : #BrListItemDataBinder,
	#category : 'GToolkit-Phlow-Support - List'
}

{ #category : #'api - instantiation' }
GtPhlowListTextualLinkDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	
	itemElement label: itemObject gtDisplayText.
	itemElement model: (itemPosition -> rowObject).

	^ itemElement
]
