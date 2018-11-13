"
I offer the Phlow navigation API over the Bloc element tree starting with the specific element I am tied with.
"
Class {
	#name : #GtPhlowElement,
	#superclass : #Object,
	#instVars : [
		'element',
		'isView',
		'isAction',
		'isViewContent',
		'entity',
		'isPopupContainer'
	],
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #'instance creation' }
GtPhlowElement class >> on: anElement [
	^ self new element: anElement
]

{ #category : #'api - accessing' }
GtPhlowElement >> beAction [
	isAction := true
]

{ #category : #'api - accessing' }
GtPhlowElement >> bePopupContainer [
	isPopupContainer := true
]

{ #category : #'api - accessing' }
GtPhlowElement >> beView [
	isView := true
]

{ #category : #'api - accessing' }
GtPhlowElement >> beViewContent [
	isViewContent := true
]

{ #category : #'api - accessing' }
GtPhlowElement >> element [
	^ element
]

{ #category : #'api - accessing' }
GtPhlowElement >> element: anObject [
	element := anObject
]

{ #category : #'api - accessing' }
GtPhlowElement >> entity [
	^ entity
]

{ #category : #'api - accessing' }
GtPhlowElement >> entity: anObject [
	entity := anObject
]

{ #category : #'api - search' }
GtPhlowElement >> firstChildWithCompositeView [
	^ self firstChildWithCompositeViewDo: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElement >> firstChildWithCompositeViewDo: aBlock [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | 
			child phlow isView and: [ child phlow entity isKindOf: GtPhlowCompositeView ] ] 
		ifFound: aBlock
]

{ #category : #'api - search' }
GtPhlowElement >> firstChildWithView [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | child phlow isView ] 
		ifFound: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElement >> firstPopupContainerParentDo: aBlock ifNone: aNoneBlock [
	self element withAllParentsDo: [ :aParentElement |
			aParentElement phlow isPopupContainer ifTrue: [ ^ aBlock value: aParentElement ] ].
		
	^ aNoneBlock value
]

{ #category : #initialization }
GtPhlowElement >> initialize [
	super initialize.
	
	isAction := false.
	isView := false.
	isViewContent := false.
	isPopupContainer := false.
]

{ #category : #'api - testing' }
GtPhlowElement >> isAction [
	^ isAction
]

{ #category : #'api - accessing' }
GtPhlowElement >> isAction: aBoolean [
	isAction := aBoolean
]

{ #category : #'api - testing' }
GtPhlowElement >> isPopupContainer [
	^ isPopupContainer
]

{ #category : #'api - testing' }
GtPhlowElement >> isView [
	^ isView
]

{ #category : #'api - accessing' }
GtPhlowElement >> isView: aBoolean [
	isView := aBoolean
]

{ #category : #'api - testing' }
GtPhlowElement >> isViewContent [
	^ isViewContent
]

{ #category : #'api - accessing' }
GtPhlowElement >> isViewContent: aBoolean [
	isViewContent := aBoolean
]
