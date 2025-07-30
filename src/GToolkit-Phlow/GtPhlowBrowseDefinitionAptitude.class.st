"
Adds an alt+click action to browse a definition (usually source code) behind an action. Uses phlow to spawn the corresponding object.
"
Class {
	#name : #GtPhlowBrowseDefinitionAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'definitionComputation'
	],
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #initialization }
GtPhlowBrowseDefinitionAptitude >> definition: aBlock [
	definitionComputation := aBlock
]

{ #category : #'private - event handling' }
GtPhlowBrowseDefinitionAptitude >> handleMouseDown: anEvent [
	"If I'm not within a Pager, spawn a new one."

	(self isDefinitionRequested: anEvent) ifFalse: [ ^ self ].
	
	self widgetDo: [ :aWidget | 
		BlSpace 
			spawnObject: definitionComputation value 
			from: aWidget ]
]

{ #category : #initialization }
GtPhlowBrowseDefinitionAptitude >> initialize [
	super initialize.
	
	definitionComputation := [ nil ]
]

{ #category : #initialization }
GtPhlowBrowseDefinitionAptitude >> initializeListeners [
	super initializeListeners.
	
	self when: BlMouseDownEvent do: [ :anEvent | self handleMouseDown: anEvent ]
]

{ #category : #testing }
GtPhlowBrowseDefinitionAptitude >> isDefinitionRequested: anEvent [
	"Return true, if a user wants to see an action definition"

	<return: #Boolean>
	^ GtPhlowUtility isDefinitionRequested: anEvent
]

{ #category : #accessing }
GtPhlowBrowseDefinitionAptitude >> spawnPagerFor: anElement withTitle: aString [
	BlSpace new
		inPager: anElement;
		title: aString;
		extent: 1200 @ 600;
		showFrom: self widget
]
