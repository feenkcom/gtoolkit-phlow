Class {
	#name : #GtPhlowSystemChangeUpdateDefinition,
	#superclass : #GtPhlowUpdateDefinition,
	#instVars : [
		'contexts'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #testing }
GtPhlowSystemChangeUpdateDefinition class >> isAbstract [
	^ self name = #GtPhlowSystemChangeUpdateDefinition 
]

{ #category : #adding }
GtPhlowSystemChangeUpdateDefinition >> addContext: aGtPhlowElementContext [
	self contexts ifNil: [ ^ self ].
	self contexts: (self contexts copyWith: aGtPhlowElementContext)
]

{ #category : #accessing }
GtPhlowSystemChangeUpdateDefinition >> contexts [
	^ contexts
]

{ #category : #accessing }
GtPhlowSystemChangeUpdateDefinition >> contexts: anObject [
	contexts := anObject
]

{ #category : #defaults }
GtPhlowSystemChangeUpdateDefinition >> defaultContexts [
	^ Array empty
]

{ #category : #accessing }
GtPhlowSystemChangeUpdateDefinition >> definingMethod [
	^ self contexts anyOne definingMethod
]

{ #category : #initialization }
GtPhlowSystemChangeUpdateDefinition >> initialize [
	super initialize.
	contexts := self defaultContexts.
]

{ #category : #schedulling }
GtPhlowSystemChangeUpdateDefinition >> scheduleTask: aTask [
	| aCommand |
	aCommand := BlTaskAtPostponedTerminableTask new
		command: aTask;
		pool: BlTktWorkerProvider highUICPUBoundPool;
		beShiftingNotScheduledHandler;
		scheduledTime: BlTime real now + 200 milliSeconds.
	BlTaskAtQueue default schedule: aCommand
]

{ #category : #private }
GtPhlowSystemChangeUpdateDefinition >> subscribeAnnouncement: anAnnouncement send: aMethodSelector subscriber: aGtPhlowElementContext [
	| anAction aSubscription |
	anAction := WeakMessageSend receiver: self selector: aMethodSelector.
	aSubscription := WeakAnnouncementSubscription new 
		announcer: SystemAnnouncer uniqueInstance;
		announcementClass: anAnnouncement;
		action: anAction;
		subscriber: aGtPhlowElementContext.
	 SystemAnnouncer uniqueInstance basicSubscribe: aSubscription.
	
]

{ #category : #subscriptions }
GtPhlowSystemChangeUpdateDefinition >> unsubscribeOn: aGtPhlowElementContext [
	self contexts ifNil: [ ^ self ].
	self contexts: (self contexts copyWithout: aGtPhlowElementContext).
	SystemAnnouncer uniqueInstance unsubscribe: aGtPhlowElementContext.
]
