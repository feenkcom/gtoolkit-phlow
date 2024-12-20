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
	^ [ :anObject | anObject gtDefaultInspectorTool ]
]

{ #category : #'api - events' }
GtPhlowSendToolTransformation >> select: aSelectedObject indices: aSelectionIndices from: anElement shouldShowSpace: shouldOpenInSpace [
	| aTransformedTool |
	aTransformedTool := self 
		transformedValueFrom: aSelectedObject 
		selection: aSelectionIndices.
		
	shouldOpenInSpace 
		ifTrue: [ 
			BlSpace new 
				title: aTransformedTool name;
				icon: aTransformedTool icon;
				inPager: [ aTransformedTool asElement ] asStencil;
				withSceneDriller;
				showFrom: anElement ]
		ifFalse: [ anElement phlow selectTool: aTransformedTool ]
]

{ #category : #'api - events' }
GtPhlowSendToolTransformation >> spawn: aSelectedObject indices: aSelectionIndices from: anElement shouldShowSpace: shouldShowSpace [
	| aTransformedTool |
	aTransformedTool := self transformedValueFrom: aSelectedObject selection: aSelectionIndices.
	shouldShowSpace 
		ifTrue: [ 
			BlSpace new 
				title: aTransformedTool name;
				icon: aTransformedTool icon;
				inPager: [ aTransformedTool asElement ] asStencil;
				withSceneDriller;
				showFrom: anElement ]
		ifFalse: [ anElement phlow spawnTool: aTransformedTool ]
]
