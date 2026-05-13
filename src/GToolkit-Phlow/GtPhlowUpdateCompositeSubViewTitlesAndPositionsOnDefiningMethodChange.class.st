"
I listen to system changes.
I change a {{gtClass:BrTab}} label and position of a changed {{gtClass:GtPhlowView}} subview definition in a given {{gtClass:BrTabGroup}} element.
See {{gtClass:GtPhlowUpdateCompositeSubViewTitleAndPosition}} for more details.


"
Class {
	#name : #GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#traits : 'TGtPhlowCompositeViewAccessors',
	#classTraits : 'TGtPhlowCompositeViewAccessors classTrait',
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #testing }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange class >> isDeprecated [
	"Replaced by GtPhlowUpdateCompositeViewTabGroupOnDefiningMethodChange"

	^ true
]

{ #category : #accessing }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange >> assertContext: aGtPhlowElementContext [
	self 
		assert: [ aGtPhlowElementContext entity isKindOf: GtPhlowCompositeView ]
		description: [ GtPhlowCompositeView name, ' instance is expected' ]
]

{ #category : #'announcement handling' }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange >> handleMethodModifiedAnnouncement: aMethodModified [ 
	self hasContexts ifFalse: [ ^ self ].
	
	self views ifNotNil: [ :currentViews |
		currentViews do: [ :eachView | 
			(eachView definingMethodProvider isNotNil and: [ 
				eachView definingMethodProvider
					gtPhlowIncludesCompiledMethod: aMethodModified methodAffected ]) ifTrue: [ 
						^ self updateSubView: eachView ] ] ].
]

{ #category : #subscriptions }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange >> subscribeOn: aGtPhlowElementContext [
	self addContext: aGtPhlowElementContext.
	self setSubscribedIfAlreadySubscribedDo: [ ^ self ].
	self
		subscribeAnnouncement: MethodModified
		send: #handleMethodModifiedAnnouncement:
		subscriber: self
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange >> updateSubView: aGtPhlowView [
	self contexts do: [ :eachContext | 
		self updateSubView: aGtPhlowView inContext: eachContext ].
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange >> updateSubView: aGtPhlowView inContext: aGtPhlowElementContext [

	self scheduleTask: [ 
		(GtPhlowUpdateCompositeSubViewTitleAndPosition new
			 elementContext: aGtPhlowElementContext;
			 subView: aGtPhlowView) execute ] asAsyncFuture
]
