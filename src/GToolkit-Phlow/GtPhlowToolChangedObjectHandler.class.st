Class {
	#name : #GtPhlowToolChangedObjectHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'element',
		'action'
	],
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #comparing }
GtPhlowToolChangedObjectHandler >> = anotherObject [
	^ self species == anotherObject species and: [ 
			self element = anotherObject element ]
]

{ #category : #'private - accessing' }
GtPhlowToolChangedObjectHandler >> action [
	<return: #MessageSend>
	^ action
]

{ #category : #'private - accessing' }
GtPhlowToolChangedObjectHandler >> element [
	<return: #BlElement>
	^ element
]

{ #category : #'api - accessing' }
GtPhlowToolChangedObjectHandler >> eventsToHandle [
	^ Array 
		with: BlElementAddedToSceneGraphEvent
]

{ #category : #'api - event managing' }
GtPhlowToolChangedObjectHandler >> handleEvent: anEvent [
	| aWish |
	aWish := GtPhlowToolChangedObjectWish new.
	self element fireEvent: aWish.
	aWish hasObject ifFalse: [ ^ self ].
	self action value: aWish object.
]

{ #category : #comparing }
GtPhlowToolChangedObjectHandler >> hash [
	^ self species hash bitXor: self element hash
]

{ #category : #initialization }
GtPhlowToolChangedObjectHandler >> initialize [
	super initialize.
	action := [ :anObject | "do nothing" ].
]

{ #category : #'api - accessing' }
GtPhlowToolChangedObjectHandler >> onChangeSend: aSymbol to: aReceiver [
	action := MessageSend receiver: aReceiver selector: aSymbol
]

{ #category : #'api - hooks' }
GtPhlowToolChangedObjectHandler >> onInstalledIn: anElement [

	element ifNotNil: [ element removeEventHandler: self ].
	element := anElement.
]

{ #category : #'api - event managing' }
GtPhlowToolChangedObjectHandler >> wantsEvent: anEvent [
	^ anEvent class == BlElementAddedToSceneGraphEvent
]
