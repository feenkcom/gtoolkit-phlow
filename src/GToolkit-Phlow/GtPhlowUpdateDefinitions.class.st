Class {
	#name : #GtPhlowUpdateDefinitions,
	#superclass : #Object,
	#instVars : [
		'definitions'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'api - adding' }
GtPhlowUpdateDefinitions >> add: aDefinition [
	self definitions add: aDefinition.
]

{ #category : #'api - adding' }
GtPhlowUpdateDefinitions >> asyncWhen: anAnnouncement if: anIfCondition in: anAnnouncer [
	self
		add: (GtPhlowUpdateOnAnnouncement new
				announcement: anAnnouncement;
				condition: anIfCondition;
				announcer: anAnnouncer)
]

{ #category : #'api - adding' }
GtPhlowUpdateDefinitions >> asyncWhen: anAnnouncement in: anAnnouncer [
	self add: (GtPhlowUpdateOnAnnouncement new
		announcement: anAnnouncement;
		announcer: anAnnouncer).
]

{ #category : #copying }
GtPhlowUpdateDefinitions >> copyAutoUpdatesFrom: aGtPhlowUpdateDefinitions [
	aGtPhlowUpdateDefinitions definitions do: [ :eachDefinition | 
		self add: eachDefinition ]
]

{ #category : #accessing }
GtPhlowUpdateDefinitions >> definitions [
	^ definitions
]

{ #category : #accessing }
GtPhlowUpdateDefinitions >> definitions: anObject [
	definitions := anObject
]

{ #category : #initialization }
GtPhlowUpdateDefinitions >> initialize [
	super initialize.
	definitions := OrderedCollection new: 1.
]

{ #category : #subscriptions }
GtPhlowUpdateDefinitions >> installAutoUpdatesOn: anElement [
	self definitions do: [ :eachDefinition | 
		eachDefinition installOn: anElement ]
]

{ #category : #'api - removing' }
GtPhlowUpdateDefinitions >> removeOfClass: aClass [
	self definitions 
		removeAllSuchThat: [ :eachDefinition | 
			eachDefinition class = aClass ]
]

{ #category : #accessing }
GtPhlowUpdateDefinitions >> removeUpdateOnMethodChanged [
	self definitions removeAllSuchThat: [ :eachDefinition | 
		| aResult | 
		aResult := eachDefinition isUpdateOnMethodChanged.
		aResult ifTrue: [ eachDefinition uninstall ].
		aResult ]
]

{ #category : #copying }
GtPhlowUpdateDefinitions >> size [
	^ self definitions size
]

{ #category : #subscriptions }
GtPhlowUpdateDefinitions >> subscribeAutoUpdatesOn: aGtPhlowElementContext [
	self definitions do: [ :eachDefinition | 
		eachDefinition subscribeOn: aGtPhlowElementContext ]
]

{ #category : #'api - adding' }
GtPhlowUpdateDefinitions >> syncWhen: anAnnouncement in: anAnnouncer [
	self add: (GtPhlowSyncUpdateDefinition new
		announcement: anAnnouncement;
		announcer: anAnnouncer)
]

{ #category : #subscriptions }
GtPhlowUpdateDefinitions >> unsubscribeAutoUpdatesOn: aGtPhlowElementContext [
	self definitions do: [ :eachDefinition | 
		eachDefinition unsubscribeOn: aGtPhlowElementContext ]
]
