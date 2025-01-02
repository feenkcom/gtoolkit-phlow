Class {
	#name : #GtPhlowObjectToDeselect,
	#superclass : #GtPhlowObjectEvent,
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #sending }
GtPhlowObjectToDeselect >> sendTo: anObject [
	anObject objectToDeselectEvent: self
]
