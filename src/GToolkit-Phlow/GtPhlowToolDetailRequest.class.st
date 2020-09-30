"
I am a ${class:BrRequest}$.
I am used to obtain a level of information detail value.
See ${class:GtPhlowToolAbstractDetailModel}$ for more details.

"
Class {
	#name : #GtPhlowToolDetailRequest,
	#superclass : #BrRequest,
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #initialization }
GtPhlowToolDetailRequest >> responseClass [
	^ GtPhlowToolDetailChanged
]
