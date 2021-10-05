Class {
	#name : #GtPhlowColumnCellItemComputationDataBinder,
	#superclass : #BrColumnCellDataBinder,
	#instVars : [
		'dataBinder',
		'itemComputation'
	],
	#category : 'GToolkit-Phlow-Support - List columned'
}

{ #category : #'api - instantiation' }
GtPhlowColumnCellItemComputationDataBinder >> buildDefault [
	| aValue |
	
	aValue := itemComputation phlowValue: itemObject withEnoughArguments: { itemObject. rowIndex. rowHolder . columnIndex }.
	
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
