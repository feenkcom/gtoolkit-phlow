Class {
	#name : #GtPhlowPathNodeIdentifier,
	#superclass : #GtPhlowNodeIdentifier,
	#instVars : [
		'nodeIndexPath'
	],
	#category : #'GToolkit-Phlow-Support - Selection'
}

{ #category : #comparing }
GtPhlowPathNodeIdentifier >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self nodeIndexPath = anObject nodeIndexPath
]

{ #category : #converting }
GtPhlowPathNodeIdentifier >> asRemoteNodeIdentifier [
	^ GtRemotePhlowNodeIdentifier forTreePath: self nodeIndexPath
]

{ #category : #printing }
GtPhlowPathNodeIdentifier >> descriptionOn: aStream [
	aStream print: self nodeIndexPath
]

{ #category : #comparing }
GtPhlowPathNodeIdentifier >> hash [
	^ self nodeIndexPath hash
]

{ #category : #accessing }
GtPhlowPathNodeIdentifier >> nodeIndexPath [
	^ nodeIndexPath
]

{ #category : #accessing }
GtPhlowPathNodeIdentifier >> nodeIndexPath: anArray [
	nodeIndexPath := anArray
]
