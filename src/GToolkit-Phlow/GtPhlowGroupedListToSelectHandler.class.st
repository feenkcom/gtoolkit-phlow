Class {
	#name : #GtPhlowGroupedListToSelectHandler,
	#superclass : #GtPhlowListToSelectHandler,
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #accessing }
GtPhlowGroupedListToSelectHandler >> selectionChangedEvent: anEvent [

	anEvent selectedDo: [ :theIndices |
		| aWidgetElement aSelectedObject |

		aWidgetElement := anEvent currentTarget.
		aSelectedObject := aWidgetElement viewModel entityAt: theIndices first.
		
		self transformation 
			select: aSelectedObject
			indices: theIndices
			from: aWidgetElement ]
]

{ #category : #accessing }
GtPhlowGroupedListToSelectHandler >> selectionDoubleClickedEvent: anEvent [
	
	anEvent selection ifNotEmpty: [ :anInterval |
		| aWidgetElement aSelectedObject |
	
		aWidgetElement := anEvent currentTarget.
			
		aSelectedObject := aWidgetElement viewModel entityAt: anInterval first.
		self transformation 
			spawn: aSelectedObject
			indices: anInterval
			from: aWidgetElement ]
]
