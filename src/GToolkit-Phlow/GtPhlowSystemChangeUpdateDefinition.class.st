"
I am an abstract class.
I add basic support for update definitions that listen to {{gtClass:SystemAnnouncer}}.


"
Class {
	#name : 'GtPhlowSystemChangeUpdateDefinition',
	#superclass : 'GtPhlowUpdateDefinition',
	#instVars : [
		'mutexContexts',
		'contexts',
		'mutexSubscription',
		'isSubscribedToSystem',
		'view'
	],
	#category : 'GToolkit-Phlow-Updating'
}

{ #category : 'testing' }
GtPhlowSystemChangeUpdateDefinition class >> isAbstract [
	^ self name = #GtPhlowSystemChangeUpdateDefinition 
]

{ #category : 'adding/removing' }
GtPhlowSystemChangeUpdateDefinition >> addContext: aGtPhlowElementContext [
	mutexContexts critical: [ 
		self contexts: (self contexts copyWith: aGtPhlowElementContext) ]
]

{ #category : 'accessing' }
GtPhlowSystemChangeUpdateDefinition >> contexts [
	^ mutexContexts critical: [ contexts ]
]

{ #category : 'accessing' }
GtPhlowSystemChangeUpdateDefinition >> contexts: anArray [
	mutexContexts critical: [ contexts := anArray ]
]

{ #category : 'defaults' }
GtPhlowSystemChangeUpdateDefinition >> defaultContexts [
	^ Array empty
]

{ #category : 'api - view' }
GtPhlowSystemChangeUpdateDefinition >> definingMethod [
	<return: #RGMethodDefinition>
	^ self view definingMethod
]

{ #category : 'testing' }
GtPhlowSystemChangeUpdateDefinition >> hasContexts [
	<return: #Boolean>
	^ self contexts isEmptyOrNil not
]

{ #category : 'api - view' }
GtPhlowSystemChangeUpdateDefinition >> hasDefiningMethod [
	<return: #Boolean>
	^ self definingMethod isNotNil
]

{ #category : 'testing' }
GtPhlowSystemChangeUpdateDefinition >> ifItDoesNotHaveContextsDo: aBlock [
	self hasContexts ifFalse: aBlock
]

{ #category : 'initialization' }
GtPhlowSystemChangeUpdateDefinition >> initialize [
	super initialize.
	mutexSubscription := Mutex new.
	isSubscribedToSystem := false.
	mutexContexts := Mutex new.
	contexts := self defaultContexts.
]

{ #category : 'api - initialization' }
GtPhlowSystemChangeUpdateDefinition >> on: aView [
	super on: aView.
	self view: aView.
]

{ #category : 'adding/removing' }
GtPhlowSystemChangeUpdateDefinition >> removeContext: aGtPhlowElementContext [
	mutexContexts critical: [ 
		self contexts: (self contexts copyWithout: aGtPhlowElementContext) ]
]

{ #category : 'schedulling' }
GtPhlowSystemChangeUpdateDefinition >> scheduleTask: aTask [
	| aCommand |
	aCommand := BlTaskAtPostponedTerminableTask new
		command: aTask;
		pool: BlTktWorkerProvider highUICPUBoundPool;
		beShiftingNotScheduledHandler;
		scheduledTime: BlTime real now + 200 milliSeconds.
	BlTaskAtQueue default schedule: aCommand
]

{ #category : 'subscriptions' }
GtPhlowSystemChangeUpdateDefinition >> setSubscribedIfAlreadySubscribedDo: aBlock [
	| wantEvaluateBlock |
	wantEvaluateBlock := false.
	mutexSubscription critical: [ 
		isSubscribedToSystem 
			ifTrue: [ wantEvaluateBlock := true ]
			ifFalse: [ isSubscribedToSystem := true ] ].
	wantEvaluateBlock ifTrue: [ aBlock ]
]

{ #category : 'private' }
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

{ #category : 'subscriptions' }
GtPhlowSystemChangeUpdateDefinition >> unsubscribeOn: aGtPhlowElementContext [
	mutexContexts critical: [ 
		self removeContext: aGtPhlowElementContext.
		self hasContexts ifTrue: [ ^ self ].
		mutexSubscription critical: [ 
			isSubscribedToSystem := false.
			SystemAnnouncer uniqueInstance unsubscribe: self.
		]
	]
]

{ #category : 'api - view' }
GtPhlowSystemChangeUpdateDefinition >> view [
	<return: #GtPhlowView>
	^ view
]

{ #category : 'api - view' }
GtPhlowSystemChangeUpdateDefinition >> view: aGtPhlowView [
	self
		assert: [ aGtPhlowView isNotNil ]
		description: [ 'Phlow view must be non-nil' ].
	view := aGtPhlowView
]
