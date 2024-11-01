Class {
	#name : #GtPhlowClassPragmaChangeListener,
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
GtPhlowClassPragmaChangeListener class >> installOn: aTabGroup [
]

{ #category : #factory }
GtPhlowClassPragmaChangeListener class >> installOnCompositeElement: aTabGroup [
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
			
	aTabGroup userData at: GtPhlowClassPragmaChangeListener put: aListener.
	^ aListener
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> actionExecutor [
	^ actionExecutor
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> actionExecutor: anActionExecutor [
	actionExecutor := anActionExecutor
]

{ #category : #initialization }
GtPhlowClassPragmaChangeListener >> initialize [
	super initialize.
	interestCondition := GtPhlowChangeLackOfInterestCondition default.
	isSubscribedToSystem := false.
	actionExecutor := GtPhlowChangeBasicActionExecutor default.
	onMethodAddedAction := GtPhlowChangeNoAction default.
	onMethodRemovedAction := GtPhlowChangeNoAction default.
	onMethodModifiedAction := GtPhlowChangeNoAction default.
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> interestingClass: aClass [
	self interestingClasses: { aClass }
]

{ #category : #accessing }
GtPhlowClassPragmaChangeListener >> interestingClasses: aCollection [
	interestCondition := GtPhlowChangeClassesAndSuperclassesInterestCondition new
		classes: aCollection
]

{ #category : #'api - initialization' }
GtPhlowClassPragmaChangeListener >> interestingPragma: aSymbol [
	self interestingPragmas: { aSymbol }
]

{ #category : #'api - initialization' }
GtPhlowClassPragmaChangeListener >> interestingPragmas: aCollectionOfSymbols [
	interestCondition := GtPhlowChangePragmasInterestCondition new 
	 		pragmas: aCollectionOfSymbols
]

{ #category : #'api - initialization' }
GtPhlowClassPragmaChangeListener >> interestingPragmas: aCollectionOfPragmas andObject: anObject [
	interestCondition := GtPhlowChangeAndInterestCondition new
	 	left: (GtPhlowChangePragmasInterestCondition new 
	 		pragmas: aCollectionOfPragmas);
	 	right: (GtPhlowChangeObjectInterestCondition new 
	 		object: anObject)
]

{ #category : #'api - initialization' }
GtPhlowClassPragmaChangeListener >> interestingPragmas: aCollectionOfPragmas andSuperclass: aClass [
	 interestCondition := GtPhlowChangeAndInterestCondition new
	 	left: (GtPhlowChangePragmasInterestCondition new 
	 		pragmas: aCollectionOfPragmas);
	 	right: (GtPhlowChangeClassesAndSubclassesInterestCondition new 
	 		superclass: aClass)
]

{ #category : #testing }
GtPhlowClassPragmaChangeListener >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	^ interestCondition isInterestingClass: anAffectedClass andMethod: anAffectedMethod
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

	actionExecutor
		submit: onMethodAddedAction 
		context: (GtPhlowChangeActionAffectedMethodContext
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
		
	actionExecutor 
		submit: onMethodRemovedAction
		context: (GtPhlowChangeActionAffectedMethodContext
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

{ #category : #subscriptions }
GtPhlowClassPragmaChangeListener >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
