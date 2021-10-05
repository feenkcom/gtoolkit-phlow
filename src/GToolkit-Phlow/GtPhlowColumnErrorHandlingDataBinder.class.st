Class {
	#name : #GtPhlowColumnErrorHandlingDataBinder,
	#superclass : #BrColumnCellDataBinder,
	#instVars : [
		'dataBinder'
	],
	#category : 'GToolkit-Phlow-Support - List columned'
}

{ #category : #accessing }
GtPhlowColumnErrorHandlingDataBinder >> buildDefault [	
	[
		dataBinder
			cellElement: cellElement content;
			itemObject: itemObject;
			rowObject: rowObject;
			rowIndex: rowIndex;
			rowHolder: rowHolder;
			columnIndex: columnIndex;
			build.
		cellElement
			removeException;
			showContent ]
	on: Error
	do: [ :anError |
		| anErrorElement |
		anErrorElement := anError asDebuggableElement
			vFitContent;
			hMatchParent.
		cellElement exception: anErrorElement ].

	^ cellElement
]

{ #category : #accessing }
GtPhlowColumnErrorHandlingDataBinder >> dataBinder: aBrColumnCellDataBinder [
	dataBinder := aBrColumnCellDataBinder asStencilBuilder: BrColumnCellDataBinder
]
