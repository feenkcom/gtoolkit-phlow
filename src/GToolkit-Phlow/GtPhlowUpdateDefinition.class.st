Class {
	#name : #GtPhlowUpdateDefinition,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'api - instance creation' }
GtPhlowUpdateDefinition class >> on: aGtPhlowView [
	^ self new on: aGtPhlowView
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> installOn: anElement [
	"This method is called once for every created Phlow element."

	
]

{ #category : #testing }
GtPhlowUpdateDefinition >> isUpdateOnMethodChanged [
	^ false
]

{ #category : #'api - initialization' }
GtPhlowUpdateDefinition >> on: aView [
	
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> subscribeOn: aGtPhlowElementContext [
	"This method is called on every BlElementAddedToSceneGraphEvent event"

	
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> uninstall [
	"This method is called when a definition is removed."

	
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> unsubscribeOn: aGtPhlowElementContext [
	"This method is called on every BlElementRemovedFromSceneGraphEvent event"

	
]
