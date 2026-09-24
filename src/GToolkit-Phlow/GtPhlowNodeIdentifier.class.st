Class {
	#name : #GtPhlowNodeIdentifier,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Support - Selection'
}

{ #category : #'instance creation' }
GtPhlowNodeIdentifier class >> forListIndex: anInteger [
	^ GtPhlowIndexNodeIdentifier new
		nodeIndex: anInteger
]

{ #category : #'instance creation' }
GtPhlowNodeIdentifier class >> forTreePath: anArray [
	^ GtPhlowPathNodeIdentifier new
		nodeIndexPath: anArray
]

{ #category : #printing }
GtPhlowNodeIdentifier >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #printing }
GtPhlowNodeIdentifier >> descriptionOn: aStream [
	self subclassResponsibility
]

{ #category : #printing }
GtPhlowNodeIdentifier >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		self descriptionOn: aStream ]
]
