"
I listen to system changes.
I change a ${class:BrTab}$ label and position of a changed ${class:GtPhlowView}$ subview definition in a given ${class:BrTabGroup}$ element.
See ${class:GtPhlowUpdateCompositeSubViewTitleAndPosition}$ for more details.

"
Class {
	#name : #GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnMethodChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'announcement handling' }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnMethodChange >> handleMethodModifiedAnnouncement: aMethodModified [ 
	self hasContexts ifFalse: [ ^ self ].
	self views do: [ :eachView | 
		(eachView definingMethod isNotNil and: [ 
			eachView definingMethod gtPhlowIncludesCompiledMethod: aMethodModified methodAffected ]) ifTrue: [ 
				^ self updateSubView: eachView ] ].
]

{ #category : #subscriptions }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnMethodChange >> subscribeOn: aGtPhlowElementContext [
	self addContext: aGtPhlowElementContext.
	self setSubscribedIfAlreadySubscribedDo: [ ^ self ].
	self
		subscribeAnnouncement: MethodModified
		send: #handleMethodModifiedAnnouncement:
		subscriber: self
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnMethodChange >> updateSubView: aGtPhlowView [
	self contexts do: [ :eachContext | 
		self updateSubView: aGtPhlowView inContext: eachContext ].
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnMethodChange >> updateSubView: aGtPhlowView inContext: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowUpdateCompositeSubViewTitleAndPosition new
		elementContext: aGtPhlowElementContext;
		subView: aGtPhlowView)
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnMethodChange >> views [
	<return: #Array of: #GtPhlowView>
	^ self contexts anyOne entity views
]
