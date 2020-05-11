Class {
	#name : #GtPhlowContext,
	#superclass : #GtPhlowProtoContext,
	#traits : 'TGtOptions',
	#classTraits : 'TGtOptions classTrait',
	#category : #'GToolkit-Phlow-Context'
}

{ #category : #factory }
GtPhlowContext class >> null [
	^ GtPhlowNullContext default
]
