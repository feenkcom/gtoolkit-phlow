Class {
	#name : #GtPhlowObjectToSelect,
	#superclass : #GtPhlowObjectEvent,
	#traits : 'TGtPhlowWithSelectionState',
	#classTraits : 'TGtPhlowWithSelectionState classTrait',
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #sending }
GtPhlowObjectToSelect >> sendTo: anObject [
	anObject objectToSelectEvent: self
]
