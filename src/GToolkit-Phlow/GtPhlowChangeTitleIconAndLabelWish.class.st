Class {
	#name : #GtPhlowChangeTitleIconAndLabelWish,
	#superclass : #GtPhlowChangeTitleWish,
	#instVars : [
		'icon',
		'label'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #visitor }
GtPhlowChangeTitleIconAndLabelWish >> accept: aVisitor [
	^ aVisitor visitGtPhlowChangeTitleIconAndlabelWish: self
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> icon [
	^ icon
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> icon: anObject [
	icon := anObject
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> iconDo: aBlock [
	self icon 
		ifNotNil: aBlock
		ifNil: [ aBlock cull: BrGlamorousVectorIcons noIcon ]
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> label [
	^ label
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> label: anObject [
	label := anObject
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> labelDo: aBlock [
	self label ifNotNil: aBlock
]
