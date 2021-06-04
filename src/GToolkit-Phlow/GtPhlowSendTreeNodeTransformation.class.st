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
GtPhlowSendTreeNodeTransformation >> select: aSelectedNode indices: aSelectionIndices from: anElement [
	self transformation 
		select: aSelectedNode value
		indices: aSelectionIndices 
		from: anElement
]

{ #category : #'api - events' }
GtPhlowSendTreeNodeTransformation >> spawn: aSelectedNode indices: aSelectionIndices from: anElement [
	self transformation 
		spawn: aSelectedNode value
		indices: aSelectionIndices 
		from: anElement
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
