Class {
	#name : #GtPhlowToolObjectChangeHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #comparing }
GtPhlowToolObjectChangeHandler >> = anotherObject [
	^ self species == anotherObject species and: [ 
			self element = anotherObject element ]
]

{ #category : #'private - accessing' }
GtPhlowToolObjectChangeHandler >> element [
	<return: #BlElement>
	^ element
]

{ #category : #'api - accessing' }
GtPhlowToolObjectChangeHandler >> eventsToHandle [
	^ Array 
		with: GtPhlowToolObjecChangeWish
		with: GtPhlowToolChangedObjectWish
]

{ #category : #'api - event managing' }
GtPhlowToolObjectChangeHandler >> handleEvent: anEvent [
	anEvent acceptPhlowHandler: self.
]

{ #category : #comparing }
GtPhlowToolObjectChangeHandler >> hash [
	^ self species hash bitXor: self element hash
]

{ #category : #'api - hooks' }
GtPhlowToolObjectChangeHandler >> onInstalledIn: anElement [

	element ifNotNil: [ element removeEventHandler: self ].
	element := anElement.
]

{ #category : #visiting }
GtPhlowToolObjectChangeHandler >> visitToolChangedObjectWish: aWish [
	| aWeak anObject |
	aWeak := self element userData 
		at: #compositeToolObjectChange
		ifAbsent: [ ^ self ].
	(aWeak at: 2) ifTrue: [ 
		aWish object: nil. ^ self ].
	anObject := aWeak at: 1.
	anObject ifNil: [ ^ self ].
	aWish object: anObject.
]

{ #category : #visiting }
GtPhlowToolObjectChangeHandler >> visitToolObjectChangeWish: aWish [
	| aWeak |
	aWeak := (WeakArray new: 2)
		at: 1 put: aWish object;
		at: 2 put: aWish object isNil;
		yourself.
	self element userData 
		at: #compositeToolObjectChange
		put: aWeak
]

{ #category : #'api - event managing' }
GtPhlowToolObjectChangeHandler >> wantsEvent: anEvent [
	^ anEvent class == GtPhlowToolObjecChangeWish or: [ 
			anEvent class == GtPhlowToolChangedObjectWish ]
]
