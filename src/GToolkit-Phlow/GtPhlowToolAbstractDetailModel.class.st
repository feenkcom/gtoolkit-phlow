Class {
	#name : #GtPhlowToolAbstractDetailModel,
	#superclass : #BrStateModel,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-Phlow-Tool - Model'
}

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> beDetailedTool [
	self level: GtPhlowToolDetailState detailedName
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> beNormalTool [
	self level: GtPhlowToolDetailState normalName
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> beUndefinedTool [
	self level: GtPhlowToolDetailState undefinedName
]

{ #category : #defaults }
GtPhlowToolAbstractDetailModel >> defaultLevel [
	^ self subclassResponsibility
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> dimension [
	<return: #Symbol>
	self 
		deprecated: 'Use #level instead' 
		transformWith: '`@receiver dimension' -> '`@receiver level'.
	^ self level
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> dimension: aSymbol [

	self 
		deprecated: 'Use #level: instead' 
		transformWith: '`@receiver dimension: `@arg' -> '`@receiver level: `@arg'.
	self level: aSymbol
]

{ #category : #initialization }
GtPhlowToolAbstractDetailModel >> initialize [
	super initialize.

	"we use symbols instead of state object to let users easier define their own custom dimension for customs widgets"
	level := self defaultLevel.
]

{ #category : #initialization }
GtPhlowToolAbstractDetailModel >> initializeListeners [
	super initializeListeners.
	self
		when: GtPhlowToolDetailRequest
		reply: [ :aResponse | aResponse dimension: self dimension ].
	self
		when: GtPhlowToolDetailWish
		do: [ :aWish | self level: aWish level ]
]

{ #category : #testing }
GtPhlowToolAbstractDetailModel >> isDetailed [
	^ self dimension = GtPhlowToolDetailState detailedName
]

{ #category : #testing }
GtPhlowToolAbstractDetailModel >> isUndefined [
	^ self level = GtPhlowToolDetailState undefinedName
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> level [
	<return: #Symbol>
	^ level
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> level: aSymbol [

	self level = aSymbol
		ifTrue: [ ^ self ].

	level := aSymbol.
	self notifyStateChanged: level
]

{ #category : #printing }
GtPhlowToolAbstractDetailModel >> printOn: aStream [
	aStream
		nextPutAll: self modelName;
		nextPutAll: '(';
		nextPutAll: self level asString;
		nextPutAll: ')'
]

{ #category : #'state - accessing' }
GtPhlowToolAbstractDetailModel >> stateChangedEventClass [
	^ GtPhlowToolDetailChanged
]

{ #category : #'state - streaming' }
GtPhlowToolAbstractDetailModel >> streamStateIn: aBrInteractionStatesMapping [
	aBrInteractionStatesMapping
		addState: (GtPhlowToolDetailState new level: self level)
		model: self
]
