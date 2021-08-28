"
I am an abstract class.
I am {{gtClass:GtPhlowSendTransformation}}.
I provide a common {{gtMethod:GtPhlowSendValuableTransformation>>#valuable|label=#selector}} code to {{gtMethod:GtPhlowSendValuableTransformation>>#transformedValueFrom:selection:|label=transform}} and request displaying given objects using dedicated {{gtClass:GtPhlowTool}} instances.
See {{gtClass:GtPhlowSendValuableTransformation|label=my subclasses|expanded|show=#gtSubclassesFor:}} for more details:


"
Class {
	#name : 'GtPhlowSendValuableTransformation',
	#superclass : 'GtPhlowSendTransformation',
	#instVars : [
		'valuable'
	],
	#category : 'GToolkit-Phlow-Support - Transformation'
}

{ #category : 'testing' }
GtPhlowSendValuableTransformation class >> isAbstract [
	^ self name = #GtPhlowSendValuableTransformation 
]

{ #category : 'converting' }
GtPhlowSendValuableTransformation >> asTreeNodeTransformation [
	^ GtPhlowSendTreeNodeTransformation new
		transformation: self
]

{ #category : 'private - asserting' }
GtPhlowSendValuableTransformation >> assertValuable: aBlock [
	self
		assert: [ aBlock isNotNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
]

{ #category : 'defaults' }
GtPhlowSendValuableTransformation >> defaultValuable [
	^ self subclassResponsibility
]

{ #category : 'initialization' }
GtPhlowSendValuableTransformation >> initialize [
	super initialize.
	valuable := self defaultValuable.
]

{ #category : 'private - accessing' }
GtPhlowSendValuableTransformation >> transformedValueFrom: anObject selection: aSelectionIndices [
	"Given object is passed to the ${method:GtPhlowSendValuableTransformation>>#valuable|label=#selector}$
	and the valuable result is used to display an information (instead of the anObject)."
	^ self valuable cull: anObject cull: aSelectionIndices
]

{ #category : 'api - accessing' }
GtPhlowSendValuableTransformation >> valuable [
	"A valuable object that understands ${method:BlockClosure>>#cull:cull:|label=#selecttor}$.
	See ${method:GtPhlowSendValuableTransformation>>#transformedValueFrom:selection:}$"
	^ valuable
]

{ #category : 'api - accessing' }
GtPhlowSendValuableTransformation >> valuable: aBlock [
	self assertValuable: aBlock.
	valuable := aBlock
]
