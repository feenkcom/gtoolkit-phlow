Class {
	#name : #GtPhlowUpdateCompositeSubViewListOnMethodChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#traits : 'TGtPhlowObservedClassAccessors',
	#classTraits : 'TGtPhlowObservedClassAccessors classTrait',
	#instVars : [
		'pragmas'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> addSubView: aMethodAdded inContext: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowAddCompositeSubView new
		elementContext: aGtPhlowElementContext;
		compiledMethod: aMethodAdded)
]

{ #category : #defaults }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> defaultPragmas [
	^ GtPhlowViewsCollector defaultViewPragmaNames
]

{ #category : #'announcement handling' }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> handleMethodAddedAnnouncement: aMethodAdded [ 
	self hasContexts ifFalse: [ ^ self ].
	(self pragmas anySatisfy: [ :eachSymbol |
		aMethodAdded methodAdded hasPragmaNamed: eachSymbol ]) ifFalse: [ ^ self ].
	(GtSystemUtility 
		isClass: self observedClass
		sameOrSubclassOf: aMethodAdded classAffected) ifFalse: [ ^ self ].
	self contexts do: [ :eachContext | 
		self addSubView: aMethodAdded methodAdded inContext: eachContext ].
]

{ #category : #'announcement handling' }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> handleMethodRemovedAnnouncement: aMethodRemoved [ 
	self hasContexts ifFalse: [ ^ self ].
	(self pragmas anySatisfy: [ :eachSymbol |
		aMethodRemoved methodRemoved hasPragmaNamed: eachSymbol ]) ifFalse: [ ^ self ].
	(GtSystemUtility 
		isClass: self observedClass
		sameOrSubclassOf: aMethodRemoved classAffected) ifFalse: [ ^ self ].
	self contexts do: [ :eachContext | 
		self removeSubView: aMethodRemoved methodRemoved inContext: eachContext ].
]

{ #category : #initialization }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> initialize [
	super initialize.
	pragmas := self defaultPragmas.
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> pragma: aSymbol [
	self pragmas: (Array with: aSymbol)
]

{ #category : #accessing }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> pragmas [
	^ pragmas
]

{ #category : #accessing }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> pragmas: anObject [
	pragmas := anObject
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> removeSubView: aMethodRemoved inContext: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowRemoveCompositeSubView new
		elementContext: aGtPhlowElementContext;
		compiledMethod: aMethodRemoved)
]

{ #category : #subscriptions }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> subscribeToSystemOn: aGtPhlowElementContext [
	self
		subscribeAnnouncement: MethodAdded
		send: #handleMethodAddedAnnouncement:
		subscriber: self.
	self
		subscribeAnnouncement: MethodRemoved
		send: #handleMethodRemovedAnnouncement:
		subscriber: self
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> updateSubView: aGtPhlowView [
	self contexts do: [ :eachContext | 
		self updateSubView: aGtPhlowView inContext: eachContext ].
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> updateSubView: aGtPhlowView inContext: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowUpdateCompositeSubViewTitleAndPosition new
		elementContext: aGtPhlowElementContext;
		subView: aGtPhlowView)
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> views [
	<return: #Array of: #GtPhlowView>
	^ self contexts anyOne entity views
]
