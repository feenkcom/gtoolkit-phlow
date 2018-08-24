Class {
	#name : #GtPhlowElement,
	#superclass : #Object,
	#instVars : [
		'element',
		'isView',
		'isAction',
		'entity'
	],
	#category : 'GToolkit-Phlow'
}

{ #category : #'instance creation' }
GtPhlowElement class >> on: anElement [
	^ self new element: anElement
]

{ #category : #accessing }
GtPhlowElement >> beAction [
	isAction := true
]

{ #category : #accessing }
GtPhlowElement >> beView [
	isView := true
]

{ #category : #accessing }
GtPhlowElement >> element [
	^ element
]

{ #category : #accessing }
GtPhlowElement >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtPhlowElement >> entity [
	^ entity
]

{ #category : #accessing }
GtPhlowElement >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
GtPhlowElement >> isAction [
	^ isAction
]

{ #category : #accessing }
GtPhlowElement >> isAction: anObject [
	isAction := anObject
]

{ #category : #accessing }
GtPhlowElement >> isView [
	^ isView
]

{ #category : #accessing }
GtPhlowElement >> isView: anObject [
	isView := anObject
]
