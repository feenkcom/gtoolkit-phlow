Class {
	#name : #GtPhlowToolDetailPositionState,
	#superclass : #BlElementUniqueState,
	#instVars : [
		'position'
	],
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #accessing }
GtPhlowToolDetailPositionState class >> getPositionOf: anElement [
	^ anElement states
		stateLike: self left
		ifFound: [ :aLevelState | aLevelState ]
		ifNone: [ self left ]
]

{ #category : #'instance creation' }
GtPhlowToolDetailPositionState class >> left [
	^ self new position: self leftName
]

{ #category : #accessing }
GtPhlowToolDetailPositionState class >> leftName [
	^ #left
]

{ #category : #'instance creation' }
GtPhlowToolDetailPositionState class >> position: aNamedLevel [
	^ self new position: aNamedLevel
]

{ #category : #'instance creation' }
GtPhlowToolDetailPositionState class >> top [
	^ self new position: self topName
]

{ #category : #accessing }
GtPhlowToolDetailPositionState class >> topName [
	^ #top
]

{ #category : #comparing }
GtPhlowToolDetailPositionState >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ position = anObject position
]

{ #category : #comparing }
GtPhlowToolDetailPositionState >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ position hash
]

{ #category : #initialization }
GtPhlowToolDetailPositionState >> initialize [
	super initialize.

	position := self class leftName
]

{ #category : #enumerating }
GtPhlowToolDetailPositionState >> optionalOnAddedTo: anElement [
	anElement
		dispatchEvent: (GtPhlowToolDetailPositionChanged new
				element: anElement;
				position: self)
]

{ #category : #enumerating }
GtPhlowToolDetailPositionState >> optionalOnRemovedFrom: anElement [
	anElement
		dispatchEvent: (GtPhlowToolDetailPositionChanged new
				element: anElement;
				position: self class left)
]

{ #category : #accessing }
GtPhlowToolDetailPositionState >> position [
	<return: #Symbol>
	^ position
]

{ #category : #accessing }
GtPhlowToolDetailPositionState >> position: aSymbol [
	position := aSymbol.
]

{ #category : #printing }
GtPhlowToolDetailPositionState >> printOn: aStream [
	aStream nextPutAll: self position
]

{ #category : #accessing }
GtPhlowToolDetailPositionState >> priority [
	^ UserPriority
]

{ #category : #accessing }
GtPhlowToolDetailPositionState >> shouldPropagateToChildren [
	^ true
]
