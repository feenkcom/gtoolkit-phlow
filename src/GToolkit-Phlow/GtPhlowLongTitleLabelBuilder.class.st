Class {
	#name : #GtPhlowLongTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#instVars : [
		'block'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowLongTitleLabelBuilder >> block [
	^ block
]

{ #category : #'api - accessing' }
GtPhlowLongTitleLabelBuilder >> block: aBlock [
	block := aBlock
]

{ #category : #building }
GtPhlowLongTitleLabelBuilder >> build [
	<return: #BlText>
	| aShortTitle aLongLabel |
	aLongLabel := self longLabel.
	aLongLabel ifNil: [ ^ BlText empty ].
	aLongLabel := aLongLabel asRopedText.
	aLongLabel size < 42 ifTrue: [ ^ aLongLabel ].
	
	aShortTitle := '' asRopedText.
	aShortTitle append: (aLongLabel from: 1 to: 12) asRopedText.
	aShortTitle appendString: '...'.
	aShortTitle append: (aLongLabel from: aLongLabel size - 12 to: aLongLabel size) asRopedText.
	
	^ aShortTitle
]

{ #category : #'private - accessing' }
GtPhlowLongTitleLabelBuilder >> longLabel [
	^ self block value
]
