Class {
	#name : #GtPhlowLazyListView,
	#superclass : #GtPhlowListView,
	#instVars : [
		'itemsProviderComputation'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowLazyListView >> asElementDo: aBlock [
	| aList |
	"theItems := self
		itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ]."
	aList := self elementClass new 
		itemsProvider: self itemsProvider.
	aList
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation).
	aList
		constraintsDo: [ :c | c padding: (BlInsets top: 10 bottom: 10) ].
	aList
		itemStencil: self itemElementStencil;
		itemDataBinder: self itemDataBinder;
		itemType: self itemTypeStencil.
	self beViewElement: aList.
	^ aBlock value: aList
]

{ #category : #defaults }
GtPhlowLazyListView >> elementClass [
	^ BrSimpleLazyList
]

{ #category : #accessing }
GtPhlowLazyListView >> itemsProvider [
	^ itemsProviderComputation value
]

{ #category : #accessing }
GtPhlowLazyListView >> itemsProvider: aBlock [
	itemsProviderComputation := aBlock
]
