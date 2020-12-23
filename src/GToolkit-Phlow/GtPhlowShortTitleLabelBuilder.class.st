Class {
	#name : #GtPhlowShortTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#instVars : [
		'block'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowShortTitleLabelBuilder >> block [
	^ block
]

{ #category : #'api - accessing' }
GtPhlowShortTitleLabelBuilder >> block: anObject [
	block := anObject
]

{ #category : #'api - building' }
GtPhlowShortTitleLabelBuilder >> build [
	^ self block value
]
