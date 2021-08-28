"
I indicate that the spawn event should show the inspected object below in the same pane.

The actual element handling this event can decide the exact position where to display the event.
Also it is up to tools using this event to manage extra information needed in order to correctly
determine where to place the event.


"
Class {
	#name : 'GtPhlowSpawnBelowDestination',
	#superclass : 'GtPhlowSpawnDesiredDestination',
	#category : 'GToolkit-Phlow-Direction'
}

{ #category : 'accessing' }
GtPhlowSpawnBelowDestination >> followingDestination [
	^ GtPhlowSpawnNextPaneDestination new
]

{ #category : 'accessing' }
GtPhlowSpawnBelowDestination >> icon [
	^ BrGlamorousVectorIcons down 
]

{ #category : 'testing' }
GtPhlowSpawnBelowDestination >> isSpawnBelow [
	^ true
]
