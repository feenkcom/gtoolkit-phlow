Class {
	#name : #GtPhlowSyncUpdateDefinition,
	#superclass : #GtPhlowUpdateDefinition,
	#instVars : [
		'announcementValuable',
		'announcerValuable'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #accessing }
GtPhlowSyncUpdateDefinition >> announcement [
	^ announcementValuable value
]

{ #category : #accessing }
GtPhlowSyncUpdateDefinition >> announcement: aValuable [
	announcementValuable := aValuable
]

{ #category : #accessing }
GtPhlowSyncUpdateDefinition >> announcer: anAnnouncer [
	announcerValuable := anAnnouncer
]

{ #category : #accessing }
GtPhlowSyncUpdateDefinition >> announcerDo: aBlock [
	^ aBlock value: announcerValuable value
]

{ #category : #subscriptions }
GtPhlowSyncUpdateDefinition >> subscribeOn: aGtPhlowElementContext [
	self announcerDo: [ :anAnnouncer |
		anAnnouncer weak
			when: self announcement
			do: (WeakMessageSend receiver: aGtPhlowElementContext selector: #syncUpdate) ]
]

{ #category : #subscriptions }
GtPhlowSyncUpdateDefinition >> unsubscribeOn: aGtPhlowElementContext [
	self announcerDo: [ :anAnnouncer | anAnnouncer unsubscribe: aGtPhlowElementContext ]
]
