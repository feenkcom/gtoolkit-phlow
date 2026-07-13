Class {
	#name : #GtPhlowToolCircularSelectionStateHandlerAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'selectionStateHandler'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerAnnouncement >> selectionStateHandler [
	^ selectionStateHandler
]

{ #category : #accessing }
GtPhlowToolCircularSelectionStateHandlerAnnouncement >> selectionStateHandler: anObject [
	selectionStateHandler := anObject
]
