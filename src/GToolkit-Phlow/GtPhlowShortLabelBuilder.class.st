Class {
	#name : #GtPhlowShortLabelBuilder,
	#superclass : #Object,
	#instVars : [
		'fullLabel'
	],
	#category : 'GToolkit-Phlow-Collectors'
}

{ #category : #'api - building' }
GtPhlowShortLabelBuilder >> build [
	<return: #BlRopedText or: #String>
	^ self fullLabel size < 42
		ifTrue: [ self fullLabel ]
		ifFalse: [ 
			(self fullLabel first: 16), '...', (self fullLabel last: 9) ].
]

{ #category : #'api - accessing' }
GtPhlowShortLabelBuilder >> fullLabel [
	^ fullLabel
]

{ #category : #'api - accessing' }
GtPhlowShortLabelBuilder >> fullLabel: anObject [
	fullLabel := anObject
]

{ #category : #'api - building' }
GtPhlowShortLabelBuilder >> value [
	^ self build
]
