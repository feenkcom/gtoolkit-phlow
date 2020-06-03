Class {
	#name : #GtPhlowAsyncUpdateWithConditionDefinition,
	#superclass : #GtPhlowAsyncUpdateDefinition,
	#instVars : [
		'condition'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #subscriptions }
GtPhlowAsyncUpdateWithConditionDefinition >> announcementHandlerFor: aGtPhlowElementContext [
	^ [ :anAnnouncement | 
			(self condition cull: anAnnouncement cull: aGtPhlowElementContext) 
				ifTrue: [ (super announcementHandlerFor: aGtPhlowElementContext) cull: anAnnouncement ] ]
]

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
	condition := [ :anAnnouncement :aGtPhlowElementContext | true ].
]
