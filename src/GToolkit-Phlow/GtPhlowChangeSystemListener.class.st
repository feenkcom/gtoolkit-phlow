Class {
	#name : #GtPhlowChangeSystemListener,
	#superclass : #Object,
	#instVars : [
		'isSubscribedToSystem',
		'onMethodAddedAction',
		'onMethodRemovedAction',
		'onMethodModifiedAction',
		'interestCondition',
		'actionExecutor'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #factory }
GtPhlowChangeSystemListener class >> installOn: aTabGroup [
]

{ #category : #factory }
GtPhlowChangeSystemListener class >> installOnCompositeElement: aTabGroup [
	| aListener aCompositeView aBuildContext |
	aCompositeView := aTabGroup phlow entity ifNil: [ ^ nil ].
	aBuildContext := aCompositeView buildContext.
	aBuildContext isBuildContext ifFalse: [ ^ nil ].
	
	aListener := self new
		interestingPragmas: GtPhlowViewsCollector defaultViewPragmaNames 
			andObject: aBuildContext object;
		actionExecutor: (GtPhlowChangeTabGroupActionExecutor new 
			tabGroup: aTabGroup);
		onMethodAddedAction: (GtPhlowChangeTabGroupAddTabAction new
			tabGroup: aTabGroup;
			buildContext: aBuildContext);
		onMethodRemovedAction: (GtPhlowChangeTabGroupRemoveTabAction new
			tabGroup: aTabGroup);
		onMethodModifiedAction: (GtPhlowChangeTabGroupModifyTabAction new
			tabGroup: aTabGroup;
			buildContext: aBuildContext);
		subscribeToSystem.
			
	aTabGroup userData at: GtPhlowChangeSystemListener put: aListener.
	^ aListener
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> actionExecutor [
	^ actionExecutor
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> actionExecutor: anActionExecutor [
	actionExecutor := anActionExecutor
]

{ #category : #initialization }
GtPhlowChangeSystemListener >> initialize [
	super initialize.
	interestCondition := GtPhlowChangeLackOfInterestCondition default.
	isSubscribedToSystem := false.
	actionExecutor := GtPhlowChangeBasicActionExecutor default.
	onMethodAddedAction := GtPhlowChangeNoAction default.
	onMethodRemovedAction := GtPhlowChangeNoAction default.
	onMethodModifiedAction := GtPhlowChangeNoAction default.
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> interestingClass: aClass [
	self interestingClasses: { aClass }
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> interestingClasses: aCollection [
	interestCondition := GtPhlowChangeClassesAndSuperclassesInterestCondition new
		classes: aCollection
]

{ #category : #'api - initialization' }
GtPhlowChangeSystemListener >> interestingPragma: aSymbol [
	self interestingPragmas: { aSymbol }
]

{ #category : #'api - initialization' }
GtPhlowChangeSystemListener >> interestingPragmas: aCollectionOfSymbols [
	interestCondition := GtPhlowChangePragmasInterestCondition new 
	 		pragmas: aCollectionOfSymbols
]

{ #category : #'api - initialization' }
GtPhlowChangeSystemListener >> interestingPragmas: aCollectionOfPragmas andObject: anObject [
	interestCondition := GtPhlowChangeAndInterestCondition new
	 	left: (GtPhlowChangePragmasInterestCondition new 
	 		pragmas: aCollectionOfPragmas);
	 	right: (GtPhlowChangeObjectInterestCondition new 
	 		object: anObject)
]

{ #category : #'api - initialization' }
GtPhlowChangeSystemListener >> interestingPragmas: aCollectionOfPragmas andSuperclass: aClass [
	 interestCondition := GtPhlowChangeAndInterestCondition new
	 	left: (GtPhlowChangePragmasInterestCondition new 
	 		pragmas: aCollectionOfPragmas);
	 	right: (GtPhlowChangeClassesAndSubclassesInterestCondition new 
	 		superclass: aClass)
]

{ #category : #testing }
GtPhlowChangeSystemListener >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	^ interestCondition isInterestingClass: anAffectedClass andMethod: anAffectedMethod
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> onMethodAddedAction [
	^ onMethodAddedAction
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> onMethodAddedAction: anObject [
	onMethodAddedAction := anObject
]

{ #category : #'event handling' }
GtPhlowChangeSystemListener >> onMethodAddedAnnouncement: aMethodAdded [
	(self
		isInterestingClass: aMethodAdded classAffected
		andMethod: aMethodAdded methodAdded) ifFalse: [ ^ self ].

	actionExecutor
		submit: onMethodAddedAction 
		context: (GtPhlowChangeActionAffectedMethodContext
			forAffectedClass: aMethodAdded classAffected
			affectedMethod: aMethodAdded methodAdded)
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> onMethodModifiedAction [
	^ onMethodModifiedAction
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> onMethodModifiedAction: anObject [
	onMethodModifiedAction := anObject
]

{ #category : #'event handling' }
GtPhlowChangeSystemListener >> onMethodModifiedAnnouncement: aMethodModified [
	(self
		isInterestingClass: aMethodModified classAffected
		andMethod: aMethodModified methodAffected)
		ifTrue: [ 
			actionExecutor
				submit: onMethodModifiedAction
				context: (GtPhlowChangeActionAffectedMethodContext
					forAffectedClass: aMethodModified classAffected
					affectedMethod: aMethodModified methodAffected).
			^ self ].
	
	(self
		isInterestingClass: aMethodModified classAffected
		andMethod: aMethodModified oldMethod) ifFalse: [ ^ self ].
	"The old method has an interesting pragma, while the new method does not have it.
	We therefore remove the method."
	actionExecutor
		submit: onMethodRemovedAction
		context: (GtPhlowChangeActionAffectedMethodContext
			forAffectedClass: aMethodModified classAffected
			affectedMethod: aMethodModified methodAffected)
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> onMethodRemovedAction [
	^ onMethodRemovedAction
]

{ #category : #accessing }
GtPhlowChangeSystemListener >> onMethodRemovedAction: anObject [
	onMethodRemovedAction := anObject
]

{ #category : #'event handling' }
GtPhlowChangeSystemListener >> onMethodRemovedAnnouncement: aMethodRemoved [
	(self
		isInterestingClass: aMethodRemoved classAffected
		andMethod: aMethodRemoved methodRemoved) ifFalse: [ ^ self ].
		
	actionExecutor 
		submit: onMethodRemovedAction
		context: (GtPhlowChangeActionAffectedMethodContext
			forAffectedClass: aMethodRemoved classAffected
			affectedMethod: aMethodRemoved methodRemoved)
]

{ #category : #subscriptions }
GtPhlowChangeSystemListener >> subscribeToSystem [
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

{ #category : #subscriptions }
GtPhlowChangeSystemListener >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
