Class {
	#name : #GtPhlowUpdateOnViewMethodDefinitionChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'announcement handling' }
GtPhlowUpdateOnViewMethodDefinitionChange >> handleMethodModifiedAnnouncement: aMethodModified [ 
	self contexts ifNil: [ ^ self ].
	self contexts ifEmpty: [ ^ self ].
	self definingMethod ifNil: [ ^ self ].
	(self definingMethod gtPhlowIncludesCompiledMethod: aMethodModified methodAffected)
		ifFalse: [ ^ self ].
	self updatePhlowViews.
]

{ #category : #subscriptions }
GtPhlowUpdateOnViewMethodDefinitionChange >> subscribeOn: aGtPhlowElementContext [
	aGtPhlowElementContext definingMethod ifNil: [ ^ self ].
	self addContext: aGtPhlowElementContext.
	self
		subscribeAnnouncement: MethodModified
		send: #handleMethodModifiedAnnouncement:
		subscriber: aGtPhlowElementContext
]

{ #category : #updating }
GtPhlowUpdateOnViewMethodDefinitionChange >> updatePhlowView: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowUpdateElementContext new
		elementContext: aGtPhlowElementContext)
]

{ #category : #updating }
GtPhlowUpdateOnViewMethodDefinitionChange >> updatePhlowViews [
	self contexts do: [ :eachContext | 
		eachContext hasBuildContext ifTrue: [ 
			self updatePhlowView: eachContext ] ].
]
