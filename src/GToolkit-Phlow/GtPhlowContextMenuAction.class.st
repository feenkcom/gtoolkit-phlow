Class {
	#name : #GtPhlowContextMenuAction,
	#superclass : #Object,
	#instVars : [
		'name',
		'action'
	],
	#category : #'GToolkit-Phlow-Support - Context Menu'
}

{ #category : #'instance creation' }
GtPhlowContextMenuAction class >> named: aString action: aBlock [
	^ self new
		name: aString;
		action: aBlock
]

{ #category : #accessing }
GtPhlowContextMenuAction >> action [
	^ action
]

{ #category : #accessing }
GtPhlowContextMenuAction >> action: aBlock [ 
	action := aBlock
]

{ #category : #converting }
GtPhlowContextMenuAction >> asAssociation [
	^ name -> action
]

{ #category : #accessing }
GtPhlowContextMenuAction >> name [
	^ name
]

{ #category : #accessing }
GtPhlowContextMenuAction >> name: aString [ 
	name := aString
]
