Class {
	#name : #GtPhlowSendTransformation,
	#superclass : #Object,
	#instVars : [
		'valuable'
	],
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

{ #category : #'private - asserting' }
GtPhlowSendTransformation >> assertValuable: aBlock [
	self
		assert: [ aBlock isNotNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
]

{ #category : #defaults }
GtPhlowSendTransformation >> defaultValuable [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtPhlowSendTransformation >> initialize [
	super initialize.
	valuable := self defaultValuable.
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

{ #category : #'private - accessing' }
GtPhlowSendTransformation >> transformedValueFrom: anObject selection: aSelectionIndices [
	^ self valuable cull: anObject cull: aSelectionIndices
]

{ #category : #'api - accessing' }
GtPhlowSendTransformation >> valuable [
	^ valuable
]

{ #category : #'api - accessing' }
GtPhlowSendTransformation >> valuable: aBlock [
	self assertValuable: aBlock.
	valuable := aBlock
]
