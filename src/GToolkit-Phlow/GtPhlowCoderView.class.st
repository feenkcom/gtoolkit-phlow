Class {
	#name : #GtPhlowCoderView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'coder'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowCoderView >> asElementDo: aBlock [
	| aCoder |
	aCoder := self coder.
	self beViewElement: aCoder.
	^ aBlock value: aCoder
]

{ #category : #accessing }
GtPhlowCoderView >> coder [
	^ coder ifNil: [ coder := GtCoder new ]
]

{ #category : #accessing }
GtPhlowCoderView >> coder: anObject [
	coder := anObject
]
