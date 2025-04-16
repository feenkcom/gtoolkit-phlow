Class {
	#name : #GtPhlowMenuSpawnEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'anchorElement'
	],
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #accessing }
GtPhlowMenuSpawnEventHandler >> anchorElement [
	^ anchorElement
]

{ #category : #accessing }
GtPhlowMenuSpawnEventHandler >> anchorElement: anElement [
	self
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'Anchor element must be kind of {1}, but is: {2}'
				format: {BlElement. anElement} ].

	anchorElement := anElement
]

{ #category : #'api - accessing' }
GtPhlowMenuSpawnEventHandler >> anchorElementDo: aBlock [
	^ anchorElement ifNotNil: aBlock
]

{ #category : #'api - accessing' }
GtPhlowMenuSpawnEventHandler >> eventsToHandle [
	^ { GtPhlowObjectToSpawn. BrPopoverAnchorElementChanged}
]

{ #category : #'api - event managing' }
GtPhlowMenuSpawnEventHandler >> menuAnchorElementChangedEvent: anEvent [
	anchorElement := anEvent anchorElement
]

{ #category : #'api - event managing' }
GtPhlowMenuSpawnEventHandler >> objectToSpawnEvent: anEvent [ 
	anEvent isConsumed ifTrue: [ ^ self ].
	self anchorElementDo: [ :aWidget |
		aWidget phlow spawnPreviousEvent: anEvent ]
]
