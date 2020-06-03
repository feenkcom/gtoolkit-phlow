Class {
	#name : #GtPhlowAsyncUpdateDefinition,
	#superclass : #GtPhlowSyncUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #subscriptions }
GtPhlowAsyncUpdateDefinition >> announcementHandlerFor: aGtPhlowElementContext [
	^ [ :anAnnouncement | aGtPhlowElementContext asyncUpdate ]
]
