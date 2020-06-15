Class {
	#name : #GtPhlowUpdateDefinition,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #converting }
GtPhlowUpdateDefinition class >> asPhlowUpdateDefinition [
	^ self new
]

{ #category : #converting }
GtPhlowUpdateDefinition >> asPhlowUpdateDefinition [
	^ self
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> subscribeOn: aGtPhlowElementContext [
	self subclassResponsibility
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> unsubscribeOn: aGtPhlowElementContext [
	self subclassResponsibility
]
