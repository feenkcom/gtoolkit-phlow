Class {
	#name : #GtPhlowToolDetailModel,
	#superclass : #GtPhlowToolAbstractDetailModel,
	#category : #'GToolkit-Phlow-Tool - Model'
}

{ #category : #printing }
GtPhlowToolDetailModel class >> modelName [
	^ 'Tool Volume'
]

{ #category : #defaults }
GtPhlowToolDetailModel >> defaultLevel [
	^ GtPhlowToolDetailState normalName
]

{ #category : #initialization }
GtPhlowToolDetailModel >> initializeListeners [
	super initializeListeners.
	
	self 
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | self onAddedToSceneGraph ]
]

{ #category : #'private - event handling' }
GtPhlowToolDetailModel >> onAddedToSceneGraph [
	self updateVolumeFromToolContainer.
]

{ #category : #'private - updating' }
GtPhlowToolDetailModel >> updateVolumeFromToolContainer [
	| aResponse |
	aResponse := self request: GtPhlowToolContainerDetailRequest new.
	aResponse isUndefined
		ifTrue: [ ^ self ].
	self level: aResponse level
]
