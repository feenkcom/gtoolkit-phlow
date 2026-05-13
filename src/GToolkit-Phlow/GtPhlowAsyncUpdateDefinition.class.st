Class {
	#name : #GtPhlowAsyncUpdateDefinition,
	#superclass : #GtPhlowSyncUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #testing }
GtPhlowAsyncUpdateDefinition class >> isDeprecated [
	"Replaced by GtPhlowUpdateOnAnnouncement"

	^ true
]

{ #category : #subscriptions }
GtPhlowAsyncUpdateDefinition >> subscribeOn: aGtPhlowElementContext [
	self announcerDo: [ :anAnnouncer |
		anAnnouncer weak
			when: self announcement
			send: #asyncUpdate
			to: aGtPhlowElementContext ]
]
