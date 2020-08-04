Class {
	#name : #GtPhlowToolVolumeRequest,
	#superclass : #BrRequest,
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #initialization }
GtPhlowToolVolumeRequest >> responseClass [
	^ GtPhlowToolVolumeChanged
]
