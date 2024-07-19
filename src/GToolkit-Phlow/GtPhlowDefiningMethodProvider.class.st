Class {
	#name : #GtPhlowDefiningMethodProvider,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #accessing }
GtPhlowDefiningMethodProvider >> allDefiningMethods [
	^ self definingMethod
]

{ #category : #accessing }
GtPhlowDefiningMethodProvider >> definingMethod [
	^ self subclassResponsibility
]
