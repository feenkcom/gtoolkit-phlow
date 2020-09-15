Class {
	#name : #GtPhlowSendValuableTransformatioin,
	#superclass : #GtPhlowSendTransformation,
	#instVars : [
		'valuable'
	],
	#category : #'GToolkit-Phlow-Support - Transformation'
}

{ #category : #testing }
GtPhlowSendValuableTransformatioin class >> isAbstract [
	^ self name = #GtPhlowSendValuableTransformatioin 
]

{ #category : #converting }
GtPhlowSendValuableTransformatioin >> asTreeNodeTransformation [
	^ GtPhlowSendTreeNodeTransformation new
		transformation: self
]

{ #category : #'private - asserting' }
GtPhlowSendValuableTransformatioin >> assertValuable: aBlock [
	self
		assert: [ aBlock isNotNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
]

{ #category : #defaults }
GtPhlowSendValuableTransformatioin >> defaultValuable [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtPhlowSendValuableTransformatioin >> initialize [
	super initialize.
	valuable := self defaultValuable.
]

{ #category : #'private - accessing' }
GtPhlowSendValuableTransformatioin >> transformedValueFrom: anObject selection: aSelectionIndices [
	^ self valuable cull: anObject cull: aSelectionIndices
]

{ #category : #'api - accessing' }
GtPhlowSendValuableTransformatioin >> valuable [
	^ valuable
]

{ #category : #'api - accessing' }
GtPhlowSendValuableTransformatioin >> valuable: aBlock [
	self assertValuable: aBlock.
	valuable := aBlock
]
