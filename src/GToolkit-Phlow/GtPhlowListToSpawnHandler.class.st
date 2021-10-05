Class {
	#name : #GtPhlowListToSpawnHandler,
	#superclass : #GtPhlowListHandler,
	#category : 'GToolkit-Phlow-Events'
}

{ #category : #'private - accessing' }
GtPhlowListToSpawnHandler >> eventClass [
	^ BrSelectionChanged
]

{ #category : #'api - accessing' }
GtPhlowListToSpawnHandler >> eventsToHandle [
	"I return a collection of element types I may be interested in"
	<return: #Collection of: #'BlEvent class'>	

	^ Array with: self eventClass
]

{ #category : #'api - event managing' }
GtPhlowListToSpawnHandler >> handleEvent: anEvent [
	| aWidgetElement |
	
	aWidgetElement := anEvent currentTarget.
	
	anEvent selectedDo: [ :anInterval |
		| selectedObject |
		selectedObject := aWidgetElement viewModel itemAt: anInterval first.
		self transformation 
			spawn: selectedObject
			indices: anInterval
			from: aWidgetElement. ]
]

{ #category : #'api - event managing' }
GtPhlowListToSpawnHandler >> wantsEvent: anEvent [
	^ self eventClass = anEvent class
]
