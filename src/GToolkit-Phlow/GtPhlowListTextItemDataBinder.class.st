Class {
	#name : 'GtPhlowListTextItemDataBinder',
	#superclass : 'BrListItemDataBinder',
	#instVars : [
		'textComputation'
	],
	#category : 'GToolkit-Phlow-Support - Lists'
}

{ #category : 'api - instantiation' }
GtPhlowListTextItemDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| aText |

	aText := textComputation
		phlowValue: itemObject
		withEnoughArguments: { itemObject. itemPosition }.

	itemElement text: aText gtDisplayText.

	^ itemElement
]

{ #category : 'accessing' }
GtPhlowListTextItemDataBinder >> textComputation [

	^ textComputation
]

{ #category : 'accessing' }
GtPhlowListTextItemDataBinder >> textComputation: anObject [

	textComputation := anObject
]
