"
I am a ${class:BrWish}$.
I inform ${class:GtPhlowToolAbstractDetailModel}$ models about new new ${method:GtPhlowToolDetailWish>>#level|label=#selector}$ that a user wish to use.
!! Usage
Users can use ${class:TGtPhlowToolDetailAdjustable}$ that defines a predefined levels of information details.
!! Example
The following example changes an element background color on information level changes. I am fired each time users click on the example buttons: ${example:GtPhlowToolDetailModelExamples>>#containerWithToolElementWithDetailLook_Showcase|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #GtPhlowToolDetailWish,
	#superclass : #BrWish,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-Phlow-Tool - Events'
}

{ #category : #'instance creation' }
GtPhlowToolDetailWish class >> beDetailedLevel [
	^ self new level: GtPhlowToolDetailState detailedName
]

{ #category : #'instance creation' }
GtPhlowToolDetailWish class >> beLevel: aNamedVolume [
	^ self new level: aNamedVolume
]

{ #category : #'instance creation' }
GtPhlowToolDetailWish class >> beNormalLevel [
	^ self new level: GtPhlowToolDetailState normalName
]

{ #category : #'instance creation' }
GtPhlowToolDetailWish class >> beUndefinedLevel [
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
