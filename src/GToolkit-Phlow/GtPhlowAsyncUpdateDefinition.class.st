Class {
	#name : #GtPhlowAsyncUpdateDefinition,
	#superclass : #GtPhlowSyncUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #subscriptions }
GtPhlowAsyncUpdateDefinition >> subscribeOn: aGtPhlowElementContext [
	self announcerDo: [ :anAnnouncer |
		anAnnouncer weak
			when: self announcement
			do: (WeakMessageSend receiver: aGtPhlowElementContext selector: #asyncUpdate) ]
]
