"
I am a {{gtClass:BrInteractionState}}.
I define a level of information detail that says how {{gtClass:BlElement}} (tool) should be displayed, e.g., displaying a little or more information to users.
See {{gtClass:GtPhlowToolAbstractDetailModel}} for more details.


"
Class {
	#name : #GtPhlowToolDetailState,
	#superclass : #BrInteractionState,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-Phlow-Tool - State'
}

{ #category : #'instance creation' }
GtPhlowToolDetailState class >> detailed [
	^ self new level: self detailedName
]

{ #category : #accessing }
GtPhlowToolDetailState class >> detailedName [
	^ #detailed
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

{ #category : #'instance creation' }
GtPhlowToolDetailState class >> undefined [
	^ self new dimension: self undefinedName
]

{ #category : #accessing }
GtPhlowToolDetailState class >> undefinedName [
	^ #undefined
]

{ #category : #'instance creation' }
GtPhlowToolDetailState class >> volume: aNamedLevel [
	self 
		deprecated: 'Use #level: instead' 
		transformWith: '`@receiver volume: `@arg' -> '`@receiver level: `@arg'.
	^ self level: aNamedLevel
]

{ #category : #comparing }
GtPhlowToolDetailState >> = anotherState [
	^ anotherState class = self class
		and: [ anotherState level = self level ]
]

{ #category : #accessing }
GtPhlowToolDetailState >> dimension [
	<return: #Symbol>
	self 
		deprecated: 'Use #level instead' 
		transformWith: '`@receiver dimension' -> '`@receiver level'.
	^ self level
]

{ #category : #accessing }
GtPhlowToolDetailState >> dimension: aSymbol [

	self 
		deprecated: 'Use #level: instead' 
		transformWith: '`@receiver dimension: `@arg' -> '`@receiver level: `@arg'.
	self level: aSymbol
]

{ #category : #comparing }
GtPhlowToolDetailState >> hash [
	^ self class hash bitXor: self level hash
]

{ #category : #initialization }
GtPhlowToolDetailState >> initialize [
	super initialize.

	level := self class normalName
]

{ #category : #testing }
GtPhlowToolDetailState >> isUndefined [
	^ self level = self class undefinedName
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

{ #category : #printing }
GtPhlowToolDetailState >> printOn: aStream [
	aStream
		nextPutAll: 'Tool Level State: ';
		print: self level
]
