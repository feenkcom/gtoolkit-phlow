Class {
	#name : #GtPhlowSimpleListItemComputationDataBinder,
	#superclass : #BrListItemDataBinder,
	#instVars : [
		'dataBinder',
		'itemComputation'
	],
	#category : 'GToolkit-Phlow-Support - List simple'
}

{ #category : #'api - instantiation' }
GtPhlowSimpleListItemComputationDataBinder >> buildDefault [
	| aValue |

	aValue := itemComputation phlowValue: itemObject withEnoughArguments: { itemObject. itemPosition }.

	^ dataBinder
		itemElement: itemElement;
		itemObject: aValue;
		rowObject: rowObject;
		itemPosition: itemPosition;
		build
]

{ #category : #accessing }
GtPhlowSimpleListItemComputationDataBinder >> dataBinder: aBrListItemDataBinder [
	dataBinder := aBrListItemDataBinder asStencilBuilder: BrListItemDataBinder
]

{ #category : #accessing }
GtPhlowSimpleListItemComputationDataBinder >> itemComputation: aBlock [
	itemComputation := aBlock
]
