Class {
	#name : #GtPhlowViewTesterResult,
	#superclass : #Object,
	#instVars : [
		'phlowView',
		'phlowElement'
	],
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterResult >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
GtPhlowViewTesterResult >> hash [
	^ self class hash
]

{ #category : #testing }
GtPhlowViewTesterResult >> isEmpty [
	^ false
]

{ #category : #testing }
GtPhlowViewTesterResult >> isOk [
	^ false
]

{ #category : #accessing }
GtPhlowViewTesterResult >> phlowElement [
	^ phlowElement
]

{ #category : #accessing }
GtPhlowViewTesterResult >> phlowElement: anObject [
	phlowElement := anObject
]

{ #category : #accessing }
GtPhlowViewTesterResult >> phlowView [
	^ phlowView
]

{ #category : #accessing }
GtPhlowViewTesterResult >> phlowView: anObject [
	phlowView := anObject
]
