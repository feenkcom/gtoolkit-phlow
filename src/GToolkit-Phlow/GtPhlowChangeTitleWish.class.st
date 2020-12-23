Class {
	#name : #GtPhlowChangeTitleWish,
	#superclass : #BrWish,
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #visitor }
GtPhlowChangeTitleWish >> accept: aVisitor [
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> iconDo: aBlock [
	"do nothing"
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> labelDo: aBlock [
	"do nothing"
]
