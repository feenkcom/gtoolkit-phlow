Class {
	#name : #GtPhlowAsyncUpdateDefinition,
	#superclass : #GtPhlowSyncUpdateDefinition,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #subscriptions }
GtPhlowAsyncUpdateDefinition >> announcementHandlerFor: aGtPhlowElementContext [
	^ [ :anAnnouncement | aGtPhlowElementContext asyncUpdate ]
]
