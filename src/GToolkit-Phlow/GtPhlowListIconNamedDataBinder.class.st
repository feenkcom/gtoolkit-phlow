Class {
	#name : #GtPhlowListIconNamedDataBinder,
	#superclass : #BrListItemDataBinder,
	#category : 'GToolkit-Phlow-Support - List'
}

{ #category : #'api - instantiation' }
GtPhlowListIconNamedDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| anIcon |

	anIcon := (Smalltalk ui icons iconNamed: itemObject asSymbol) asElement.

	itemElement
		removeChildren;
		addChild: anIcon.

	^ itemElement
]
