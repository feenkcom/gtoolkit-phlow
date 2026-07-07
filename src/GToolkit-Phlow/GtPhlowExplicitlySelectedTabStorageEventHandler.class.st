"
I am a {{gtClass:BlCustomEventHandler}}. 
I handle {{gtClass:GtPhlowExplicitlySelectedTabEvent}} and store explicitly selected tool and selection states.

"
Class {
	#name : #GtPhlowExplicitlySelectedTabStorageEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'selectionStateHandler'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #'api - accessing' }
GtPhlowExplicitlySelectedTabStorageEventHandler >> eventsToHandle [
	^ {GtPhlowExplicitlySelectedTabEvent.
		GtTreePagerModelChanged}
]

{ #category : #'event handling' }
GtPhlowExplicitlySelectedTabStorageEventHandler >> phlowExplicitlySelectedTabEvent: anEvent [
	| aToolElement |
	selectionStateHandler ifNil: [ ^ self ].
	anEvent consumed: true.
	aToolElement := anEvent toolElement ifNil: [ ^ self ].

	selectionStateHandler storeSelectionStateFrom: aToolElement
]

{ #category : #accessing }
GtPhlowExplicitlySelectedTabStorageEventHandler >> selectionStateHandler [
	<return: #TGtPhlowToolSelectionStateHandler>
	^ selectionStateHandler
]

{ #category : #accessing }
GtPhlowExplicitlySelectedTabStorageEventHandler >> selectionStateHandler: aHandler [
	self assert: [ aHandler isNotNil ].

	selectionStateHandler := aHandler
]

{ #category : #'event handling' }
GtPhlowExplicitlySelectedTabStorageEventHandler >> treePagerModelChanged: anEvent [
	anEvent consumed: true.

	selectionStateHandler := anEvent pagerModel pagerSettings selectionStateHandler.
]
