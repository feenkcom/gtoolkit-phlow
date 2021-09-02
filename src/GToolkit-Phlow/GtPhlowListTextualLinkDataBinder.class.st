Class {
	#name : 'GtPhlowListTextualLinkDataBinder',
	#superclass : 'BrListItemDataBinder',
	#instVars : [
		'textComputation'
	],
	#category : 'GToolkit-Phlow-Support - List'
}

{ #category : 'api - instantiation' }
GtPhlowListTextualLinkDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| aText |

	aText := textComputation
		phlowValue: itemObject
		withEnoughArguments: { itemObject. itemPosition }.

	itemElement label: aText gtDisplayText.
	itemElement model: (itemPosition -> itemObject).

	^ itemElement
]

{ #category : 'accessing' }
GtPhlowListTextualLinkDataBinder >> textComputation [

	^ textComputation
]

{ #category : 'accessing' }
GtPhlowListTextualLinkDataBinder >> textComputation: anObject [
	textComputation := anObject
]
