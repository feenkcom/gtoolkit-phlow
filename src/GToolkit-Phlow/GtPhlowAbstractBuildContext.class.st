Class {
	#name : #GtPhlowAbstractBuildContext,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Context'
}

{ #category : #'api - accessing' }
GtPhlowAbstractBuildContext >> contextDo: aDoBlock ifAbsent: anAbsentBlock [
	"Subclasses may provide Phlow context that was used tobuild a Phlow object (view)"

	^ anAbsentBlock value
]

{ #category : #'api - testing' }
GtPhlowAbstractBuildContext >> isBuildContext [
	^ true
]

{ #category : #'api - accessing' }
GtPhlowAbstractBuildContext >> objectDo: aDoBlock ifAbsent: anAbsentBlock [
	"Subclasses may provide object to which a Phlow belongs"

	^ anAbsentBlock value
]
