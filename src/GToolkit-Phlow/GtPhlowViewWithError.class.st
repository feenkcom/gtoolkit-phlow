Class {
	#name : #GtPhlowViewWithError,
	#superclass : #GtPhlowView,
	#instVars : [
		'error'
	],
	#category : #'GToolkit-Phlow-! Views and Actions'
}

{ #category : #accessing }
GtPhlowViewWithError >> asElementDo: aBlock [
	^ aBlock value: error asDebuggableElement
]

{ #category : #accessing }
GtPhlowViewWithError >> error [
	^ error
]

{ #category : #accessing }
GtPhlowViewWithError >> error: anObject [
	error := anObject
]
