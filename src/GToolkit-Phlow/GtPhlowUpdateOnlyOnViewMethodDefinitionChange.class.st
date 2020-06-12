Class {
	#name : #GtPhlowUpdateOnlyOnViewMethodDefinitionChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#instVars : [
		'contexts'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #adding }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> addContext: aGtPhlowElementContext [
	self contexts: (self contexts copyWith: aGtPhlowElementContext)
]

{ #category : #accessing }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> contexts [
	^ contexts
]

{ #category : #accessing }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> contexts: anObject [
	contexts := anObject
]

{ #category : #defaults }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> defaultContexts [
	^ Array empty
]

{ #category : #accessing }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> definingMethod [
	^ self contexts anyOne definingMethod
]

{ #category : #'announcement handling' }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> handleMethodAnnouncement: aMethodModified [ 
	self contexts ifEmpty: [ ^ self ].
	(self definingMethod gtPhlowIncludesCompiledMethod: aMethodModified methodAffected)
		ifFalse: [ ^ self ].
	self updatePhlowViews.
]

{ #category : #initialization }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> initialize [
	super initialize.
	contexts := self defaultContexts.
]

{ #category : #private }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> subscribeAnnouncement: anAnnouncement send: aMethodSelector to: anObject subscriber: aGtPhlowElementContext [
	| anAction aSubscription |
	anAction := WeakMessageSend receiver: anObject selector: aMethodSelector.
	aSubscription := WeakAnnouncementSubscription new 
		announcer: SystemAnnouncer uniqueInstance;
		announcementClass: anAnnouncement;
		action: anAction;
		subscriber: aGtPhlowElementContext.
	 SystemAnnouncer uniqueInstance basicSubscribe: aSubscription.
	
]

{ #category : #subscriptions }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> subscribeOn: aGtPhlowElementContext [
	self addContext: aGtPhlowElementContext.
	self 
		subscribeAnnouncement: MethodAnnouncement - MethodRemoved 
		send: #handleMethodAnnouncement: 
		to: self 
		subscriber: aGtPhlowElementContext.
	"aSubscription := aBuilder
		when: MethodRemoved
		send: #handleMethodRemovedAnnouncement:
		to: self.
	aSubscription subscriber: aGtPhlowElementContext."

]

{ #category : #subscriptions }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> unsubscribeOn: aGtPhlowElementContext [
	self contexts: (self contexts copyWithout: aGtPhlowElementContext).
	SystemAnnouncer uniqueInstance unsubscribe: aGtPhlowElementContext.
]

{ #category : #updating }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> updatePhlowView: aGtPhlowElementContext [
	aGtPhlowElementContext hasBuildContext.
	self scheduleTask: (GtPhlowUpdateElementContext new
		elementContext: aGtPhlowElementContext)
]

{ #category : #updating }
GtPhlowUpdateOnlyOnViewMethodDefinitionChange >> updatePhlowViews [
	self contexts do: [ :eachContext | 
		self updatePhlowView: eachContext ].
]
