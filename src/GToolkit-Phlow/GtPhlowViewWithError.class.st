Class {
	#name : #GtPhlowViewWithError,
	#superclass : #GtPhlowView,
	#instVars : [
		'error'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowViewWithError >> asElementDo: aBlock [
	| aContainer aTextElement aDebugButton |
	aContainer := BlElement new.
	aContainer layout: BlLinearLayout vertical.
	aTextElement := self labelWithError: error.
	aContainer addChild: aTextElement.
	aDebugButton := self debugButtonWithError: error.
	aContainer addChild: aDebugButton.
	aContainer constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	^ aBlock value: aContainer
]

{ #category : #accessing }
GtPhlowViewWithError >> error [
	^ error
]

{ #category : #accessing }
GtPhlowViewWithError >> error: anObject [
	error := anObject
]
