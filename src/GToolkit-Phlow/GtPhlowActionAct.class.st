Class {
	#name : #GtPhlowActionAct,
	#superclass : #Object,
	#instVars : [
		'action',
		'mouseCursor'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowActionAct >> action [
	^ action
]

{ #category : #accessing }
GtPhlowActionAct >> action: anObject [
	action := anObject
]

{ #category : #initialization }
GtPhlowActionAct >> initialize [
	super initialize.

	action := nil.
	mouseCursor := nil
]

{ #category : #accessing }
GtPhlowActionAct >> mouseCursor [
	<return: #BlCursor or: nil>
	^ mouseCursor
]

{ #category : #accessing }
GtPhlowActionAct >> mouseCursor: aBlCursorOrNil [
	mouseCursor := aBlCursorOrNil
]
