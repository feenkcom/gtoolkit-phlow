Class {
	#name : 'GtPhlowListTextDataBinder',
	#superclass : 'BrListItemDataBinder',
	#instVars : [
		'textComputation'
	],
	#category : 'GToolkit-Phlow-Support - List'
}

{ #category : 'api - instantiation' }
GtPhlowListTextDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| aText |

	aText := textComputation
		phlowValue: itemObject
		withEnoughArguments: { itemObject. itemPosition }.

	itemElement text: aText gtDisplayText.

	^ itemElement
]

{ #category : 'accessing' }
GtPhlowListTextDataBinder >> textComputation [

	^ textComputation
]

{ #category : 'accessing' }
GtPhlowListTextDataBinder >> textComputation: anObject [

	textComputation := anObject
]
