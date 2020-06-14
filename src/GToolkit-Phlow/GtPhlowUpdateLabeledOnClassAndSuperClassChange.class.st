Class {
	#name : #GtPhlowUpdateLabeledOnClassAndSuperClassChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#instVars : [
		'observedClass'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'announcement handling' }
GtPhlowUpdateLabeledOnClassAndSuperClassChange >> handleAnnouncement: anAnnouncement [
	self hasContexts ifFalse: [ ^ self ].
	(GtSystemUtility 
		isClass: self observedClass
		sameOrSubclassOf: anAnnouncement classAffected) ifFalse: [ ^ self ].
	self updatePhlowViews
]

{ #category : #accessing }
GtPhlowUpdateLabeledOnClassAndSuperClassChange >> observedClass [
	^ observedClass
]

{ #category : #accessing }
GtPhlowUpdateLabeledOnClassAndSuperClassChange >> observedClass: aClass [
	self 
		assert: [ aClass isClass ] 
		description: [ 'Observed class must be a Class' ].
	observedClass := aClass
]

{ #category : #subscriptions }
GtPhlowUpdateLabeledOnClassAndSuperClassChange >> subscribeOn: aGtPhlowElementContext [
	aGtPhlowElementContext hasBuildContext ifFalse: [ ^ self ].
	self observedClass: aGtPhlowElementContext buildContext object class.
	self addContext: aGtPhlowElementContext.
	self
		subscribeAnnouncement: MethodAnnouncement, ClassAnnouncement
		send: #handleAnnouncement:
		subscriber: aGtPhlowElementContext
]

{ #category : #updating }
GtPhlowUpdateLabeledOnClassAndSuperClassChange >> updatePhlowView: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowUpdateLabelledViewTitle new 
		elementContext: aGtPhlowElementContext)
]

{ #category : #updating }
GtPhlowUpdateLabeledOnClassAndSuperClassChange >> updatePhlowViews [
	self contexts do: [ :eachContext | 
		eachContext hasBuildContext ifTrue: [ 
			self updatePhlowView: eachContext ] ].
]
