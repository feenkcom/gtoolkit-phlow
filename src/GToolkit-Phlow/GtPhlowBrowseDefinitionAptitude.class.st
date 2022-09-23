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
	(self isDefinitionRequested: anEvent)
		ifFalse: [ ^ self ].
	
	self widgetDo: [ :aWidget |
		anEvent consumed: true.
		aWidget phlow spawnObject: definitionComputation value ]
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
	^ anEvent modifiers isAlt and: [ 
		anEvent modifiers isCmd not and: [ 
			anEvent modifiers isCtrl not and: [ 
				anEvent modifiers isShift not ] ] ]
]
