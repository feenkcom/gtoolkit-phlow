Class {
	#name : #GtPhlowNullTool,
	#superclass : #GtPhlowAbstractTool,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'GToolkit-Phlow-Tool - Core'
}

{ #category : #'api - converting' }
GtPhlowNullTool >> asElementDo: aOneArgBlock [
	"Do nothing"
]

{ #category : #'api - converting' }
GtPhlowNullTool >> asTabDo: aBlock [
	"do nothing"
]

{ #category : #'api - accessing' }
GtPhlowNullTool >> object: anObject [
	"ignore it"
]
