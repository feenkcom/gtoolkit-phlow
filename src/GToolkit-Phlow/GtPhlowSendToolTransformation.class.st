Class {
	#name : #GtPhlowSendToolTransformation,
	#superclass : #GtPhlowSendValuableTransformatioin,
	#category : #'GToolkit-Phlow-Support - Transformation'
}

{ #category : #defaults }
GtPhlowSendToolTransformation >> defaultValuable [
	"There is not trransformation by default"
	^ [ :anObject | GtPhlowTool default object: anObject ]
]

{ #category : #'api - events' }
GtPhlowSendToolTransformation >> select: aSelectedObject indices: aSelectionIndices from: anElement [
	| aTransformedTool |
	aTransformedTool := self transformedValueFrom: aSelectedObject selection: aSelectionIndices.
	anElement phlow selectTool: aTransformedTool.
	anElement fireEvent: (GLMBlocObjectToSelect new toSelect: aTransformedTool)
]

{ #category : #'api - events' }
GtPhlowSendToolTransformation >> spawn: aSelectedObject indices: aSelectionIndices from: anElement [
	| aTransformedTool |
	aTransformedTool := self transformedValueFrom: aSelectedObject selection: aSelectionIndices.
	anElement phlow spawnTool: aTransformedTool.
	anElement fireEvent: (GLMBlocObjectToSelect new toSelect: aTransformedTool)
]
