Class {
	#name : #GtPhlowElement,
	#superclass : #Object,
	#instVars : [
		'element',
		'isView',
		'isAction',
		'isViewContent',
		'entity'
	],
	#category : #'GToolkit-Phlow-UI'
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
GtPhlowElement >> beViewContent [
	isViewContent := true
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
	^ isAction ifNil: [ false ]
]

{ #category : #accessing }
GtPhlowElement >> isAction: anObject [
	isAction := anObject
]

{ #category : #accessing }
GtPhlowElement >> isView [
	^ isView ifNil: [ false ]
]

{ #category : #accessing }
GtPhlowElement >> isView: anObject [
	isView := anObject
]

{ #category : #accessing }
GtPhlowElement >> isViewContent [
	^ isViewContent ifNil: [ false ]
]

{ #category : #accessing }
GtPhlowElement >> isViewContent: anObject [
	isViewContent := anObject
]
