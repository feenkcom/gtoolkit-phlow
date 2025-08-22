"
I am {{gtMethod:BlElement>>#fireEvent:|label=fired}} when a user wish to update a whole tool, e.g., {{gtClass:GtInspector}}. Element tools should use {{gtClass:GtPhlowToolUpdateEventHandler}} to handle me properly update wish events.


"
Class {
	#name : #GtPhlowToolUpdateWish,
	#superclass : #BrWish,
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #sending }
GtPhlowToolUpdateWish >> sendTo: anObject [ 
	^ anObject phlowToolUpdateWish: self
]
