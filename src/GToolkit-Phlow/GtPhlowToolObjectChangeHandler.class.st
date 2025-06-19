"
I am used by {{gtClass:GtPhlowCompositeTool}} to store and share objects that should be displayed by composed sub-tools. 
1. # Listening to Object Change Requests

I receive requests to store new objects by listening to {{gtClass:GtPhlowToolObjectChangeWish}}.
I store objects in a weak array to omit undesired memory leaks.
For more details, see {{gtMethod:GtPhlowToolObjectChangeHandler>>#visitToolObjectChangeWish:|label=#selector}}.
1. # Providing Objects to Display

{{gtClass:GtPhlowTool}} widgets may install {{gtClass:GtPhlowToolChangedObjectHandler}} to be informed about stored objects that should be displayed. I listen to {{gtClass:GtPhlowToolChangedObjectWish}} to provide such information. See the {{gtClass:GtPhlowToolChangedObjectHandler}} for more details.
1. # Example

See a complete example in the {{gtClass:GtPhlowCompositeTool}} class comment.


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
	aWish consumed: true.
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
	aWish consumed: true.
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
