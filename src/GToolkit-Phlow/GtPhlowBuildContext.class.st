Class {
	#name : #GtPhlowBuildContext,
	#superclass : #GtPhlowAbstractBuildContext,
	#instVars : [
		'object',
		'arguments'
	],
	#category : #'GToolkit-Phlow-Context'
}

{ #category : #factory }
GtPhlowBuildContext class >> null [
	^ GtPhlowBuildNullContext default
]

{ #category : #accessing }
GtPhlowBuildContext >> argument: anArgument [
	self arguments: (Array with: anArgument)
]

{ #category : #accessing }
GtPhlowBuildContext >> arguments [
	^ arguments
]

{ #category : #accessing }
GtPhlowBuildContext >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
GtPhlowBuildContext >> context [
	<return: #GtPhlowContext>
	^ self arguments at: 2 ifAbsent: [ GtPhlowContext new ]
]

{ #category : #'api - accessing' }
GtPhlowBuildContext >> contextDo: aDoBlock ifAbsent: anAbsentBlock [
	^ self hasContext 
		ifTrue: [ aDoBlock cull: self context ] 
		ifFalse: anAbsentBlock
]

{ #category : #testing }
GtPhlowBuildContext >> hasContext [

	^ self arguments size = 2
]

{ #category : #initialization }
GtPhlowBuildContext >> initialize [
	super initialize.
	arguments := Array empty.
]

{ #category : #accessing }
GtPhlowBuildContext >> object [
	^ object
]

{ #category : #accessing }
GtPhlowBuildContext >> object: anObject [
	object := anObject
]

{ #category : #'api - accessing' }
GtPhlowBuildContext >> objectDo: aDoBlock ifAbsent: anAbsentBlock [
	^ aDoBlock cull: self object
]
