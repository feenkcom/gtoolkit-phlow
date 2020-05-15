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
GtPhlowAbstractTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	self subclassResponsibility
]

{ #category : #accessing }
GtPhlowAbstractTool >> object [
	"compatibility method for ${GLMBlocObjectToSelect}$"
	^ self
]

{ #category : #accessing }
GtPhlowAbstractTool >> object: anObject [
	"defaults tools must implement this message"
]
