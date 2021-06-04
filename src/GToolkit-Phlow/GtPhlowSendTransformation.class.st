"
I am an abstract class.
I am used by {{gtClass:GtPhlowListHandler}}.
My concrete subclasses implement:
- {{gtMethod:GtPhlowSendTransformation>>#select:indices:from:|label=#selector}}, and
- {{gtMethod:GtPhlowSendTransformation>>#spawn:indices:from:|label=#selector}}.
See {{gtClass:GtPhlowSendTransformation|label=my subclasses|expanded|show=#gtSubclassesFor:}} for more details:


"
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

{ #category : #'api - converting' }
GtPhlowSendTransformation >> asPhlowSendTransformation [
	^ self
]

{ #category : #'api - events' }
GtPhlowSendTransformation >> select: aSelectedObject indices: aSelectionIndices from: anElement [
	"Properly instantiate and fire ${class:GtPhlowObjectToSelect}$ event.
	The ${class:GtPhlowObjectToSelect}$ event must be instantiated with a ${class:GtPhlowTool}$ instance
	that displayes the selected object (aSelectedObject)."
	self subclassResponsibility
]

{ #category : #'api - events' }
GtPhlowSendTransformation >> spawn: aSelectedObject indices: aSelectionIndices from: anElement [
	"Properly instantiate and fire ${class:GtPhlowObjectToSpawn}$ event
	The ${class:GtPhlowObjectToSpawn}$ event must be instantiated with a ${class:GtPhlowTool}$ instance
	that displayes the selected object (aSelectedObject)."
	self subclassResponsibility
]
