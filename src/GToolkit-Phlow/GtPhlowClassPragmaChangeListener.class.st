Class {
	#name : #GtPhlowClassPragmaChangeListener,
	#superclass : #Object,
	#instVars : [
		'interestingClasses',
		'interestingPragmas',
		'isSubscribedToSystem',
		'onMethodAddedAction',
		'onMethodRemovedAction',
		'onMethodModifiedAction'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #initialization }
GtPhlowClassPragmaChangeListener >> initialize [
	super initialize.
	interestingClasses := Array empty.
	interestingPragmas := Array empty.
	isSubscribedToSystem := false.
	onMethodAddedAction := GtPhlowChangeNoAction default.
	onMethodRemovedAction := GtPhlowChangeNoAction default.
	onMethodModifiedAction := GtPhlowChangeNoAction default.
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> interestingClass: aSymbol [
	self interestingClasses: (self interestingClasses copyWith: aSymbol)
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> interestingClasses [
	<return: #Array of: #Behavior>
	^ interestingClasses
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> interestingClasses: aCollection [
	interestingClasses := aCollection
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> interestingPragma: aSymbol [
	self interestingPragmas: (self interestingPragmas copyWith: aSymbol)
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> interestingPragmas [
	<return: #Array of: #Symbol>
	^ interestingPragmas
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> interestingPragmas: aCollection [
	interestingPragmas := aCollection
]

{ #category : #testing }
GtPhlowClassPragmaChangeListener >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	(self interestingClasses anySatisfy: [ :eachClass | 
		GtSystemUtility 
			isClass: anAffectedClass 
			sameOrSubclassOf: eachClass ])
		ifFalse: [ ^ false ].

	^ self interestingPragmas
		anySatisfy: [ :eachSymbol | anAffectedMethod hasPragmaNamed: eachSymbol ]
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> onMethodAddedAction [
	^ onMethodAddedAction
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> onMethodAddedAction: anObject [
	onMethodAddedAction := anObject
]

{ #category : #'event handling' }
GtPhlowClassPragmaChangeListener >> onMethodAddedAnnouncement: aMethodAdded [
	(self
		isInterestingClass: aMethodAdded classAffected
		andMethod: aMethodAdded methodAdded) ifFalse: [ ^ self ].

	onMethodAddedAction
		actOn: (GtPhlowChangeActionAffectedMethodContext
				forAffectedClass: aMethodAdded classAffected
				affectedMethod: aMethodAdded methodAdded)
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> onMethodModifiedAction [
	^ onMethodModifiedAction
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> onMethodModifiedAction: anObject [
	onMethodModifiedAction := anObject
]

{ #category : #'event handling' }
GtPhlowClassPragmaChangeListener >> onMethodModifiedAnnouncement: aMethodModified [
	(self
		isInterestingClass: aMethodModified classAffected
		andMethod: aMethodModified methodAffected) ifFalse: [ ^ self ].

	onMethodAddedAction
		actOn: (GtPhlowChangeActionAffectedMethodContext
				forAffectedClass: aMethodModified classAffected
				affectedMethod: aMethodModified methodAffected)
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> onMethodRemovedAction [
	^ onMethodRemovedAction
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> onMethodRemovedAction: anObject [
	onMethodRemovedAction := anObject
]

{ #category : #'event handling' }
GtPhlowClassPragmaChangeListener >> onMethodRemovedAnnouncement: aMethodRemoved [
	(self
		isInterestingClass: aMethodRemoved classAffected
		andMethod: aMethodRemoved methodRemoved) ifFalse: [ ^ self ].
		
	onMethodRemovedAction
		actOn: (GtPhlowChangeActionAffectedMethodContext
				forAffectedClass: aMethodRemoved classAffected
				affectedMethod: aMethodRemoved methodRemoved)
]

{ #category : #subscriptions }
GtPhlowClassPragmaChangeListener >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded
			send: #onMethodAddedAnnouncement:
			to: self;
		when: MethodRemoved
			send: #onMethodRemovedAnnouncement:
			to: self;
		when: MethodModified
			send: #onMethodModifiedAnnouncement:
			to: self
]
