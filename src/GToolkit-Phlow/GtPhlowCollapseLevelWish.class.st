Class {
	#name : #GtPhlowCollapseLevelWish,
	#superclass : #BrWish,
	#instVars : [
		'levels'
	],
	#category : #'GToolkit-Phlow-Support - Tree Expansion'
}

{ #category : #initialization }
GtPhlowCollapseLevelWish >> initialize [
	super initialize.
	levels := 1
]

{ #category : #accessing }
GtPhlowCollapseLevelWish >> levels [
	^ levels ifNil: [ 1 ]
]

{ #category : #accessing }
GtPhlowCollapseLevelWish >> levels: anInteger [
	levels := anInteger
]

{ #category : #sending }
GtPhlowCollapseLevelWish >> sendTo: anObject [
	anObject phlowCollapseLevelWish: self
]
