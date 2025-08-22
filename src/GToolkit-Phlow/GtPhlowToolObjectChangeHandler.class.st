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
	#superclass : #BlCustomEventHandler,
	#category : #'GToolkit-Phlow-Tool - Object Changer'
}

{ #category : #'api - accessing' }
GtPhlowToolObjectChangeHandler >> eventsToHandle [
	^ {GtPhlowToolObjectChangeWish.
		GtPhlowToolChangedObjectWish}
]

{ #category : #'api - event managing' }
GtPhlowToolObjectChangeHandler >> phlowToolChangedObjectWish: aWish [
	| aWeak anObject |
	aWish consumed: true.
	aWeak := aWish currentTarget userData 
		at: GtPhlowToolObjectChangeHandler name
		ifAbsent: [ ^ self ].
	(aWeak at: 2) ifTrue: [ 
		aWish object: nil. ^ self ].
	anObject := aWeak at: 1.
	anObject ifNil: [ ^ self ].
	aWish object: anObject.
]

{ #category : #'api - event managing' }
GtPhlowToolObjectChangeHandler >> phlowToolObjectChangeWish: aWish [
	| aWeak |
	aWish consumed: true.
	aWeak := (WeakArray new: 2)
			at: 1 put: aWish object;
			at: 2 put: aWish object isNil;
			yourself.
	aWish currentTarget userData at: GtPhlowToolObjectChangeHandler name put: aWeak.
	
	"Let's update phlow tool too.
	Note: phlow tools ignore the #object: calls by default."
	aWish currentTarget phlow isTool ifFalse: [ ^ self ].
	aWish currentTarget phlow entity object: aWish object.
]
