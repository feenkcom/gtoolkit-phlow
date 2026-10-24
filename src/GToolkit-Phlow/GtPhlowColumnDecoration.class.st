"
Protocol for reusable column cell decorations. Instances own configuration and per-content-cycle state, not per-cell visual state.
"
Class {
	#name : #GtPhlowColumnDecoration,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Support - Decorations'
}

{ #category : #binding }
GtPhlowColumnDecoration >> bind: anElement value: aValue rowIndex: aRowIndex columnIndex: aColumnIndex [
	"Override to update this decoration's wrapper. Never recompute the column item."
]

{ #category : #updating }
GtPhlowColumnDecoration >> prepareForUpdateContent [
	"Override to invalidate per-content-cycle state."
]

{ #category : #building }
GtPhlowColumnDecoration >> wrap: anElement [
	^ GtPhlowColumnDecorationElement new content: anElement
]
