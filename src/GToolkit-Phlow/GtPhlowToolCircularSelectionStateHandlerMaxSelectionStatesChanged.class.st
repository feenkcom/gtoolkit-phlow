Class {
	#name : #GtPhlowToolCircularSelectionStateHandlerMaxSelectionStatesChanged,
	#superclass : #GtPhlowToolCircularSelectionStateHandlerAnnouncement,
	#instVars : [
		'oldMaxSelectionStates',
		'maxSelectionStates'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerMaxSelectionStatesChanged >> maxSelectionStates [
	^ maxSelectionStates
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerMaxSelectionStatesChanged >> maxSelectionStates: anInteger [
	maxSelectionStates := anInteger
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerMaxSelectionStatesChanged >> oldMaxSelectionStates [
	^ oldMaxSelectionStates
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerMaxSelectionStatesChanged >> oldMaxSelectionStates: anInteger [
	oldMaxSelectionStates := anInteger
]
