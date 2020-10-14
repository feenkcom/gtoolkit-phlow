Class {
	#name : #GtPhlowSpawnNextPaneDirection,
	#superclass : #GtPhlowSpawnDirection,
	#category : #'GToolkit-Phlow-Direction'
}

{ #category : #accessing }
GtPhlowSpawnNextPaneDirection >> followingDirection [
	^ GtPhlowSpawnBelowDirection new
]

{ #category : #accessing }
GtPhlowSpawnNextPaneDirection >> icon [
	^ BrGlamorousIcons right 
]

{ #category : #testing }
GtPhlowSpawnNextPaneDirection >> isSpawnNextPane [
	^ true
]
