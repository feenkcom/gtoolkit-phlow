Class {
	#name : #GtPhlowProtoTool,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #testing }
GtPhlowProtoTool class >> isAbstract [
	^ self name = #GtPhlowProtoTool 
]

{ #category : #converting }
GtPhlowProtoTool >> asElementDo: aOneArgBlock context: aContext [
	"Create a tool element and execute the block.
	A context can be passed to build the tool element."
	self subclassResponsibility
]
