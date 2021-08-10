"
I represent a columned list view.
I create {{gtClass:BrColumnedList}} to display items. 
1. # Examples 

The following object displays several examples. You can `ALT+CLICK` on tab names to display their definitions: {{gtExample:GtPhlowColumnedListViewExamples>>#myself|noCode=true}}  
 


"
Class {
	#name : #GtPhlowColumnedListView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowColumnedHeader + TGtPhlowColumnScripts + TGtPhlowSendTransformable',
	#classTraits : 'TGtPhlowColumnedHeader classTrait + TGtPhlowColumnScripts classTrait + TGtPhlowSendTransformable classTrait',
	#instVars : [
		'columns',
		'itemsBuilder'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowColumnedListView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aContainer header list theItems |
	theItems := self
		itemsOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].
	aContainer := self elementClass new.
	aContainer
		labeled: 'Columned List Container';
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aContainer layout: BlLinearLayout vertical.
	header := self buildHeaderForItems: theItems.
	list := self columnedListClass new items: theItems.
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

{ #category : #'private - building' }
GtPhlowColumnedListView >> buildColumnsInList: aList [
	columns do: [ :eachPhlowColumn |
		eachPhlowColumn configureColumn: aList column ]
		"aList column
			title: eachPhlowColumn title;
			cellStencil: eachPhlowColumn cellStencil;
			dataBinder: eachPhlowColumn dataBinder;
			stencil: [ :eachItem :eachIndex |
				| aRowElement |

				aRowElement := self performBlock: [ 
					eachPhlowColumn createRowElementFor: eachItem atIndex: eachIndex ].
				
				eachPhlowColumn resizer ifNotNil: [ :aLayoutResizer |
					aRowElement constraintsDo: [ :c |
						c horizontal resizer: aLayoutResizer.
						c vertical fitContent ].
					aRowElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
					aRowElement dispatchEvent: (BrLayoutVerticalResizerWish fitContent) ].
				aRowElement ] ]."
]

{ #category : #accessing }
GtPhlowColumnedListView >> cellSpacing [
	^ 10
]

{ #category : #'api - scripting column' }
GtPhlowColumnedListView >> column [
	<return: #GtPhlowColumn>
	| aColumn |
	
	aColumn := GtPhlowColumn new index: columns size + 1.
	columns add: aColumn.
	^ aColumn
]

{ #category : #'private - testing' }
GtPhlowColumnedListView >> columnedListClass [
	^ BrColumnedList
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> columns [
	<return: #Collection of: #GtPhlowColumn>
	^ columns
]

{ #category : #copying }
GtPhlowColumnedListView >> copyTransformationFrom: aSendBlock [
	aSendBlock ifNil: [ ^ self ].
	self send: aSendBlock
]

{ #category : #'scripting - deprecated' }
GtPhlowColumnedListView >> display: aBlock [
	self 
		deprecated: 'Please use #items: instead.'
		transformWith: '`@receiver display: `@statements' -> '`@receiver items: `@statements'.
	self items: aBlock
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> elementClass [
	^ BlElement
]

{ #category : #initialization }
GtPhlowColumnedListView >> initialize [
	super initialize.
	
	columns := OrderedCollection new.
	itemsBuilder := [ { } ].
	self transformation: self defaultTransformation.
]

{ #category : #'private - testing' }
GtPhlowColumnedListView >> isExpectedElement: aCurrentElement [
	aCurrentElement class = self elementClass ifFalse: [ ^ false ].
	aCurrentElement childrenCount = 2 ifFalse: [ ^ false ].
	(aCurrentElement childAt: 2) class = self columnedListClass ifFalse: [ ^ false ].
	^ true
]

{ #category : #'api - scripting' }
GtPhlowColumnedListView >> items: aValuable [
	itemsBuilder := aValuable
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> itemsBuilder [
	^ itemsBuilder
]

{ #category : #'private - accessing' }
GtPhlowColumnedListView >> itemsOnExceptionErrorElement: aBlock [
	^ self 
		performBlock: [ self itemsBuilder value ]
		onExceptionErrorElement: [ :anElement |
			aBlock value: anElement ].
]

{ #category : #accessing }
GtPhlowColumnedListView >> itemsProviderBuilder [
	^ self itemsBuilder value asGPhlowItemsIterator
]

{ #category : #'api - updating' }
GtPhlowColumnedListView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"
	
	| aParent |
	(self isExpectedElement: aCurrentElement) ifFalse: [ 
		^ super updateContent: aCurrentElement ].
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		| theItems aList |
		theItems := self itemsOnExceptionErrorElement: [ :anErrorElement | 
			^ self replaceOldElement: aCurrentElement by: anErrorElement in: aParent ].
		aList := aCurrentElement children second.
		self enqueueAction: [ aList items: theItems ] in: aList ].
]
