Class {
	#name : #GtPhlowToolDetailRequest,
	#superclass : #BrRequest,
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #initialization }
GtPhlowToolDetailRequest >> responseClass [
	^ GtPhlowToolDetailChanged
]
