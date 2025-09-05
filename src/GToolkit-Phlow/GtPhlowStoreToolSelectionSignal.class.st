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

{ #category : #testing }
GtPhlowStoreToolSelectionSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

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
