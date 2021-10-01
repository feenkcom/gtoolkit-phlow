Class {
	#name : #GtPhlowViewWithError,
	#superclass : #GtPhlowView,
	#instVars : [
		'error'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowViewWithError >> asElementDo: aBlock [
	| anElement |
	anElement := error asDebuggableElement.
	self beViewElement: anElement.
	^ aBlock value: anElement
]

{ #category : #accessing }
GtPhlowViewWithError >> error [
	^ error
]

{ #category : #accessing }
GtPhlowViewWithError >> error: anObject [
	error := anObject
]
