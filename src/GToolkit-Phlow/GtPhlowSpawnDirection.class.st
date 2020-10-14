Class {
	#name : #GtPhlowSpawnDirection,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Direction'
}

{ #category : #initialization }
GtPhlowSpawnDirection class >> defaultDirection [
	^ GtPhlowSpawnNextPaneDirection new
]

{ #category : #accessing }
GtPhlowSpawnDirection >> followingDirection [
	"Return the direction that comes after this one. It is used to when 
	switching directions to determine the next direction."
	
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowSpawnDirection >> icon [
	^ self subclassResponsibility 
]

{ #category : #testing }
GtPhlowSpawnDirection >> isSpawnBelow [
	^ false
]

{ #category : #testing }
GtPhlowSpawnDirection >> isSpawnNextPane [
	^ false
]
