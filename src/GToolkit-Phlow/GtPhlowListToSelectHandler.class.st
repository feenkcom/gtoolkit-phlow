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
			aSelection isNotEmpty
				ifTrue: [ 
					currentWidgetElement := anEvent currentTarget.
					selectedObject := currentWidgetElement selectionCallback
							value: aSelection indices.

					self transformation
						select: selectedObject
						indices: aSelection indices
						from: currentWidgetElement
						shouldShowSpace: false ] ]
]

{ #category : #'api - event managing' }
GtPhlowListToSelectHandler >> selectionDoubleClickedEvent: anEvent [
	anEvent selection
		ifNotEmpty: [ :anInterval | 
			| currentWidgetElement selectedObject shouldShowSpace |
			currentWidgetElement := anEvent currentTarget.
			selectedObject := currentWidgetElement selectionCallback value: anInterval.
			shouldShowSpace := self shouldShowSelectionInNewSpaceFor: anEvent.

			self transformation
				spawn: selectedObject
				indices: anInterval
				from: currentWidgetElement
				shouldShowSpace: shouldShowSpace ]
]

{ #category : #'api - event managing' }
GtPhlowListToSelectHandler >> wantsEvent: anEvent [
	^ self eventClasses includes: anEvent class
]
