Class {
	#name : #GtPhlowBuildNullContext,
	#superclass : #GtPhlowAbstractBuildContext,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Context'
}

{ #category : #'api - accessing' }
GtPhlowBuildNullContext >> contextDo: aDoBlock ifAbsent: anAbsentBlock [
	"there is not a context"

	^ anAbsentBlock value
]

{ #category : #testing }
GtPhlowBuildNullContext >> isBuildContext [
	^ false
]

{ #category : #'api - accessing' }
GtPhlowBuildNullContext >> objectDo: aDoBlock ifAbsent: anAbsentBlock [
	"there is not an object"

	^ anAbsentBlock value
]
