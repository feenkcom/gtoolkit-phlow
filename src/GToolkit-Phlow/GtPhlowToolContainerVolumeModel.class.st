Class {
	#name : #GtPhlowToolContainerVolumeModel,
	#superclass : #GtPhlowToolVolumeCommonModel,
	#category : #'GToolkit-Phlow-Tool - Model'
}

{ #category : #printing }
GtPhlowToolContainerVolumeModel class >> modelName [
	^ 'Tool Container Volume'
]

{ #category : #defaults }
GtPhlowToolContainerVolumeModel >> defaultDimension [
	^ GtPhlowToolVolumeState undefinedName
]

{ #category : #initialization }
GtPhlowToolContainerVolumeModel >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtPhlowToolContainerVolumeRequest 
		reply: [ :aResponse | aResponse dimension: self dimension ].
]
