Class {
	#name : #GtPhlowCompositeToolBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'tool',
		'context'
	],
	#category : #'GToolkit-Phlow-Tools'
}

{ #category : #'api - accessing' }
GtPhlowCompositeToolBuilder >> addObject: anObject [
	self addTool: (GtPhlowTool default object: anObject)
]

{ #category : #'api - accessing' }
GtPhlowCompositeToolBuilder >> addTool: aGtPhlowTool [
	self tool addTool: aGtPhlowTool
]

{ #category : #accessing }
GtPhlowCompositeToolBuilder >> context [
	<return: #GtPhlowElementContext>
	^ context
]

{ #category : #accessing }
GtPhlowCompositeToolBuilder >> context: aGtPhlowElementContext [
	self 
		assert: [ aGtPhlowElementContext isNotNil ] 
		description: [ 'Phlow element context must be non-nil' ].
	context := aGtPhlowElementContext
]

{ #category : #defaults }
GtPhlowCompositeToolBuilder >> defaultTool [
	^ GtPhlowCompositeTool new
]

{ #category : #initialization }
GtPhlowCompositeToolBuilder >> initialize [
	super initialize.
	tool := self defaultTool.
]

{ #category : #'api - actions' }
GtPhlowCompositeToolBuilder >> select [
	self context selectTool: self tool
]

{ #category : #'api - actions' }
GtPhlowCompositeToolBuilder >> spawn [
	self context spawnTool: self tool
]

{ #category : #accessing }
GtPhlowCompositeToolBuilder >> tool [
	^ tool
]

{ #category : #accessing }
GtPhlowCompositeToolBuilder >> tool: anObject [
	tool := anObject
]
