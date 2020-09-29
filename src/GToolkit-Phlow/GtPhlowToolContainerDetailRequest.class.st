Class {
	#name : #GtPhlowToolContainerDetailRequest,
	#superclass : #BrRequest,
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #initialization }
GtPhlowToolContainerDetailRequest >> responseClass [
	^ GtPhlowToolDetailChanged
]
