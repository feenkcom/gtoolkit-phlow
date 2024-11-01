Class {
	#name : #GtPhlowChangeAnnouncerListener,
	#superclass : #Object,
	#instVars : [
		'element',
		'elementFuture',
		'subscriptions'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #factory }
GtPhlowChangeAnnouncerListener class >> installOn: anElement announcer: anAnnouncer announcement: anAnnouncement [
	| aListener |
	aListener := anElement userData
			at: GtPhlowChangeAnnouncerListener
			ifAbsentPut: [ self new element: anElement ].

	aListener installAnnouncer: anAnnouncer announcement: anAnnouncement.
	^ aListener
]

{ #category : #accessing }
GtPhlowChangeAnnouncerListener >> configuration: aFutureExecutionConfiguration [
	elementFuture executionConfiguration: aFutureExecutionConfiguration
]

{ #category : #initialization }
GtPhlowChangeAnnouncerListener >> defaultConfiguration [
	^ GtPhlowUtility defaultFutureExecutionConfiguration
]

{ #category : #accessing }
GtPhlowChangeAnnouncerListener >> element [
	^ element
]

{ #category : #accessing }
GtPhlowChangeAnnouncerListener >> element: anElement [
	self
		assert: [ element isNil ]
		description: [ 'Element is already initialized' ].

	element := anElement.
	elementFuture element: anElement
]

{ #category : #'gt - extensions' }
GtPhlowChangeAnnouncerListener >> gtSubscriptionsFor: aView [
	<gtView>
	subscriptions ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Subscriptions';
		priority: 50;
		items: [ subscriptions select: #isNotNil ];
		actionUpdateButtonTooltip: 'Update subscription list';
		column: 'Announcement'
			text: [ :aSubscription | aSubscription announcementClass ];
		column: 'Kind' text: [ :aSubscription | aSubscription class ]
]

{ #category : #initialization }
GtPhlowChangeAnnouncerListener >> initialize [
	super initialize.
	subscriptions := WeakArray empty.
	elementFuture := BrAsyncElementFuture new
			cancelSoft;
			executionConfiguration: self defaultConfiguration;
			whenSuccess: [ :anElement :anObject | "do nothing" ]
]

{ #category : #'api - subscriptions' }
GtPhlowChangeAnnouncerListener >> installAnnouncer: anAnnouncer announcement: anAnnouncement [
	| aSubscription |
	self
		assert: [ self element isNotNil ]
		description: [ 'Element must be initialized' ].
	aSubscription := anAnnouncer weak
			when: anAnnouncement
			send: #onAnnouncement:
			to: self.
			
	"We do not need to collect subscriptions.
	We do it just for an explainability purpose."
	subscriptions := WeakArray
		new: subscriptions size + 1
		streamContents: [ :aStream | 
			aStream
				nextPutAll: subscriptions;
				nextPut: aSubscription ]
]

{ #category : #'event handling' }
GtPhlowChangeAnnouncerListener >> onAnnouncement: anAnnouncement [
	element ifNil: [ ^ self ].
	elementFuture future: ([ self updateElement ] asAsyncFuture delayed: 200 milliSeconds)
]

{ #category : #'private - updating' }
GtPhlowChangeAnnouncerListener >> updateElement [
	| aPhlowView |
	aPhlowView := self element phlow entity.
	aPhlowView ifNil: [ ^ self ].
	aPhlowView updateContent: self element.
]
