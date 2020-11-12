"
I indicate that the spawn event should spawn a new pane with the result.

Tools using these event are responsible with managing extra informations for determining the current pane.
"
Class {
	#name : #GtPhlowSpawnNextPaneDestination,
	#superclass : #GtPhlowSpawnDesiredDestination,
	#category : #'GToolkit-Phlow-Direction'
}

{ #category : #accessing }
GtPhlowSpawnNextPaneDestination >> followingDestination [
	^ GtPhlowSpawnBelowDestination new
]

{ #category : #accessing }
GtPhlowSpawnNextPaneDestination >> icon [
	^ BrGlamorousVectorIcons right 
]

{ #category : #testing }
GtPhlowSpawnNextPaneDestination >> isSpawnNextPane [
	^ true
]
