Class {
	#name : #GtPhlowUpdateCompositeSubViewsOnMethodDefinitionChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'announcement handling' }
GtPhlowUpdateCompositeSubViewsOnMethodDefinitionChange >> handleMethodModifiedAnnouncement: aMethodModified [ 
	self contexts ifNil: [ ^ self ].
	self contexts ifEmpty: [ ^ self ].
	self views do: [ :eachView | 
		(eachView definingMethod gtPhlowIncludesCompiledMethod: aMethodModified methodAffected) ifTrue: [ 
			self updateSubView: eachView ] ].
]

{ #category : #testing }
GtPhlowUpdateCompositeSubViewsOnMethodDefinitionChange >> isInterestingDefinition: aMethodAffected inClass: aClassAffected [
	self views anySatisfy: [ :eachView | 
		eachView definingMethod gtPhlowIncludesCompiledMethod: aMethodAffected ]
]

{ #category : #subscriptions }
GtPhlowUpdateCompositeSubViewsOnMethodDefinitionChange >> subscribeOn: aGtPhlowElementContext [
	self addContext: aGtPhlowElementContext.
	self
		subscribeAnnouncement: MethodModified
		send: #handleMethodModifiedAnnouncement:
		subscriber: aGtPhlowElementContext
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewsOnMethodDefinitionChange >> updateSubView: aGtPhlowView [
	self contexts do: [ :eachContext | 
		self updateSubView: aGtPhlowView inContext: eachContext ].
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewsOnMethodDefinitionChange >> updateSubView: aGtPhlowView inContext: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowUpdateCompositeSubViewTitle new
		elementContext: aGtPhlowElementContext;
		subView: aGtPhlowView)
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewsOnMethodDefinitionChange >> views [
	<return: #Array of: #GtPhlowView>
	^ self contexts anyOne entity views
]
