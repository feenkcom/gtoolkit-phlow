Class {
	#name : #GtPhlowToolVolumeCommonModel,
	#superclass : #BrStateModel,
	#instVars : [
		'dimension'
	],
	#category : #'GToolkit-Phlow-Tool - Model'
}

{ #category : #'api - configuration' }
GtPhlowToolVolumeCommonModel >> beDetailedTool [
	self dimension: GtPhlowToolVolumeState detailedName
]

{ #category : #'api - configuration' }
GtPhlowToolVolumeCommonModel >> beNormalTool [
	self dimension: GtPhlowToolVolumeState normalName
]

{ #category : #defaults }
GtPhlowToolVolumeCommonModel >> defaultDimension [
	^ self subclassResponsibility
]

{ #category : #'api - configuration' }
GtPhlowToolVolumeCommonModel >> dimension [
	<return: #Symbol>
	^ dimension
]

{ #category : #'api - configuration' }
GtPhlowToolVolumeCommonModel >> dimension: aSymbol [

	self dimension = aSymbol
		ifTrue: [ ^ self ].

	dimension := aSymbol.
	self notifyStateChanged: dimension
]

{ #category : #initialization }
GtPhlowToolVolumeCommonModel >> initialize [
	super initialize.

	"we use symbols instead of state object to let users easier define their own custom dimension for customs widgets"
	dimension := self defaultDimension.
]

{ #category : #initialization }
GtPhlowToolVolumeCommonModel >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtPhlowToolVolumeRequest
		reply: [ :aResponse | aResponse dimension: self dimension ].		
	self 
		when: GtPhlowToolVolumeWish 
		do: [ :aWish | 
			self dimension: aWish dimension ].
]

{ #category : #printing }
GtPhlowToolVolumeCommonModel >> printOn: aStream [
	aStream
		nextPutAll: self modelName, '(';
		nextPutAll: self dimension asString;
		nextPutAll: ')'
]

{ #category : #'state - accessing' }
GtPhlowToolVolumeCommonModel >> stateChangedEventClass [
	^ GtPhlowToolVolumeChanged
]

{ #category : #'state - streaming' }
GtPhlowToolVolumeCommonModel >> streamStateIn: aBrInteractionStatesMapping [
	aBrInteractionStatesMapping
		addState: (GtPhlowToolVolumeState new dimension: self dimension)
		model: self
]
