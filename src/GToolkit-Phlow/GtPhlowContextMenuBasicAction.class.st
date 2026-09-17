Class {
	#name : #GtPhlowContextMenuBasicAction,
	#superclass : #Object,
	#instVars : [
		'filter'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #testing }
GtPhlowContextMenuBasicAction class >> isAbstract [
	^ self name = #GtPhlowContextMenuBasicAction
]

{ #category : #converting }
GtPhlowContextMenuBasicAction >> collectInvidualActionsOn: aCollection forElement: anElement item: anObject index: anIndex [
	self subclassResponsibility
]

{ #category : #accessing }
GtPhlowContextMenuBasicAction >> filter [

	^ filter
]

{ #category : #accessing }
GtPhlowContextMenuBasicAction >> filter: anObject [

	filter := anObject
]

{ #category : #converting }
GtPhlowContextMenuBasicAction >> respondsToItem: anItem [
	^ self filter ifNil: [ true ] ifNotNil: [ :aFilter | aFilter value: anItem ]
]

{ #category : #converting }
GtPhlowContextMenuBasicAction >> toMenuItemOn: anItem index: anItemIndex  element: anotherElement [
	self subclassResponsibility
]
