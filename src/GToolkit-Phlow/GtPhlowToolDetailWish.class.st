Class {
	#name : #GtPhlowToolDetailWish,
	#superclass : #BrWish,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #'instance creation' }
GtPhlowToolDetailWish class >> beDetailedTool [
	^ self new level: GtPhlowToolDetailState detailedName
]

{ #category : #'instance creation' }
GtPhlowToolDetailWish class >> beLevel: aNamedVolume [
	^ self new level: aNamedVolume
]

{ #category : #'instance creation' }
GtPhlowToolDetailWish class >> beNormalTool [
	^ self new level: GtPhlowToolDetailState normalName
]

{ #category : #'instance creation' }
GtPhlowToolDetailWish class >> beUndefinedTool [
	^ self new level: GtPhlowToolDetailState undefinedName
]

{ #category : #accessing }
GtPhlowToolDetailWish >> dimension [
	<return: #Symbol>
	self 
		deprecated: 'Use #level instead' 
		transformWith: '`@receiver dimension' -> '`@receiver level'.
	^ self level
]

{ #category : #accessing }
GtPhlowToolDetailWish >> dimension: aSymbol [

	self 
		deprecated: 'Use #level: instead' 
		transformWith: '`@receiver dimension: `@arg' -> '`@receiver level: `@arg'.
	self level: aSymbol
]

{ #category : #initialization }
GtPhlowToolDetailWish >> initialize [
	super initialize.
	
	level := GtPhlowToolDetailState normalName.
]

{ #category : #accessing }
GtPhlowToolDetailWish >> level [
	<return: #Symbol>
	^ level
]

{ #category : #accessing }
GtPhlowToolDetailWish >> level: aSymbol [
	level := aSymbol.
]

{ #category : #printing }
GtPhlowToolDetailWish >> printOn: aStream [
	aStream
		nextPutAll: 'Tool Detail Wish: ';
		print: self level
]
