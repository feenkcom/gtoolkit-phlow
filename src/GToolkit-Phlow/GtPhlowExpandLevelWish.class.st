Class {
	#name : #GtPhlowExpandLevelWish,
	#superclass : #BrWish,
	#instVars : [
		'levels'
	],
	#category : #'GToolkit-Phlow-Support - Tree Expansion'
}

{ #category : #initialization }
GtPhlowExpandLevelWish >> initialize [
	super initialize.
	levels := 1
]

{ #category : #accessing }
GtPhlowExpandLevelWish >> levels [
	^ levels ifNil: [ 1 ]
]

{ #category : #accessing }
GtPhlowExpandLevelWish >> levels: anInteger [
	levels := anInteger
]

{ #category : #sending }
GtPhlowExpandLevelWish >> sendTo: anObject [
	anObject phlowExpandLevelWish: self
]
