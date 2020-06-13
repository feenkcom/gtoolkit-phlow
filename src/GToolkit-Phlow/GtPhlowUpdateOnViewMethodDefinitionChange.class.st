Class {
	#name : #GtPhlowUpdateOnViewMethodDefinitionChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'announcement handling' }
GtPhlowUpdateOnViewMethodDefinitionChange >> handleMethodModifiedAnnouncement: aMethodModified [ 
	self contexts ifNil: [ ^ self ].
	self contexts ifEmpty: [ ^ self ].
	(self definingMethod gtPhlowIncludesCompiledMethod: aMethodModified methodAffected)
		ifFalse: [ ^ self ].
	self updatePhlowViews.
]

{ #category : #subscriptions }
GtPhlowUpdateOnViewMethodDefinitionChange >> subscribeOn: aGtPhlowElementContext [
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
