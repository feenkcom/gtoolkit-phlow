Class {
	#name : #GtPhlowToolCircularSelectionStateHandlerCountChanged,
	#superclass : #GtPhlowToolCircularSelectionStateHandlerAnnouncement,
	#instVars : [
		'oldCount',
		'newCount'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerCountChanged >> newCount [
	^ newCount
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerCountChanged >> newCount: anObject [
	newCount := anObject
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerCountChanged >> oldCount [
	^ oldCount
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerCountChanged >> oldCount: anObject [
	oldCount := anObject
]
