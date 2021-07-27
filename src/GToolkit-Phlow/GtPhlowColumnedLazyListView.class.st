Class {
	#name : #GtPhlowColumnedLazyListView,
	#superclass : #GtPhlowColumnedListView,
	#instVars : [
		'itemsProviderComputation'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowColumnedLazyListView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aContainer header list |
	"theItems := self
		itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ]."
	aContainer := self elementClass new.
	aContainer
		labeled: 'Columned List Container';
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aContainer layout: BlLinearLayout vertical.
	header := self buildHeaderForItems: #() "theItems".
	list := self columnedListClass new 
		itemsProvider: self itemsProvider.
	list
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation).
	list
		rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new cellSpacing: self cellSpacing).
	self buildColumnsInList: list.
	aContainer
		addChildren:
			{header.
			list}.
	self beViewElement: aContainer.
	^ aBlock value: aContainer
]

{ #category : #'private - accessing' }
GtPhlowColumnedLazyListView >> columnedListClass [
	^ BrColumnedLazyList
]

{ #category : #accessing }
GtPhlowColumnedLazyListView >> itemsProvider [
	^ itemsProviderComputation value
]

{ #category : #accessing }
GtPhlowColumnedLazyListView >> itemsProvider: aBlock [
	itemsProviderComputation := aBlock
]
