"
I am {{gtClass:GtPhlowSendValuableTransformation}}.
I use {{gtMethod:GtPhlowElementContext>>#selectTool:}} and {{gtMethod:GtPhlowElementContext>>#spawnTool:|label=#selector}} in order to display objects.
See {{gtClass:TGtPhlowSendTransformable}} for more details and examples.


"
Class {
	#name : #GtPhlowSendToolTransformation,
	#superclass : #GtPhlowSendValuableTransformation,
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
