"
I listen to system changes.
I udpate a ${class:GtPhlowLabelledView}$ and a corresponding ${class:BlElement}$ label on class definition changes.
See ${class:GtPhlowUpdateLabelledViewTitle}$ for more details.

"
Class {
	#name : #GtPhlowUpdateLabeledOnClassAndSuperClassChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#traits : 'TGtPhlowObservedClassAccessors',
	#classTraits : 'TGtPhlowObservedClassAccessors classTrait',
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

{ #category : #subscriptions }
GtPhlowUpdateLabeledOnClassAndSuperClassChange >> subscribeToSystemOn: aGtPhlowElementContext [
	self
		subscribeAnnouncement: MethodAnnouncement, ClassAnnouncement
		send: #handleAnnouncement:
		subscriber: self
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
