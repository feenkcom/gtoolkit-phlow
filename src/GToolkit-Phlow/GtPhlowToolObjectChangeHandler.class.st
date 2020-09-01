"
I am used by ${class:GtPhlowCompositeTool}$ to store and share objects that should be displayed by composed sub-tools. 
!! Listening to Object Change Requests
I receive requests to store new objects by listening to ${class:GtPhlowToolObjectChangeWish}$.
I store objects in a weak array to omit undesired memory leaks.
For more details, see ${method:GtPhlowToolObjectChangeHandler>>#visitToolObjectChangeWish:|label=#selector}$.
!! Providing Objects to Display
${class:GtPhlowTool}$ widgets may install ${class:GtPhlowToolChangedObjectHandler}$ to be informed about stored objects that should be displayed. I listen to ${class:GtPhlowToolChangedObjectWish}$ to provide such information. See the ${class:GtPhlowToolChangedObjectHandler}$ for more details.
!! Example
See a complete example in the ${class:GtPhlowCompositeTool}$ class comment.
"
Class {
	#name : #GtPhlowToolObjectChangeHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Phlow-Tool - Object Changer'
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
		with: GtPhlowToolObjectChangeWish
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
	^ anEvent class == GtPhlowToolObjectChangeWish or: [ 
			anEvent class == GtPhlowToolChangedObjectWish ]
]
