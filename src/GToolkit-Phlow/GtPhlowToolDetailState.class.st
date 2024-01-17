"
I am a {{gtClass:BrInteractionState}}.
I define a level of information detail that says how {{gtClass:BlElement}} (tool) should be displayed, e.g., displaying a little or more information to users.
See {{gtClass:GtPhlowToolAbstractDetailModel}} for more details.


"
Class {
	#name : #GtPhlowToolDetailState,
	#superclass : #BlElementUniqueState,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #'instance creation' }
GtPhlowToolDetailState class >> detailed [
	^ self new level: self detailedName
]

{ #category : #accessing }
GtPhlowToolDetailState class >> detailedName [
	^ #detailed
]

{ #category : #accessing }
GtPhlowToolDetailState class >> getLevelOf: anElement [
	^ anElement states
		stateLike: self normal
		ifFound: [ :aLevelState | aLevelState ]
		ifNone: [ self normal ]
]

{ #category : #'instance creation' }
GtPhlowToolDetailState class >> level: aNamedLevel [
	^ self new level: aNamedLevel
]

{ #category : #'instance creation' }
GtPhlowToolDetailState class >> normal [
	^ self new level: self normalName
]

{ #category : #accessing }
GtPhlowToolDetailState class >> normalName [
	^ #normal
]

{ #category : #comparing }
GtPhlowToolDetailState >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ level = anObject level
]

{ #category : #comparing }
GtPhlowToolDetailState >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ level hash
]

{ #category : #initialization }
GtPhlowToolDetailState >> initialize [
	super initialize.

	level := self class normalName
]

{ #category : #accessing }
GtPhlowToolDetailState >> level [
	<return: #Symbol>
	^ level
]

{ #category : #accessing }
GtPhlowToolDetailState >> level: aSymbol [
	level := aSymbol.
]

{ #category : #enumerating }
GtPhlowToolDetailState >> optionalOnAddedTo: anElement [
	anElement dispatchEvent: (GtPhlowToolDetailChanged new element: anElement; level: self)
]

{ #category : #enumerating }
GtPhlowToolDetailState >> optionalOnRemovedFrom: anElement [
	anElement dispatchEvent: (GtPhlowToolDetailChanged new element: anElement; level: self class normal)
]

{ #category : #printing }
GtPhlowToolDetailState >> printOn: aStream [
	aStream nextPutAll: self level
]

{ #category : #accessing }
GtPhlowToolDetailState >> priority [
	^ UserPriority
]

{ #category : #accessing }
GtPhlowToolDetailState >> shouldPropagateToChildren [
	^ true
]
