Class {
	#name : #GtPhlowToolContainerVolumeRequest,
	#superclass : #BrRequest,
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #initialization }
GtPhlowToolContainerVolumeRequest >> responseClass [
	^ GtPhlowToolVolumeChanged
]
