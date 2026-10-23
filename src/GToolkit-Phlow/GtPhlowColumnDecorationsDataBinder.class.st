"
Binds decorations and primary content using the same already-computed item, preserving row and column context.
"
Class {
	#name : #GtPhlowColumnDecorationsDataBinder,
	#superclass : #BrColumnCellDataBinder,
	#instVars : [
		'dataBinder',
		'decorations'
	],
	#category : #'GToolkit-Phlow-Support - Decorations'
}

{ #category : #accessing }
GtPhlowColumnDecorationsDataBinder class >> stencilProperties [
	^ #(dataBinder decorations)
]

{ #category : #building }
GtPhlowColumnDecorationsDataBinder >> buildDefault [
	| content |
	content := cellElement.
	decorations items reverseDo: [ :decoration |
		decoration bind: content value: itemObject rowIndex: rowIndex columnIndex: columnIndex.
		content := content content ].
	^ dataBinder
		cellElement: content;
		itemObject: itemObject;
		rowObject: rowObject;
		rowIndex: rowIndex;
		rowHolder: rowHolder;
		columnIndex: columnIndex;
		build
]

{ #category : #accessing }
GtPhlowColumnDecorationsDataBinder >> dataBinder: aBinder [
	dataBinder := aBinder asStencilBuilder: BrColumnCellDataBinder
]

{ #category : #accessing }
GtPhlowColumnDecorationsDataBinder >> decorations: aDecorations [
	decorations := aDecorations
]
