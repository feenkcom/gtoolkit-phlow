"
I am a ${class:GtPhlowToolAbstractDetailModel}$.
I define what level of detail that an associated ${class:BlElement}$ (a tool) should display about a given subject, e.g., about a ${class:Class}$.
!! How I Work
I am attached to a ${class:BlElement|label=tool}$ using ${method:BlElement>>#addInteractiveModelState:}$. There can be a parent ${class:BlElement}$ that knows which level of details should be currently used. Such parent should have ${class:GtPhlowToolContainerDetailModel}$ attached. Each time I am added to a ${class:BlSpace}$ (to a parent), I fire ${class:GtPhlowToolContainerDetailRequest}$ to figure out a current tool level of detail that should be used. ${class:BlElement}$
!! Example
The following example shows how a tool obtains a detailed level response from a parent element (container): ${example:GtPhlowToolDetailModelExamples>>#containerElementDetailedResponse}$
"
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
