"
I am {{gtClass:GtPhlowSendValuableTransformation}}.
I use {{gtMethod:GtPhlowElementContext>>#selectObject:}} and {{gtMethod:GtPhlowElementContext>>#spawnObject:|label=#selector}} in order to display objects.
See {{gtClass:TGtPhlowSendTransformable}} for more details and examples.


"
Class {
	#name : #GtPhlowSendObjectTransformation,
	#superclass : #GtPhlowSendValuableTransformation,
	#category : #'GToolkit-Phlow-Support - Transformation'
}

{ #category : #defaults }
GtPhlowSendObjectTransformation >> defaultValuable [
	"There is not transformation by default"
	^ [ :anObject | anObject ]
]

{ #category : #'api - events' }
GtPhlowSendObjectTransformation >> select: aSelectedObject indices: aSelectionIndices from: anElement shouldShowSpace: shouldOpenInSpace [
	| aTransformedValue |
	aTransformedValue := self 
		transformedValueFrom: aSelectedObject 
		selection: aSelectionIndices.
	
	shouldOpenInSpace 
		ifTrue: [ self spawnInSpaceObject: aTransformedValue from: anElement  ]
		ifFalse: [ anElement phlow selectObject: aTransformedValue ]
]

{ #category : #'api - events' }
GtPhlowSendObjectTransformation >> spawn: aSelectedObject indices: aSelectionIndices from: anElement [
	| aTransformedValue |
	aTransformedValue := self transformedValueFrom: aSelectedObject selection: aSelectionIndices.
	anElement phlow spawnObject: aTransformedValue
]

{ #category : #utils }
GtPhlowSendObjectTransformation >> spawnInSpaceObject: aSelectedObject from: anElement [ 
	GtWorldUtility
		showObject: aSelectedObject
		from:anElement
]
