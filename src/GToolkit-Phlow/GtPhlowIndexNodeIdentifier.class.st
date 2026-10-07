Class {
	#name : #GtPhlowIndexNodeIdentifier,
	#superclass : #GtPhlowNodeIdentifier,
	#instVars : [
		'nodeIndex'
	],
	#category : #'GToolkit-Phlow-Support - Selection'
}

{ #category : #comparing }
GtPhlowIndexNodeIdentifier >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self nodeIndex = anObject nodeIndex
]

{ #category : #converting }
GtPhlowIndexNodeIdentifier >> asRemoteNodeIdentifier [
	^ GtRemotePhlowNodeIdentifier forListIndex: self nodeIndex
]

{ #category : #printing }
GtPhlowIndexNodeIdentifier >> descriptionOn: aStream [
	aStream print: self nodeIndex
]

{ #category : #comparing }
GtPhlowIndexNodeIdentifier >> hash [
	^ self nodeIndex hash
]

{ #category : #accessing }
GtPhlowIndexNodeIdentifier >> nodeIndex [
	^ nodeIndex
]

{ #category : #accessing }
GtPhlowIndexNodeIdentifier >> nodeIndex: anInteger [
	nodeIndex := anInteger
]

{ #category : #accessing }
GtPhlowIndexNodeIdentifier >> nodeIndexPath [
	^ { self nodeIndex }
]
