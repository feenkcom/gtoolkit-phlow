Class {
	#name : #GtPhlowExplicitWithSpecificationView,
	#superclass : #GtPhlowExplicitView,
	#instVars : [
		'specificationBuilder'
	],
	#category : #'GToolkit-Phlow'
}

{ #category : #converting }
GtPhlowExplicitWithSpecificationView >> asGtDeclarativeView [
	^specificationBuilder value
]

{ #category : #testing }
GtPhlowExplicitWithSpecificationView >> canBeGtDeclarativeView [
	^true
]

{ #category : #accessing }
GtPhlowExplicitWithSpecificationView >> specification: aBlock [
	specificationBuilder := aBlock
]
