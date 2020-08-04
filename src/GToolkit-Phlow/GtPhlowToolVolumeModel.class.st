Class {
	#name : #GtPhlowToolVolumeModel,
	#superclass : #GtPhlowToolVolumeCommonModel,
	#category : #'GToolkit-Phlow-Tool - Model'
}

{ #category : #printing }
GtPhlowToolVolumeModel class >> modelName [
	^ 'Tool Volume'
]

{ #category : #defaults }
GtPhlowToolVolumeModel >> defaultDimension [
	^ GtPhlowToolVolumeState normalName
]

{ #category : #initialization }
GtPhlowToolVolumeModel >> initializeListeners [
	super initializeListeners.
	
	self 
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | self onAddedToSceneGraph ]
]

{ #category : #'private - event handling' }
GtPhlowToolVolumeModel >> onAddedToSceneGraph [
	self updateVolumeFromToolContainer.
]

{ #category : #'private - updating' }
GtPhlowToolVolumeModel >> updateVolumeFromToolContainer [
	| aResponse |
	aResponse := self request: GtPhlowToolContainerVolumeRequest new.
	aResponse isUndefined ifTrue: [ ^ self ].
	
	self dimension: aResponse dimension.
]
