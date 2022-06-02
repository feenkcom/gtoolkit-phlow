Class {
	#name : #GtPhlowAsyncUpdateWithConditionDefinition,
	#superclass : #GtPhlowAsyncUpdateDefinition,
	#instVars : [
		'condition'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #accessing }
GtPhlowAsyncUpdateWithConditionDefinition >> condition [
	^ condition
]

{ #category : #accessing }
GtPhlowAsyncUpdateWithConditionDefinition >> condition: aBlock [
	self 
		assert: [ aBlock isNotNil ] 
		description: [ 'Phlow async update condition must be non-nil (that understands the #cull:cull: message)' ].
	condition := aBlock
]

{ #category : #initialization }
GtPhlowAsyncUpdateWithConditionDefinition >> initialize [
	super initialize.

	condition := [ :anAnnouncement | true ].
]

{ #category : #subscriptions }
GtPhlowAsyncUpdateWithConditionDefinition >> subscribeOn: aGtPhlowElementContext [
	self announcerDo: [ :anAnnouncer |
		anAnnouncer weak
			when: (self announcement where: self condition)
			do: (WeakMessageSend receiver: aGtPhlowElementContext selector: #asyncUpdate) ]
]
