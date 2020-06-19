"
I update a view on every ${class:BlElementAddedToSceneGraphEvent}$ notification.
"
Class {
	#name : #GtPhlowUpdateViewOnAddedToScene,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #subscriptions }
GtPhlowUpdateViewOnAddedToScene >> subscribeOn: aGtPhlowElementContext [
	aGtPhlowElementContext asyncUpdate
]
