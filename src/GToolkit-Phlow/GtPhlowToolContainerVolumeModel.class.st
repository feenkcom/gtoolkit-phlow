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
		reply: [ :aResponse :aRequest | self volumeResponse: aResponse for: aRequest ]
]

{ #category : #testing }
GtPhlowToolContainerVolumeModel >> isUndefined [
	^ self dimension = GtPhlowToolVolumeState undefinedName
]

{ #category : #'private - event handling' }
GtPhlowToolContainerVolumeModel >> volumeResponse: aResponse for: aRequest [
	self isUndefined 
		ifTrue: [ aRequest consumed: false ]
		ifFalse: [ aResponse dimension: self dimension ].
	^ aResponse
]
