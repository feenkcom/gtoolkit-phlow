Class {
	#name : #GtPhlowChangeTitleIconWish,
	#superclass : #GtPhlowChangeTitleWish,
	#instVars : [
		'icon'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #visitor }
GtPhlowChangeTitleIconWish >> accept: aVisitor [
	^ aVisitor visitGtPhlowChangeDescriptionIconWish: self
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconWish >> icon [
	^ icon
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconWish >> icon: anObject [
	icon := anObject
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconWish >> iconDo: aBlock [
	self icon ifNotNil: aBlock
]
