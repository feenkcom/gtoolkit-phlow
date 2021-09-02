Class {
	#name : 'GtPhlowListIconNamedDataBinder',
	#superclass : 'BrListItemDataBinder',
	#instVars : [
		'iconNameComputation'
	],
	#category : 'GToolkit-Phlow-Support - List'
}

{ #category : 'api - instantiation' }
GtPhlowListIconNamedDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| anIconName anIcon |

	anIconName := (iconNameComputation
		phlowValue: itemObject
		withEnoughArguments: { itemObject. itemPosition }) asSymbol.

	anIcon := (Smalltalk ui icons iconNamed: anIconName) asElement.

	itemElement
		removeChildren;
		addChild: anIcon.

	^ itemElement
]

{ #category : 'accessing' }
GtPhlowListIconNamedDataBinder >> iconNameComputation: anObject [

	iconNameComputation := anObject
]
