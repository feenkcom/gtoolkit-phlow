Class {
	#name : #GtPhlowUpdateOnViewMethodChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'announcement handling' }
GtPhlowUpdateOnViewMethodChange >> handleMethodModifiedAnnouncement: aMethodModified [ 
	self hasContexts ifFalse: [ ^ self ].
	self definingMethod ifNil: [ ^ self ].
	(self definingMethod gtPhlowIncludesCompiledMethod: aMethodModified methodAffected)
		ifFalse: [ ^ self ].
	self updatePhlowViews.
]

{ #category : #subscriptions }
GtPhlowUpdateOnViewMethodChange >> subscribeOn: aGtPhlowElementContext [
	aGtPhlowElementContext definingMethod ifNil: [ ^ self ].
	self addContext: aGtPhlowElementContext.
	self setSubscribedIfAlreadySubscribedDo: [ ^ self ].
	self
		subscribeAnnouncement: MethodModified
		send: #handleMethodModifiedAnnouncement:
		subscriber: self
]

{ #category : #updating }
GtPhlowUpdateOnViewMethodChange >> updatePhlowView: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowUpdateElementContext new
		elementContext: aGtPhlowElementContext)
]

{ #category : #updating }
GtPhlowUpdateOnViewMethodChange >> updatePhlowViews [
	self contexts do: [ :eachContext | 
		eachContext hasBuildContext ifTrue: [ 
			self updatePhlowView: eachContext ] ].
]
