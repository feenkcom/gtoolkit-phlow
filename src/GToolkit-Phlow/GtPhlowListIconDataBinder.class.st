Class {
	#name : 'GtPhlowListIconDataBinder',
	#superclass : 'BrListItemDataBinder',
	#instVars : [
		'iconComputation'
	],
	#category : 'GToolkit-Phlow-Support - List'
}

{ #category : 'api - instantiation' }
GtPhlowListIconDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| anIcon |

	anIcon := (iconComputation
		phlowValue: itemObject
		withEnoughArguments: { itemObject. itemPosition }) asElement.

	itemElement
		removeChildren;
		addChild: anIcon.

	^ itemElement
]

{ #category : 'accessing' }
GtPhlowListIconDataBinder >> iconComputation: anObject [

	iconComputation := anObject
]
