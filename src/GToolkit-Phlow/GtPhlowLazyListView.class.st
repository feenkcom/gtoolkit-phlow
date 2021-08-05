Class {
	#name : 'GtPhlowLazyListView',
	#superclass : 'GtPhlowListView',
	#instVars : [
		'itemsProviderComputation'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : 'api - converting' }
GtPhlowLazyListView >> asElementDo: aBlock [
	| aList itemsProvider |
	"theItems := self
		itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ]."
	itemsProvider := self itemsProviderOnExceptionErrorElement: [ :anElement | 
		^ aBlock value: anElement ].
	aList := self elementClass new 
		itemsProvider: itemsProvider.
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

{ #category : 'defaults' }
GtPhlowLazyListView >> elementClass [
	^ BrSimpleLazyList
]

{ #category : 'accessing' }
GtPhlowLazyListView >> itemsProvider: aBlock [
	itemsProviderComputation := aBlock
]

{ #category : 'accessing' }
GtPhlowLazyListView >> itemsProviderComputation [
	^ itemsProviderComputation
]

{ #category : 'private - accessing' }
GtPhlowLazyListView >> itemsProviderOnExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ self itemsProviderComputation value ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]
