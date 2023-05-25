Class {
	#name : #GtPhlowColumnCellItemComputationDataBinder,
	#superclass : #BrColumnCellDataBinder,
	#instVars : [
		'dataBinder',
		'itemComputation',
		'backgroundComputation'
	],
	#category : #'GToolkit-Phlow-Support - List columned'
}

{ #category : #accessing }
GtPhlowColumnCellItemComputationDataBinder class >> stencilProperties [
	^ #(dataBinder itemComputation)
]

{ #category : #accessing }
GtPhlowColumnCellItemComputationDataBinder >> backgroundComputation: anObject [
	backgroundComputation := anObject
]

{ #category : #'api - instantiation' }
GtPhlowColumnCellItemComputationDataBinder >> buildDefault [
	| aValue aBackground |
	aValue := itemComputation
			phlowValue: itemObject
			withEnoughArguments: {
				itemObject.
				rowIndex.
				rowHolder.
				columnIndex }.

	aBackground := backgroundComputation
			phlowValue: aValue
			withEnoughArguments: {
				aValue.
				itemObject.
				rowIndex.
				rowHolder.
				columnIndex }.

	cellElement background: aBackground.

	^ dataBinder
		cellElement: cellElement;
		itemObject: aValue;
		rowObject: rowObject;
		rowIndex: rowIndex;
		rowHolder: rowHolder;
		columnIndex: columnIndex;
		build
]

{ #category : #accessing }
GtPhlowColumnCellItemComputationDataBinder >> dataBinder: anObject [

	dataBinder := anObject
]

{ #category : #accessing }
GtPhlowColumnCellItemComputationDataBinder >> itemComputation: anObject [
	itemComputation := anObject
]
