Trait {
	#name : #TGtPhlowSendTreeNodeTransformable,
	#traits : 'TGtPhlowSendTransformable',
	#classTraits : 'TGtPhlowSendTransformable classTrait',
	#category : #'GToolkit-Phlow-Support - Transformation'
}

{ #category : #accessing }
TGtPhlowSendTreeNodeTransformable >> transformation: aGtPhlowSendTransformation [
	self assertTransformation: aGtPhlowSendTransformation.
	transformation := aGtPhlowSendTransformation asPhlowSendTransformation asTreeNodeTransformation.
]
