Class {
	#name : #GtPhlowListToSelectHandler,
	#superclass : #GtPhlowListHandler,
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #'private - accessing' }
GtPhlowListToSelectHandler >> eventClasses [
	^ { BrSelectionChanged . BrSelectionDoubleClicked }
]

{ #category : #'api - accessing' }
GtPhlowListToSelectHandler >> eventsToHandle [
	"I return a collection of element types I may be interested in"
	<return: #Collection of: #'BlEvent class'>	

	^ self eventClasses
]

{ #category : #'api - event managing' }
GtPhlowListToSelectHandler >> handleEvent: anEvent [
	anEvent acceptPhlowHandler: self
]

{ #category : #'api - event managing' }
GtPhlowListToSelectHandler >> selectionChangedEvent: anEvent [
	anEvent
		selectedDo: [ :theIndices | 
			| aWidgetElement aSelectedObject |
			aWidgetElement := anEvent currentTarget.
			aSelectedObject := aWidgetElement selectionCallback value: theIndices.

			self transformation
				select: aSelectedObject
				indices: theIndices
				from: aWidgetElement ]
]

{ #category : #'api - event managing' }
GtPhlowListToSelectHandler >> selectionDoubleClickedEvent: anEvent [
	
	anEvent selection ifNotEmpty: [ :anInterval |
		| aWidgetElement aSelectedObject |
	
		aWidgetElement := anEvent currentTarget.
			
		aSelectedObject := aWidgetElement viewModel itemAt: anInterval first.
		self transformation 
			spawn: aSelectedObject
			indices: anInterval
			from: aWidgetElement ]
]

{ #category : #'api - event managing' }
GtPhlowListToSelectHandler >> wantsEvent: anEvent [
	^ self eventClasses includes: anEvent class
]
