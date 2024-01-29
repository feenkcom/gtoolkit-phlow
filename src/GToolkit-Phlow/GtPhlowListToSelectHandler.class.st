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
		selectionDo: [ :aSelection | 
			| currentWidgetElement selectedObject |
		
			currentWidgetElement := anEvent currentTarget.
			selectedObject := currentWidgetElement selectionCallback 
				value: aSelection indices.

			self transformation
				select: selectedObject
				indices: aSelection indices
				from: currentWidgetElement ]
]

{ #category : #'api - event managing' }
GtPhlowListToSelectHandler >> selectionDoubleClickedEvent: anEvent [
	
	anEvent selection ifNotEmpty: [ :anInterval |
		| currentWidgetElement selectedObject |
		
		currentWidgetElement := anEvent currentTarget.
		selectedObject := currentWidgetElement selectionCallback 
			value: anInterval.
		
		self transformation 
			spawn: selectedObject
			indices: anInterval
			from: currentWidgetElement ]
]

{ #category : #'api - event managing' }
GtPhlowListToSelectHandler >> wantsEvent: anEvent [
	^ self eventClasses includes: anEvent class
]
