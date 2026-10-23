"
Wraps a column stencil with ordered visual decorations inside the error-handling container.
"
Class {
	#name : #GtPhlowColumnDecorationsCellStencilBuilder,
	#superclass : #BrColumnCellStencilBuilder,
	#instVars : [
		'cellStencil',
		'decorations'
	],
	#category : #'GToolkit-Phlow-Support - Decorations'
}

{ #category : #accessing }
GtPhlowColumnDecorationsCellStencilBuilder class >> stencilProperties [
	^ #(cellStencil decorations)
]

{ #category : #building }
GtPhlowColumnDecorationsCellStencilBuilder >> buildDefault [
	^ decorations wrap: (cellStencil itemType: itemType; column: column; columnIndex: columnIndex; build)
]

{ #category : #accessing }
GtPhlowColumnDecorationsCellStencilBuilder >> cellStencil: aStencil [
	cellStencil := aStencil asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #accessing }
GtPhlowColumnDecorationsCellStencilBuilder >> decorations: aDecorations [
	decorations := aDecorations
]
