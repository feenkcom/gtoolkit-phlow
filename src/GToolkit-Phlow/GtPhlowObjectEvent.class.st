Class {
	#name : 'GtPhlowObjectEvent',
	#superclass : 'BlEvent',
	#traits : 'TGtPhlowToolAccessors',
	#classTraits : 'TGtPhlowToolAccessors classTrait',
	#instVars : [
		'sourceElement',
		'properties'
	],
	#category : 'GToolkit-Phlow-Events'
}

{ #category : 'initialization' }
GtPhlowObjectEvent >> initialize [
	super initialize.
	self initializeTool.
]

{ #category : 'convenience' }
GtPhlowObjectEvent >> object [
	^ self tool object
]

{ #category : 'convenience' }
GtPhlowObjectEvent >> object: anObject [
	self tool: (GtPhlowTool default object: anObject)
]

{ #category : 'accessing - properties' }
GtPhlowObjectEvent >> properties [
	^ properties ifNil: [ properties := OrderedDictionary new ]
]

{ #category : 'accessing - properties' }
GtPhlowObjectEvent >> propertyAt: aName [
	^ self properties at: aName
]

{ #category : 'accessing - properties' }
GtPhlowObjectEvent >> propertyAt: aName ifAbsent: aBlock [
	^ self properties at: aName ifAbsent: aBlock
]

{ #category : 'accessing - properties' }
GtPhlowObjectEvent >> propertyAt: aName put: aBlock [
	^ self properties at: aName put: aBlock
]

{ #category : 'accessing' }
GtPhlowObjectEvent >> sourceElement [
	^ sourceElement
]

{ #category : 'accessing' }
GtPhlowObjectEvent >> sourceElement: anElement [
	sourceElement := anElement
]
