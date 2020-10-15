Class {
	#name : #GtPhlowSpawnBelowDestination,
	#superclass : #GtPhlowSpawnDesiredDestination,
	#category : #'GToolkit-Phlow-Direction'
}

{ #category : #accessing }
GtPhlowSpawnBelowDestination >> followingDestination [
	^ GtPhlowSpawnNextPaneDestination new
]

{ #category : #accessing }
GtPhlowSpawnBelowDestination >> icon [
	^ BrGlamorousIcons down 
]

{ #category : #testing }
GtPhlowSpawnBelowDestination >> isSpawnBelow [
	^ true
]
