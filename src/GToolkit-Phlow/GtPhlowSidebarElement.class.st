"
I am an abstract class.
I define a common API (code) for my subclasses.
For more details, see my ${class:GtPhlowSidebarElement|show=#gtSubclassesFor:|expanded}$:
"
Class {
	#name : #GtPhlowSidebarElement,
	#superclass : #GtPhlowElement,
	#instVars : [
		'contentElement',
		'contentStencil',
		'resizerElement',
		'resizerStrategy',
		'contentOffset'
	],
	#category : #'GToolkit-Phlow-Tool - UI Sidebar'
}

{ #category : #'private - asserting' }
GtPhlowSidebarElement >> assertContentStencil: aStencil [
	self
		assert: [ aStencil isNotNil ] 
		description: [ 'Sidebar content stencil must be non-nil' ].
	self
		assert: [ aStencil respondsTo: #asElement ] 
		description: [ 'Sidebar content stencil must respond to #', #asElement ].
	
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> beExact: aNumber [
	resizerStrategy := BrResizerElementLength exact: aNumber
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> collapse [
	self subclassResponsibility
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> contentElement [
	<return: #BlElement>
	^ contentElement
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> contentElementDo: aBlock [
	self contentElement ifNotNil: aBlock
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> contentElementName [
	^ #content
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> contentOffset [
	<return: #GtPhlowSidebarContentOffset>
	^ contentOffset
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> contentOffset: aGtPhlowSidebarContentOffset [
	self 
		assert: [ aGtPhlowSidebarContentOffset isKindOf: GtPhlowSidebarContentOffset ] 
		description: [ 'Content offset must be a ', GtPhlowSidebarContentOffset name, ' instance' ].
	contentOffset := aGtPhlowSidebarContentOffset
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> contentStencil [
	<return: #BrStencil>
	^ contentStencil
]

{ #category : #'api - accessing' }
GtPhlowSidebarElement >> contentStencil: aStencil [
	| aNewStencil |
	aNewStencil := aStencil asStencil.
	self assertContentStencil: aNewStencil.
	contentStencil := aNewStencil.
	self onContentStencilChanged.
]

{ #category : #defaults }
GtPhlowSidebarElement >> defaultContentOffset [
	^ self subclassResponsibility
]

{ #category : #defaults }
GtPhlowSidebarElement >> defaultContentOffsetLength [
	^ 4
]

{ #category : #defaults }
GtPhlowSidebarElement >> defaultContentStencil [
	^ GtPhlowSidebarEmptyContentStencil default
]

{ #category : #defaults }
GtPhlowSidebarElement >> defaultResizerLook [
	^ self subclassResponsibility
]

{ #category : #defaults }
GtPhlowSidebarElement >> defaultResizerStrategy [
	^ BrResizerElementLength weight: 0.5.
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> expand [
	self subclassResponsibility
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> hide [
	self visibility: BlVisibility gone
]

{ #category : #initialization }
GtPhlowSidebarElement >> initialize [
	super initialize.
	contentOffset := self defaultContentOffset.
	resizerStrategy := self defaultResizerStrategy.
	contentStencil := self defaultContentStencil.

	self initializeElement.
	self initializeContentElement.
	self addChild: self contentElement as: self contentElementName.
	self initializeResizerElement.
	
	self expand.
]

{ #category : #initialization }
GtPhlowSidebarElement >> initializeContentElement [
	contentElement := self contentStencil asElement.
	contentElement margin: contentElement margin + self contentOffset margin.
]

{ #category : #initialization }
GtPhlowSidebarElement >> initializeElement [
	self
		layout: BlFrameLayout new;
		labeled: 'Sidebar';
		visibility: BlVisibility visible;
		background: BlBackground transparent.
]

{ #category : #initialization }
GtPhlowSidebarElement >> initializeResizerElement [
	self
		addAptitude: (self defaultResizerLook
			resizerDo: [ :theResizer | resizerElement := theResizer ]).

	self resizerElement
		when: BlResizerResizedEvent
			do: [ :anEvent | self onResizerResized: anEvent ];
		when: BlDoubleClickEvent
			do: [ :anEvent | self onResizerDoubleClick: anEvent ]
]

{ #category : #'private - testing' }
GtPhlowSidebarElement >> isCollapsed [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
GtPhlowSidebarElement >> offset: anInteger [
	"Set a distance between the sidebar border and the sidebar content.
	The offset applies only on the side with the resizer handler.
	It is a margin insets that is added to the sidebar content margin."
	| anOldOffset |
	anOldOffset := self contentOffset length.
	self contentOffset length: anInteger.
	self onOffsetChangedFrom: anOldOffset to: anInteger.
]

{ #category : #'private - hooks' }
GtPhlowSidebarElement >> onContentStencilChanged [
	self updateContentElement
]

{ #category : #'private - hooks' }
GtPhlowSidebarElement >> onOffsetChangedFrom: anOldOffset to: aNewOffset [
	self updateContentElementOffsetWith: anOldOffset.
]

{ #category : #'private - event handling' }
GtPhlowSidebarElement >> onResizerDoubleClick: anEvent [
	anEvent consumed: true.
	self isCollapsed
		ifTrue: [ self expand ]
		ifFalse: [ self collapse ]
]

{ #category : #'private - event handling' }
GtPhlowSidebarElement >> onResizerResized: anEvent [
	self subclassResponsibility
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> resizerElement [
	<return: #BrResizer>
	^ resizerElement
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> resizerStrategy [
	<return: #BrResizerElementLength>
	^ resizerStrategy
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> show [
	self visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtPhlowSidebarElement >> updateContentElement [
	| anOldContentElement |
	anOldContentElement := self contentElement.
	contentElement := self contentStencil asElement.
	self contentElement margin: self contentElement margin + self contentOffset margin.
	self
		replaceChild: anOldContentElement
		with: self contentElement
		as: self contentElementName
]

{ #category : #'private - updating' }
GtPhlowSidebarElement >> updateContentElementOffsetWith: aPreviousLength [
	| anInsets |
	anInsets := self contentOffset marginExtra: aPreviousLength negated.
	self contentElement margin: contentElement margin + anInsets.
]
