Class {
	#name : #GtPhlowSpawnBelowDirection,
	#superclass : #GtPhlowSpawnDirection,
	#category : #'GToolkit-Phlow-Direction'
}

{ #category : #accessing }
GtPhlowSpawnBelowDirection >> followingDirection [
	^ GtPhlowSpawnNextPaneDirection new
]

{ #category : #accessing }
GtPhlowSpawnBelowDirection >> icon [
	^ BrGlamorousIcons down 
]

{ #category : #testing }
GtPhlowSpawnBelowDirection >> isSpawnBelow [
	^ true
]
