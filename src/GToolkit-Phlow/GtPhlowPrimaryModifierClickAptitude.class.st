"
I execute an {{gtMethod:GtPhlowPrimaryModifierClickAptitude >> #action | label=#selector}} when a {{gtMethod:GtPhlowPrimaryModifierClickAptitude >> #isPrimaryModifierOnly: | label=primary modifier}} is pressed.
I can also display a specific {{gtMethod:GtPhlowPrimaryModifierClickAptitude >> #mouseCursor | label=mouse cursor}} when the primary modifier is pressed.

"
Class {
	#name : #GtPhlowPrimaryModifierClickAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'action',
		'mouseCursor',
		'hostElement'
	],
	#category : #'GToolkit-Phlow-Tool - Looks'
}

{ #category : #accessing }
GtPhlowPrimaryModifierClickAptitude >> action [
	^ action
]

{ #category : #accessing }
GtPhlowPrimaryModifierClickAptitude >> action: aBlock [
	"Action is a block that receives [ :anElement :aHostElement :aViewModel :anEvent | ]"

	action := aBlock
]

{ #category : #'private - event management' }
GtPhlowPrimaryModifierClickAptitude >> handleClickDown: anEvent [
	self action ifNil: [ ^ self ].
	(self isPrimaryModifierOnly: anEvent) ifFalse: [ ^ self ].
	
	self
		widgetDo: [ :aWidget | 
			anEvent consumed: true.
			self action
				gtValueWithArgs: {aWidget.
						self hostElement.
						aWidget viewModel.
						anEvent} ]
]

{ #category : #'private - event management' }
GtPhlowPrimaryModifierClickAptitude >> handleMouseEnterDown: anEvent [
	self action ifNil: [ ^ self ].
	
	anEvent consumed: true.
	(self isPrimaryModifierOnly: anEvent)
		ifTrue: [ anEvent target mouseCursor: mouseCursor ]
		ifFalse: [ anEvent target mouseCursor: nil ]
]

{ #category : #accessing }
GtPhlowPrimaryModifierClickAptitude >> hostElement [
	^ hostElement
]

{ #category : #accessing }
GtPhlowPrimaryModifierClickAptitude >> hostElement: anObject [
	hostElement := anObject
]

{ #category : #initialization }
GtPhlowPrimaryModifierClickAptitude >> initializeListeners [
	super initializeListeners.
	
	self when: BlClickEvent do: [ :anEvent | self handleClickDown: anEvent ].
	self when: BlMouseEnterEvent do: [ :anEvent | self handleMouseEnterDown: anEvent ]
]

{ #category : #'private - event management' }
GtPhlowPrimaryModifierClickAptitude >> isPrimaryModifierOnly: anEvent [
	"Return true, if the primary key is the only one pressed"
	
	<return: #Boolean>
	^ anEvent modifiers isPrimaryModifier and: [ 
		anEvent modifiers isAlt not and: [ 
			anEvent modifiers isShift not ] ]
]

{ #category : #accessing }
GtPhlowPrimaryModifierClickAptitude >> mouseCursor [
	^ mouseCursor
]

{ #category : #accessing }
GtPhlowPrimaryModifierClickAptitude >> mouseCursor: anObject [
	mouseCursor := anObject
]
