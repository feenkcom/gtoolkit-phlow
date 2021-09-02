Class {
	#name : 'GtPhlowColumnCellItemComputationDataBinder',
	#superclass : 'BrColumnCellDataBinder',
	#instVars : [
		'dataBinder',
		'itemComputation'
	],
	#category : 'GToolkit-Phlow-Support - List columned'
}

{ #category : 'api - instantiation' }
GtPhlowColumnCellItemComputationDataBinder >> buildDefault [
	| aValue |
	
	aValue := itemComputation phlowValue: rowObject withEnoughArguments: { rowObject. rowIndex. rowHolder . columnIndex }.
	
	^ dataBinder
		cellElement: cellElement;
		rowObject: aValue;
		rowIndex: rowIndex;
		rowHolder: rowHolder;
		columnIndex: columnIndex;
		build
]

{ #category : 'accessing' }
GtPhlowColumnCellItemComputationDataBinder >> dataBinder: anObject [

	dataBinder := anObject
]

{ #category : 'accessing' }
GtPhlowColumnCellItemComputationDataBinder >> itemComputation: anObject [

	itemComputation := anObject
]
