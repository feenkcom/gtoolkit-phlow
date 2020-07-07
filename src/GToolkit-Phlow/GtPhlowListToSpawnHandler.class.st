Class {
	#name : #GtPhlowListToSpawnHandler,
	#superclass : #GtPhlowListHandler,
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #accessing }
GtPhlowListToSpawnHandler >> eventClass [
	^ BrSelectionChanged
]

{ #category : #'api - event managing' }
GtPhlowListToSpawnHandler >> handleEvent: anEvent [
	| aWidgetElement |
	
	aWidgetElement := anEvent currentTarget.
	
	anEvent selectedDo: [ :anInterval |
		| selectedObject |
		selectedObject := aWidgetElement viewModel itemAt: anInterval first.
		aWidgetElement phlow spawnObject: 
			(self transformedValueFrom: selectedObject selection: anInterval).
		aWidgetElement fireEvent: (GLMBlocObjectToSelect new 
			toSelect: (self transformedValueFrom: selectedObject selection: anInterval)) ]
]
