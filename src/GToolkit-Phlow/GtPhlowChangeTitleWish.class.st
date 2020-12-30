Class {
	#name : #GtPhlowChangeTitleWish,
	#superclass : #BrWish,
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> icon [
	^ nil
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> iconDo: aBlock [
	self icon 
		ifNotNil: aBlock
		ifNil: [ aBlock cull: BrGlamorousVectorIcons noIcon ]
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> label [
	^ nil
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> labelDo: aBlock [
	self label 
		ifNotNil: aBlock
		ifNil: [ aBlock cull: '' ]
]

{ #category : #sending }
GtPhlowChangeTitleWish >> sendTo: anObject [
	anObject changeTitleWish: self
]
