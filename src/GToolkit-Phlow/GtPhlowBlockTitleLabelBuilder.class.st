Class {
	#name : #GtPhlowBlockTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#instVars : [
		'block'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowBlockTitleLabelBuilder >> block [
	^ block
]

{ #category : #'api - accessing' }
GtPhlowBlockTitleLabelBuilder >> block: anObject [
	block := anObject
]

{ #category : #'api - building' }
GtPhlowBlockTitleLabelBuilder >> build [
	^ self block value
]
