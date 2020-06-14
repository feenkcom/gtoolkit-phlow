Class {
	#name : #GtPhlowUpdateCompositeSubViewTitlesOnMethodChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'announcement handling' }
GtPhlowUpdateCompositeSubViewTitlesOnMethodChange >> handleMethodModifiedAnnouncement: aMethodModified [ 
	self hasContexts ifFalse: [ ^ self ].
	self views do: [ :eachView | 
		(eachView definingMethod isNotNil and: [ 
			eachView definingMethod gtPhlowIncludesCompiledMethod: aMethodModified methodAffected ]) ifTrue: [ 
				^ self updateSubView: eachView ] ].
]

{ #category : #subscriptions }
GtPhlowUpdateCompositeSubViewTitlesOnMethodChange >> subscribeOn: aGtPhlowElementContext [
	self addContext: aGtPhlowElementContext.
	self
		subscribeAnnouncement: MethodModified
		send: #handleMethodModifiedAnnouncement:
		subscriber: aGtPhlowElementContext
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewTitlesOnMethodChange >> updateSubView: aGtPhlowView [
	self contexts do: [ :eachContext | 
		self updateSubView: aGtPhlowView inContext: eachContext ].
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewTitlesOnMethodChange >> updateSubView: aGtPhlowView inContext: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowUpdateCompositeSubViewTitle new
		elementContext: aGtPhlowElementContext;
		subView: aGtPhlowView)
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitlesOnMethodChange >> views [
	<return: #Array of: #GtPhlowView>
	^ self contexts anyOne entity views
]
