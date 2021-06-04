"
I am a {{gtClass:BrStateChangedEvent}}.
I am used to inform about a level of information detail value.
See {{gtClass:GtPhlowToolAbstractDetailModel}} for more details.


"
Class {
	#name : #GtPhlowToolDetailChanged,
	#superclass : #BrStateChangedEvent,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #accessing }
GtPhlowToolDetailChanged >> dimension [
	<return: #Symbol>
	self 
		deprecated: 'Use #level instead' 
		transformWith: '`@receiver dimension' -> '`@receiver level'.
	^ self level
]

{ #category : #accessing }
GtPhlowToolDetailChanged >> dimension: aSymbol [

	self 
		deprecated: 'Use #level: instead' 
		transformWith: '`@receiver dimension: `@arg' -> '`@receiver level: `@arg'.
	self level: aSymbol
]

{ #category : #initialization }
GtPhlowToolDetailChanged >> initialize [
	super initialize.
	
	level := GtPhlowToolDetailState undefinedName.
]

{ #category : #testing }
GtPhlowToolDetailChanged >> isUndefined [
	^ self level = GtPhlowToolDetailState undefinedName
]

{ #category : #accessing }
GtPhlowToolDetailChanged >> level [
	<return: #Symbol>
	^ level
]

{ #category : #accessing }
GtPhlowToolDetailChanged >> level: aSymbol [
	level := aSymbol.
]

{ #category : #printing }
GtPhlowToolDetailChanged >> printOn: aStream [
	aStream
		nextPutAll: 'Tool Volume Changed: ';
		print: self dimension
]

{ #category : #accessing }
GtPhlowToolDetailChanged >> state: anObject [
	"Override me to properly set the given state"

	self level: anObject
]
