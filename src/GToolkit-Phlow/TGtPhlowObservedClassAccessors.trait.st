Trait {
	#name : #TGtPhlowObservedClassAccessors,
	#instVars : [
		'observedClass'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #testing }
TGtPhlowObservedClassAccessors >> hasObservedClass [
	^ self observedClass isNotNil.
]

{ #category : #testing }
TGtPhlowObservedClassAccessors >> ifItDoesNotHaveObservedClassDo: aBlock [
	self hasObservedClass ifFalse: aBlock
]

{ #category : #initialization }
TGtPhlowObservedClassAccessors >> initializeObservedClassOn: aGtPhlowElementContext [
	aGtPhlowElementContext hasBuildContext ifFalse: [ ^ self ].
	self observedClass: aGtPhlowElementContext buildContext object class instanceSide.
]

{ #category : #accessing }
TGtPhlowObservedClassAccessors >> observedClass [
	^ observedClass
]

{ #category : #accessing }
TGtPhlowObservedClassAccessors >> observedClass: aClass [
	self 
		assert: [ aClass isClass ]
		description: [ 'Observed class must be a class' ].
	observedClass := aClass
]

{ #category : #'api - subscriptions' }
TGtPhlowObservedClassAccessors >> subscribeOn: aGtPhlowElementContext [
	aGtPhlowElementContext hasBuildContext ifFalse: [ ^ self ].
	self addContext: aGtPhlowElementContext.
	self setSubscribedIfAlreadySubscribedDo: [ ^ self ].
	self initializeObservedClassOn: aGtPhlowElementContext.
	self subscribeToSystemOn: aGtPhlowElementContext.
]

{ #category : #subscriptions }
TGtPhlowObservedClassAccessors >> subscribeToSystemOn: aGtPhlowElementContext [
	self explicitRequirement
]
