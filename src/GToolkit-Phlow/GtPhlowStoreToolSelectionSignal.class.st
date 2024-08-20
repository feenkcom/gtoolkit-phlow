Class {
	#name : #GtPhlowStoreToolSelectionSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'toolElement',
		'phlowView',
		'selectionState'
	],
	#category : #'GToolkit-Phlow-Beacon'
}

{ #category : #accessing }
GtPhlowStoreToolSelectionSignal >> phlowView [
	^ phlowView
]

{ #category : #accessing }
GtPhlowStoreToolSelectionSignal >> phlowView: anObject [
	phlowView := anObject
]

{ #category : #accessing }
GtPhlowStoreToolSelectionSignal >> selectionState [
	^ selectionState
]

{ #category : #accessing }
GtPhlowStoreToolSelectionSignal >> selectionState: anObject [
	selectionState := anObject
]

{ #category : #accessing }
GtPhlowStoreToolSelectionSignal >> toolElement [
	^ toolElement
]

{ #category : #accessing }
GtPhlowStoreToolSelectionSignal >> toolElement: anObject [
	toolElement := anObject
]
