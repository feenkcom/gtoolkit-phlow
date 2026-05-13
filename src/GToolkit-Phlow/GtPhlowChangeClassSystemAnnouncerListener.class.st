Class {
	#name : #GtPhlowChangeClassSystemAnnouncerListener,
	#superclass : #GtPhlowChangeMethodSystemAnnouncerListener,
	#instVars : [
		'onClassAddedAction',
		'onClassRemovedAction',
		'onClassModifiedAction'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #factory }
GtPhlowChangeClassSystemAnnouncerListener class >> installOnLabelledElement: anElement [
	| aListener aView aBuildContext aUserDataKey anAction |
	aUserDataKey := GtPhlowChangeClassSystemAnnouncerListener class
			>> #installOnLabelledElement:.
	anElement userData
		at: aUserDataKey
		ifPresent: [ :theListener | ^ theListener ]
		ifAbsent: [ "ignore" ].
	
	aView := anElement phlow entity ifNil: [ ^ nil ].
	(aView isKindOf: GtPhlowLabelledView) ifFalse: [ ^ nil ].
	aBuildContext := aView buildContext.
	aBuildContext isBuildContext ifFalse: [ ^ nil ].
	
	anAction := GtPhlowChangeUpdateLabelledElementLabelAction new element: anElement.
	aListener := self new
			interestingObject: aBuildContext object;
			actionExecutor: (GtPhlowChangeSingleElementActionExecutor new element: anElement);
			onMethodAddedAction: anAction;
			onMethodRemovedAction: anAction;
			onMethodModifiedAction: anAction;
			onClassAddedAction: anAction;
			onClassRemovedAction: anAction;
			onClassModifiedAction: anAction;
			subscribeToSystem.

	anElement userData at: aUserDataKey put: aListener.
	^ aListener
]

{ #category : #'as yet unclassified' }
GtPhlowChangeClassSystemAnnouncerListener >> initialize [
	super initialize.
	onClassAddedAction := GtPhlowChangeNoAction default.
	onClassRemovedAction := GtPhlowChangeNoAction default.
	onClassModifiedAction := GtPhlowChangeNoAction default.
]

{ #category : #testing }
GtPhlowChangeClassSystemAnnouncerListener >> isInterestingClass: anAffectedClass [
	^ interestCondition isInterestingClass: anAffectedClass
]

{ #category : #accessing }
GtPhlowChangeClassSystemAnnouncerListener >> onClassAddedAction [
	^ onClassAddedAction
]

{ #category : #accessing }
GtPhlowChangeClassSystemAnnouncerListener >> onClassAddedAction: anObject [
	onClassAddedAction := anObject
]

{ #category : #'event handling' }
GtPhlowChangeClassSystemAnnouncerListener >> onClassAddedAnnouncement: aClassAdded [
	(self isInterestingClass: aClassAdded classAffected) 
		ifFalse: [ ^ self ].

	actionExecutor
		submit: onClassAddedAction 
		context: (GtPhlowChangeActionAffectedClassContext
			forAffectedClass: aClassAdded classAffected)
]

{ #category : #accessing }
GtPhlowChangeClassSystemAnnouncerListener >> onClassModifiedAction [
	^ onClassModifiedAction
]

{ #category : #accessing }
GtPhlowChangeClassSystemAnnouncerListener >> onClassModifiedAction: anObject [
	onClassModifiedAction := anObject
]

{ #category : #'event handling' }
GtPhlowChangeClassSystemAnnouncerListener >> onClassModifiedAnnouncement: aClassModified [
	(self isInterestingClass: aClassModified classAffected) 
		ifFalse: [ ^ self ].

	actionExecutor
		submit: onClassModifiedAction
		context: (GtPhlowChangeActionAffectedClassContext
				forAffectedClass: aClassModified classAffected)
]

{ #category : #accessing }
GtPhlowChangeClassSystemAnnouncerListener >> onClassRemovedAction [
	^ onClassRemovedAction
]

{ #category : #accessing }
GtPhlowChangeClassSystemAnnouncerListener >> onClassRemovedAction: anObject [
	onClassRemovedAction := anObject
]

{ #category : #'event handling' }
GtPhlowChangeClassSystemAnnouncerListener >> onClassRemovedAnnouncement: aClassRemoved [
	(self isInterestingClass: aClassRemoved classAffected) 
		ifFalse: [ ^ self ].

	actionExecutor
		submit: onClassRemovedAction
		context: (GtPhlowChangeActionAffectedClassContext
				forAffectedClass: aClassRemoved classAffected)
]

{ #category : #subscriptions }
GtPhlowChangeClassSystemAnnouncerListener >> subscribeToClassChanges [
	SystemAnnouncer uniqueInstance weak
		when: ClassAdded
			send: #onClassAddedAnnouncement:
			to: self;
		when: ClassRemoved
			send: #onClassRemovedAnnouncement:
			to: self;
		when: ClassRenamed, ClassModificationApplied
			send: #onClassModifiedAnnouncement:
			to: self
]

{ #category : #subscriptions }
GtPhlowChangeClassSystemAnnouncerListener >> subscribeToSystem [
	super subscribeToSystem.
	self subscribeToClassChanges
]
