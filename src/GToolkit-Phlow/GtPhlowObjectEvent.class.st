Class {
	#name : #GtPhlowObjectEvent,
	#superclass : #BlEvent,
	#traits : 'TGtPhlowToolAccessors',
	#classTraits : 'TGtPhlowToolAccessors classTrait',
	#instVars : [
		'sourceElement'
	],
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #initialization }
GtPhlowObjectEvent >> initialize [
	super initialize.
	self initializeTool.
]

{ #category : #convenience }
GtPhlowObjectEvent >> object: anObject [
	self tool: (GtPhlowTool default object: anObject)
]

{ #category : #accessing }
GtPhlowObjectEvent >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
GtPhlowObjectEvent >> sourceElement: anElement [
	sourceElement := anElement
]
