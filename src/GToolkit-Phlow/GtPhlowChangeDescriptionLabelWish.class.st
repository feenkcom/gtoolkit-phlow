Class {
	#name : #GtPhlowChangeDescriptionLabelWish,
	#superclass : #GtPhlowChangeDescriptionWish,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Phlow-Tool - Description'
}

{ #category : #visitor }
GtPhlowChangeDescriptionLabelWish >> accept: aVisitor [
	^ aVisitor visitGtPhlowChangeDescriptionLabelWish: self
]

{ #category : #'api - accessing' }
GtPhlowChangeDescriptionLabelWish >> label [
	^ label
]

{ #category : #'api - accessing' }
GtPhlowChangeDescriptionLabelWish >> label: anObject [
	label := anObject
]

{ #category : #'api - accessing' }
GtPhlowChangeDescriptionLabelWish >> labelDo: aBlock [
	self label ifNotNil: aBlock
]
