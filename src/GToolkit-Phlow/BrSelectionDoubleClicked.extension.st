Extension { #name : 'BrSelectionDoubleClicked' }

{ #category : '*GToolkit-Phlow' }
BrSelectionDoubleClicked >> acceptPhlowHandler: aHandler [
	^ aHandler selectionDoubleClickedEvent: self
]
