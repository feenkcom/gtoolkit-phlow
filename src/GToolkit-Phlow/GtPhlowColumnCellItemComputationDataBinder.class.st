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
	^ #(dataBinder itemComputation backgroundComputation)
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
				rowIndex.
				columnIndex }.

	aBackground := backgroundComputation
			phlowValue: aValue
			withEnoughArguments: {
				itemObject.
				rowIndex.
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
GtPhlowColumnCellItemComputationDataBinder >> dataBinder: aStencilBuilder [
	dataBinder := aStencilBuilder asStencilBuilder: BrColumnCellDataBinder
]

{ #category : #accessing }
GtPhlowColumnCellItemComputationDataBinder >> itemComputation: anObject [
	itemComputation := anObject
]
