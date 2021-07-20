Extension { #name : 'BrSelectionChanged' }

{ #category : '*GToolkit-Phlow' }
BrSelectionChanged >> acceptPhlowHandler: aHandler [
	^ aHandler selectionChangedEvent: self
]
