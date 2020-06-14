Class {
	#name : #GtPhlowUpdateCompositeSubViewListOnMethodChange,
	#superclass : #GtPhlowSystemChangeUpdateDefinition,
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
	self contexts do: [ :eachContext | 
		self addSubView: aMethodAdded methodAdded inContext: eachContext ].
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

{ #category : #subscriptions }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> subscribeOn: aGtPhlowElementContext [
	aGtPhlowElementContext hasBuildContext ifFalse: [ ^ self ].
	self addContext: aGtPhlowElementContext.
	self
		subscribeAnnouncement: MethodAdded
		send: #handleMethodAddedAnnouncement:
		subscriber: aGtPhlowElementContext
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> updateSubView: aGtPhlowView [
	self contexts do: [ :eachContext | 
		self updateSubView: aGtPhlowView inContext: eachContext ].
]

{ #category : #updating }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> updateSubView: aGtPhlowView inContext: aGtPhlowElementContext [
	self scheduleTask: (GtPhlowUpdateCompositeSubViewTitle new
		elementContext: aGtPhlowElementContext;
		subView: aGtPhlowView)
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewListOnMethodChange >> views [
	<return: #Array of: #GtPhlowView>
	^ self contexts anyOne entity views
]
