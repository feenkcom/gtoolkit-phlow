Class {
	#name : #GtPhlowAbstractTool,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #testing }
GtPhlowAbstractTool class >> isAbstract [
	^ self name = #GtPhlowAbstractTool 
]

{ #category : #converting }
GtPhlowAbstractTool >> asElementDo: aOneArgBlock context: aContext [
	"Create a tool element and execute the block.
	A context can be passed to build the tool element."
	self subclassResponsibility
]

{ #category : #accessing }
GtPhlowAbstractTool >> object: anObject [
	"defaults tools must implement this message"
]
