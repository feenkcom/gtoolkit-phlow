Class {
	#name : #GtPhlowUpdateOnAnnouncement,
	#superclass : #GtPhlowUpdateDefinition,
	#instVars : [
		'announcerValuable',
		'announcementValuable'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #accessing }
GtPhlowUpdateOnAnnouncement >> announcement [
	^ announcementValuable value
]

{ #category : #accessing }
GtPhlowUpdateOnAnnouncement >> announcement: aValuable [
	announcementValuable := aValuable
]

{ #category : #accessing }
GtPhlowUpdateOnAnnouncement >> announcementDo: aBlock [
	self announcement ifNotNil: aBlock
]

{ #category : #accessing }
GtPhlowUpdateOnAnnouncement >> announcer [
	^ announcerValuable value
]

{ #category : #accessing }
GtPhlowUpdateOnAnnouncement >> announcer: anAnnouncer [
	announcerValuable := anAnnouncer
]

{ #category : #accessing }
GtPhlowUpdateOnAnnouncement >> announcerDo: aBlock [
	self announcer ifNotNil: aBlock
]

{ #category : #accessing }
GtPhlowUpdateOnAnnouncement >> inputDo: aBlock [
	self announcer ifNotNil: [ :anAnnouncer |
		self announcementDo: [ :anAnnouncement | 
			aBlock cull: anAnnouncer cull: anAnnouncement ] ]
]

{ #category : #subscriptions }
GtPhlowUpdateOnAnnouncement >> installOn: anElement [
	"This method is called once for every created Phlow element."

	super installOn: anElement.
	self inputDo: [ :anAnnouncer :anAnnouncement |
		GtPhlowChangeAnnouncerListener 
			installOn: anElement 
			announcer: anAnnouncer 
			announcement: anAnnouncement ]
]
