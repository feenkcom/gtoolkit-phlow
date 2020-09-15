Class {
	#name : #GtPhlowSendObjectTransformation,
	#superclass : #GtPhlowSendTransformation,
	#category : #'GToolkit-Phlow-Support - Transformation'
}

{ #category : #defaults }
GtPhlowSendObjectTransformation >> defaultValuable [
	"There is not trransformation by default"
	^ [ :anObject | anObject ]
]

{ #category : #'api - events' }
GtPhlowSendObjectTransformation >> select: aSelectedObject indices: aSelectionIndices from: anElement [
	| aTransformedValue |
	aTransformedValue := self transformedValueFrom: aSelectedObject selection: aSelectionIndices.
	anElement phlow selectObject: aTransformedValue.
	anElement fireEvent: (GLMBlocObjectToSelect new toSelect: aTransformedValue)
]

{ #category : #'api - events' }
GtPhlowSendObjectTransformation >> spawn: aSelectedObject indices: aSelectionIndices from: anElement [
	| aTransformedValue |
	aTransformedValue := self transformedValueFrom: aSelectedObject selection: aSelectionIndices.
	anElement phlow spawnObject: aTransformedValue.
	anElement fireEvent: (GLMBlocObjectToSelect new toSelect: aTransformedValue)
]
