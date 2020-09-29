"
I am an abstract class.
I implement common code to set a ${method:GtPhlowToolAbstractDetailModel>>#level|label=#selector}$ which is:
- a ${class:GtPhlowToolDetailState}$'s ${method:GtPhlowToolDetailState>>#level|label=#selector}$ value,
- a ${class:Symbol}$ value in order to define a custom values,
- a value that defines how a ${class:BlElement}$ (a tool) should be displayed, e.g., showing all information, and minimum information.
There are three predefined values that can be set by sending the following messages:
- ${method:GtPhlowToolAbstractDetailModel>>#beUndefinedLevel|label=#selector}$,
- ${method:GtPhlowToolAbstractDetailModel>>#beNormalLevel|label=#selector}$,
- ${method:GtPhlowToolAbstractDetailModel>>#beDetailedLevel|label=#selector}$.
See my ${class:GtPhlowToolAbstractDetailModel|expanded|show=#gtSubclassesFor:|height=100}$ for more details:
"
Class {
	#name : #GtPhlowToolAbstractDetailModel,
	#superclass : #BrStateModel,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-Phlow-Tool - Model'
}

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> beDetailedLevel [
	"A ${class:BlElement}$ (a tool) should display all details."
	self level: GtPhlowToolDetailState detailedName
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> beDetailedTool [
	self 
		deprecated: 'Use #beDetailedLevel instead' 
		transformWith: '`@receiver beDetailedTool' -> '`@receiver beDetailedLevel'.
	self beDetailedLevel
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> beNormalLevel [
	"A ${class:BlElement}$ (a tool) should display a common information (hidding some details)."
	self level: GtPhlowToolDetailState normalName
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> beNormalTool [
	self 
		deprecated: 'Use #beNormalLevel instead' 
		transformWith: '`@receiver beNormalTool' -> '`@receiver beNormalLevel'.
	self beNormalLevel
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> beUndefinedLevel [
	"Undefined level has a special meaning and is used internally.
	See ${class:GtPhlowToolContainerDetailModel}$ for more details."
	self level: GtPhlowToolDetailState undefinedName
]

{ #category : #'api - configuration' }
GtPhlowToolAbstractDetailModel >> beUndefinedTool [
	self 
		deprecated: 'Use #beUndefinedLevel instead' 
		transformWith: '`@receiver beUndefinedTool' -> '`@receiver beUndefinedLevel'.
	self beUndefinedLevel
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
	"A ${class:BlElement}$ (a tool) should display a user defined level of information."

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
