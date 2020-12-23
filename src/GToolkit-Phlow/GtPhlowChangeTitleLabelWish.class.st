Class {
	#name : #GtPhlowChangeTitleLabelWish,
	#superclass : #GtPhlowChangeTitleWish,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #visitor }
GtPhlowChangeTitleLabelWish >> accept: aVisitor [
	^ aVisitor visitGtPhlowChangeDescriptionLabelWish: self
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleLabelWish >> label [
	^ label
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleLabelWish >> label: anObject [
	label := anObject
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleLabelWish >> labelDo: aBlock [
	self label ifNotNil: aBlock
]
