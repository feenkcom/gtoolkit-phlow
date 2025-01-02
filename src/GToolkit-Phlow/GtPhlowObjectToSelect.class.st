Class {
	#name : #GtPhlowObjectToSelect,
	#superclass : #GtPhlowObjectEvent,
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #sending }
GtPhlowObjectToSelect >> sendTo: anObject [
	anObject objectToSelectEvent: self
]
