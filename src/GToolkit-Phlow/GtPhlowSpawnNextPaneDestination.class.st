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
	^ BrGlamorousIcons right 
]

{ #category : #testing }
GtPhlowSpawnNextPaneDestination >> isSpawnNextPane [
	^ true
]
