"
I update a view when observed class references are added or removed.
"
Class {
	#name : #GtPhlowUpdateViewOnClassReferenceChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#traits : 'TGtPhlowObservedClassAccessors',
	#classTraits : 'TGtPhlowObservedClassAccessors classTrait',
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'announcement handling' }
GtPhlowUpdateViewOnClassReferenceChange >> handleMethodAnnouncement: aMethodAnnouncement [ 
	self hasContexts ifFalse: [ ^ self ].
	(self hasObservedClassReference: aMethodAnnouncement methodAffected) ifFalse: [ ^ self ].
	self contexts do: [ :eachContext | 
		self updateContextView: eachContext ].
]

{ #category : #testing }
GtPhlowUpdateViewOnClassReferenceChange >> hasObservedClassReference: aMethodAdded [
	<return: #Boolean>
	^ aMethodAdded referencedClasses includes: self observedClass
]

{ #category : #initialization }
GtPhlowUpdateViewOnClassReferenceChange >> initializeObservedClassOn: aGtPhlowView [
	aGtPhlowView hasBuildContext ifFalse: [ ^ self ].
	self observedClass: aGtPhlowView buildContext object class instanceSide.
]

{ #category : #subscriptions }
GtPhlowUpdateViewOnClassReferenceChange >> subscribeToSystemOn: aGtPhlowElementContext [
	self
		subscribeAnnouncement: MethodAnnouncement - MethodRecategorized
		send: #handleMethodAnnouncement:
		subscriber: self.
]

{ #category : #updating }
GtPhlowUpdateViewOnClassReferenceChange >> updateContextView: aGtPhlowElementContext [
	aGtPhlowElementContext asyncUpdate
]
