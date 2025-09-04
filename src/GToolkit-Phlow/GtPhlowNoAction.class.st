Class {
	#name : #GtPhlowNoAction,
	#superclass : #GtPhlowAction,
	#category : #'GToolkit-Phlow-! Actions'
}

{ #category : #converting }
GtPhlowNoAction >> asElement: aBlock withHostElement: aTargetElement [
	"do nothing"
]

{ #category : #acessing }
GtPhlowNoAction >> description [
	"Return an action description.
	I am a convenience method to easily inspect and describe actions.
	I am not supposed to be used in a production code."

	<return: #String or: #BlText>
	^ 'no action: {1}' format: {self definingSelector}
]

{ #category : #'as yet unclassified' }
GtPhlowNoAction >> label [
	^ nil
]
