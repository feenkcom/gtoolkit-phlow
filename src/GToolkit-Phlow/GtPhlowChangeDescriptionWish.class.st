Class {
	#name : #GtPhlowChangeDescriptionWish,
	#superclass : #BrWish,
	#category : #'GToolkit-Phlow-Tool - Description'
}

{ #category : #visitor }
GtPhlowChangeDescriptionWish >> accept: aVisitor [
	^ self subclassResponsibility
]
