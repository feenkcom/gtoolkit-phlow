Class {
	#name : #GtPhlowAsyncUpdateDefinition,
	#superclass : #GtPhlowUpdateDefinition,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #subscriptions }
GtPhlowAsyncUpdateDefinition >> announcementHandlerFor: aGtPhlowElementContext [
	^ [ aGtPhlowElementContext asyncUpdate ]
]
