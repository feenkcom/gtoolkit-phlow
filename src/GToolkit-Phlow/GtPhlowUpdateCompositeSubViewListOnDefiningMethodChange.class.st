"
I listen to system changes.
I add a {{gtClass:BrTab}} in a given {{gtClass:BrTabGroup}} element when a new {{gtClass:GtPhlowView}} is defined.
I remove a {{gtClass:BrTab}} in a given {{gtClass:BrTabGroup}} element when an existing {{gtClass:GtPhlowView}} defining method is removed.
See {{gtClass:GtPhlowAddCompositeSubView}} and {{gtClass:name=GtPhlowRemoveCompositeSubView}} for more details.


"
Class {
	#name : #GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
	#traits : 'TGtPhlowObservedClassAccessors + TGtPhlowCompositeViewAccessors',
	#classTraits : 'TGtPhlowObservedClassAccessors classTrait + TGtPhlowCompositeViewAccessors classTrait',
	#instVars : [
		'pragmas'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> addSubView: aMethodAdded inContext: aGtPhlowElementContext [

	self scheduleTask: [ 
		(GtPhlowAddCompositeSubView new
			 elementContext: aGtPhlowElementContext;
			 compiledMethod: aMethodAdded) execute ] asAsyncFuture
]

{ #category : #defaults }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> defaultPragmas [
	^ GtPhlowViewsCollector defaultViewPragmaNames
]

{ #category : #'announcement handling' }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> handleMethodAddedAnnouncement: aMethodAdded [ 
	self ifItDoesNotHaveContextsDo: [ ^ self ].
	self ifItDoesNotHaveObservedClassDo: [ ^ self ]. 
	(self pragmas anySatisfy: [ :eachSymbol |
		aMethodAdded methodAdded hasPragmaNamed: eachSymbol ]) ifFalse: [ ^ self ].
	(GtSystemUtility 
		isClass: self observedClass
		sameOrSubclassOf: aMethodAdded classAffected) ifFalse: [ ^ self ].
	self contexts do: [ :eachContext | 
		self addSubView: aMethodAdded methodAdded inContext: eachContext ].
]

{ #category : #'announcement handling' }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> handleMethodRemovedAnnouncement: aMethodRemoved [ 
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
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> initialize [
	super initialize.
	pragmas := self defaultPragmas.
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> pragma: aSymbol [
	self pragmas: (Array with: aSymbol)
]

{ #category : #accessing }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> pragmas [
	^ pragmas
]

{ #category : #accessing }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> pragmas: anObject [
	pragmas := anObject
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> removeSubView: aMethodRemoved inContext: aGtPhlowElementContext [

	self scheduleTask: [ 
		(GtPhlowRemoveCompositeSubView new
			 elementContext: aGtPhlowElementContext;
			 compiledMethod: aMethodRemoved) execute ] asAsyncFuture
]

{ #category : #subscriptions }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> subscribeToSystemOn: aGtPhlowElementContext [
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
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> updateSubView: aGtPhlowView [
	self contexts do: [ :eachContext | 
		self updateSubView: aGtPhlowView inContext: eachContext ].
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange >> updateSubView: aGtPhlowView inContext: aGtPhlowElementContext [

	self scheduleTask: [ 
		(GtPhlowUpdateCompositeSubViewTitleAndPosition new
			 elementContext: aGtPhlowElementContext;
			 subView: aGtPhlowView) execute ] asAsyncFuture
]
