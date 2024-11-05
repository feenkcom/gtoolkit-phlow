Class {
	#name : #GtPhlowChangeMethodSystemAnnouncerListener,
	#superclass : #Object,
	#instVars : [
		'onMethodAddedAction',
		'onMethodRemovedAction',
		'onMethodModifiedAction',
		'interestCondition',
		'actionExecutor'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #factory }
GtPhlowChangeMethodSystemAnnouncerListener class >> installOnCompositeElement: aTabGroup [
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
			
	aTabGroup userData 
		at: (GtPhlowChangeMethodSystemAnnouncerListener class >> #installOnCompositeElement:) 
		put: aListener.
	^ aListener
]

{ #category : #factory }
GtPhlowChangeMethodSystemAnnouncerListener class >> installOnSingleElement: anElement [
	| aListener aView aBuildContext aDefiningMethod |
	aView := anElement phlow entity ifNil: [ ^ nil ].
	aDefiningMethod := aView definingMethod ifNil: [ ^ nil ].
	aBuildContext := aView buildContext.
	aBuildContext isBuildContext ifFalse: [ ^ nil ].
	
	aListener := self new
		interestingDefiningMethod: aDefiningMethod;
		actionExecutor: (GtPhlowChangeSingleElementActionExecutor new 
			element: anElement);
		onMethodModifiedAction: (GtPhlowChangeReplaceElementAction new
			element: anElement);
		subscribeToSystem.
			
	anElement userData 
		at: (GtPhlowChangeMethodSystemAnnouncerListener class >> #installOnSingleElement:)
		put: aListener.
	^ aListener
]

{ #category : #accessing }
GtPhlowChangeMethodSystemAnnouncerListener >> actionExecutor [
	^ actionExecutor
]

{ #category : #accessing }
GtPhlowChangeMethodSystemAnnouncerListener >> actionExecutor: anActionExecutor [
	actionExecutor := anActionExecutor
]

{ #category : #initialization }
GtPhlowChangeMethodSystemAnnouncerListener >> initialize [
	super initialize.
	interestCondition := GtPhlowChangeLackOfInterestCondition default.
	actionExecutor := GtPhlowChangeBasicActionExecutor default.
	onMethodAddedAction := GtPhlowChangeNoAction default.
	onMethodRemovedAction := GtPhlowChangeNoAction default.
	onMethodModifiedAction := GtPhlowChangeNoAction default.
]

{ #category : #accessing }
GtPhlowChangeMethodSystemAnnouncerListener >> interestingClass: aClass [
	self interestingClasses: { aClass }
]

{ #category : #accessing }
GtPhlowChangeMethodSystemAnnouncerListener >> interestingClasses: aCollection [
	interestCondition := GtPhlowChangeClassesAndSuperclassesInterestCondition new
		classes: aCollection
]

{ #category : #'api - initialization' }
GtPhlowChangeMethodSystemAnnouncerListener >> interestingDefiningMethod: aDefiningMethod [
	interestCondition := GtPhlowChangeDefiningMethodCondition new
			definingMethod: aDefiningMethod
]

{ #category : #'api - initialization' }
GtPhlowChangeMethodSystemAnnouncerListener >> interestingPragma: aSymbol [
	self interestingPragmas: { aSymbol }
]

{ #category : #'api - initialization' }
GtPhlowChangeMethodSystemAnnouncerListener >> interestingPragmas: aCollectionOfSymbols [
	interestCondition := GtPhlowChangePragmasInterestCondition new 
	 		pragmas: aCollectionOfSymbols
]

{ #category : #'api - initialization' }
GtPhlowChangeMethodSystemAnnouncerListener >> interestingPragmas: aCollectionOfPragmas andObject: anObject [
	interestCondition := GtPhlowChangeAndInterestCondition new
	 	left: (GtPhlowChangePragmasInterestCondition new 
	 		pragmas: aCollectionOfPragmas);
	 	right: (GtPhlowChangeObjectInterestCondition new 
	 		object: anObject)
]

{ #category : #'api - initialization' }
GtPhlowChangeMethodSystemAnnouncerListener >> interestingPragmas: aCollectionOfPragmas andSuperclass: aClass [
	 interestCondition := GtPhlowChangeAndInterestCondition new
	 	left: (GtPhlowChangePragmasInterestCondition new 
	 		pragmas: aCollectionOfPragmas);
	 	right: (GtPhlowChangeClassesAndSubclassesInterestCondition new 
	 		superclass: aClass)
]

{ #category : #testing }
GtPhlowChangeMethodSystemAnnouncerListener >> isInterestingClass: anAffectedClass andMethod: anAffectedMethod [
	^ interestCondition isInterestingClass: anAffectedClass andMethod: anAffectedMethod
]

{ #category : #accessing }
GtPhlowChangeMethodSystemAnnouncerListener >> onMethodAddedAction [
	^ onMethodAddedAction
]

{ #category : #accessing }
GtPhlowChangeMethodSystemAnnouncerListener >> onMethodAddedAction: anObject [
	onMethodAddedAction := anObject
]

{ #category : #'event handling' }
GtPhlowChangeMethodSystemAnnouncerListener >> onMethodAddedAnnouncement: aMethodAdded [
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
GtPhlowChangeMethodSystemAnnouncerListener >> onMethodModifiedAction [
	^ onMethodModifiedAction
]

{ #category : #accessing }
GtPhlowChangeMethodSystemAnnouncerListener >> onMethodModifiedAction: anObject [
	onMethodModifiedAction := anObject
]

{ #category : #'event handling' }
GtPhlowChangeMethodSystemAnnouncerListener >> onMethodModifiedAnnouncement: aMethodModified [
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
GtPhlowChangeMethodSystemAnnouncerListener >> onMethodRemovedAction [
	^ onMethodRemovedAction
]

{ #category : #accessing }
GtPhlowChangeMethodSystemAnnouncerListener >> onMethodRemovedAction: anObject [
	onMethodRemovedAction := anObject
]

{ #category : #'event handling' }
GtPhlowChangeMethodSystemAnnouncerListener >> onMethodRemovedAnnouncement: aMethodRemoved [
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
GtPhlowChangeMethodSystemAnnouncerListener >> subscribeToSystem [
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
GtPhlowChangeMethodSystemAnnouncerListener >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
