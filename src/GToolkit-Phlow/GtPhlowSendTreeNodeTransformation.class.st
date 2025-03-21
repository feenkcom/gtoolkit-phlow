"
I am {{gtClass:GtPhlowSendTransformation}}.
I am used by {{gtClass:TGtPhlowSendTreeNodeTransformable}} where you can find more details and examples.


"
Class {
	#name : #GtPhlowSendTreeNodeTransformation,
	#superclass : #GtPhlowSendTransformation,
	#instVars : [
		'transformation'
	],
	#category : #'GToolkit-Phlow-Support - Transformation'
}

{ #category : #'api - converting' }
GtPhlowSendTreeNodeTransformation >> asTreeNodeTransformation [
	^ self
]

{ #category : #'api - events' }
GtPhlowSendTreeNodeTransformation >> select: aSelectedNode indices: aSelectionIndices from: anElement shouldShowSpace: shouldOpenInSpace [
	self transformation
		select: aSelectedNode value
		indices: aSelectionIndices
		from: anElement
		shouldShowSpace: shouldOpenInSpace
]

{ #category : #'api - events' }
GtPhlowSendTreeNodeTransformation >> spawn: aSelectedNode indices: aSelectionIndices from: anElement shouldShowSpace: shouldShowSpace [
	self transformation
		spawn: aSelectedNode value
		indices: aSelectionIndices
		from: anElement
		shouldShowSpace: shouldShowSpace
]

{ #category : #'api - accessing' }
GtPhlowSendTreeNodeTransformation >> transformation [
	<return: #GtPhlowSendTransformation>
	^ transformation
]

{ #category : #'api - accessing' }
GtPhlowSendTreeNodeTransformation >> transformation: aGtPhlowSendTransformation [
	transformation := aGtPhlowSendTransformation
]

{ #category : #'api - transformation' }
GtPhlowSendTreeNodeTransformation >> transformedValueFrom: aSelectedNode selection: aSelectionIndices [
	^ self transformation 
		transformedValueFrom: aSelectedNode value 
		selection: aSelectionIndices
]
