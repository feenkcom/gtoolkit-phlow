Class {
	#name : 'GtPhlowListTextDataBinder',
	#superclass : 'BrListItemDataBinder',
	#category : 'GToolkit-Phlow-Support - List'
}

{ #category : 'api - instantiation' }
GtPhlowListTextDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	itemElement text: itemObject gtDisplayText.
	^ itemElement
]
