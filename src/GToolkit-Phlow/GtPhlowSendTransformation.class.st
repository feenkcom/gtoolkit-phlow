Class {
	#name : #GtPhlowSendTransformation,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Support - Transformation'
}

{ #category : #'api - factory' }
GtPhlowSendTransformation class >> default [
	^ GtPhlowSendObjectTransformation new
]

{ #category : #'api - factory' }
GtPhlowSendTransformation class >> object: aBlock [
	^ GtPhlowSendObjectTransformation new valuable: aBlock
]

{ #category : #'api - factory' }
GtPhlowSendTransformation class >> tool: aBlock [
	^ GtPhlowSendToolTransformation new valuable: aBlock
]

{ #category : #'api - events' }
GtPhlowSendTransformation >> select: aSelectedObject indices: aSelectionIndices from: anElement [
	"Fire a ${class:GtPhlowSele"
	self subclassResponsibility
]

{ #category : #'api - events' }
GtPhlowSendTransformation >> spawn: aSelectedObject indices: aSelectionIndices from: anElement [
	"Fire a ${class:GtPhlowSele"
	self subclassResponsibility
]
