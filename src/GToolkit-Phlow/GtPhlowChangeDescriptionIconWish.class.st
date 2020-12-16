Class {
	#name : #GtPhlowChangeDescriptionIconWish,
	#superclass : #GtPhlowChangeDescriptionWish,
	#instVars : [
		'icon'
	],
	#category : #'GToolkit-Phlow-Tool - Description'
}

{ #category : #visitor }
GtPhlowChangeDescriptionIconWish >> accept: aVisitor [
	^ aVisitor visitGtPhlowChangeDescriptionIconWish: self
]

{ #category : #'api - accessing' }
GtPhlowChangeDescriptionIconWish >> icon [
	^ icon
]

{ #category : #'api - accessing' }
GtPhlowChangeDescriptionIconWish >> icon: anObject [
	icon := anObject
]

{ #category : #'api - accessing' }
GtPhlowChangeDescriptionIconWish >> iconDo: aBlock [
	self icon ifNotNil: aBlock
]
