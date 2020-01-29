Class {
	#name : #GtPhlowUpdateDefinition,
	#superclass : #Object,
	#instVars : [
		'announcementValuable',
		'announcerValuable'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowUpdateDefinition >> announcement [
	^ announcementValuable value
]

{ #category : #accessing }
GtPhlowUpdateDefinition >> announcement: aValuable [
	announcementValuable := aValuable
]

{ #category : #accessing }
GtPhlowUpdateDefinition >> announcer [
	^ announcerValuable value
]

{ #category : #accessing }
GtPhlowUpdateDefinition >> announcer: aValuable [
	announcerValuable := aValuable
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> subscribeOn: aGtPhlowElementContext [
	| aSubscription |
	aSubscription := self announcer when: self announcement do: [ aGtPhlowElementContext update ].
	aSubscription subscriber: aGtPhlowElementContext.
]

{ #category : #subscriptions }
GtPhlowUpdateDefinition >> unsubscribeOn: aGtPhlowElementContext [
	self announcer unsubscribe: aGtPhlowElementContext
]
