Class {
	#name : #GtPhlowUpdateDefinition,
	#superclass : #Object,
	#category : 'GToolkit-Phlow-Updating'
}

{ #category : #'api - instance creation' }
GtPhlowUpdateDefinition class >> on: aGtPhlowView [
	^ self new on: aGtPhlowView
]

{ #category : #'api - initialization' }
GtPhlowUpdateDefinition >> on: aView [
	
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> subscribeOn: aGtPhlowElementContext [
	self subclassResponsibility
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> unsubscribeOn: aGtPhlowElementContext [
	self subclassResponsibility
]
