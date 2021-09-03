Class {
	#name : 'GtPhlowListIconDataBinder',
	#superclass : 'BrListItemDataBinder',
	#category : 'GToolkit-Phlow-Support - List'
}

{ #category : 'api - instantiation' }
GtPhlowListIconDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	itemElement
		removeChildren;
		addChild: itemObject asElement.

	^ itemElement
]
