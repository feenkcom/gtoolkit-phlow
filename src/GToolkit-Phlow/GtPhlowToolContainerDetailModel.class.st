Class {
	#name : #GtPhlowToolContainerDetailModel,
	#superclass : #GtPhlowToolAbstractDetailModel,
	#category : #'GToolkit-Phlow-Tool - Model'
}

{ #category : #printing }
GtPhlowToolContainerDetailModel class >> modelName [
	^ 'Tool Container Volume'
]

{ #category : #defaults }
GtPhlowToolContainerDetailModel >> defaultLevel [
	^ GtPhlowToolDetailState undefinedName
]

{ #category : #initialization }
GtPhlowToolContainerDetailModel >> initializeListeners [
	super initializeListeners.
	self
		when: GtPhlowToolContainerDetailRequest
		reply: [ :aResponse :aRequest | self volumeResponse: aResponse for: aRequest ]
]

{ #category : #'private - event handling' }
GtPhlowToolContainerDetailModel >> volumeResponse: aResponse for: aRequest [
	self isUndefined
		ifTrue: [ aRequest consumed: false ]
		ifFalse: [ aResponse level: self level ].
	^ aResponse
]
