"
I am a ${class:BlElement}$.
I am a sidebar.

I know how to:
- ${method:GtPhlowSidebarElement>>#show|label=#selector}$, 
- ${method:GtPhlowSidebarElement>>#hide|label=#selector}$, 
- ${method:GtPhlowSidebarElement>>#expand|label=#selector}$, and 
- ${method:GtPhlowSidebarElement>>#collapse|label=#selector}$ myself.

The content can be defined using ${method:GtPhlowSidebarElement>>#contentStencil:|label=#selector}$ with a ${class:BrStencil}$ as parameter.

Users can:
- set my width using a ${class:BrResizer|label=resizer}$ handler,
- collapse and expand by ${method:GtPhlowSidebarElement>>#onResizerDoubleClick:|label=double clicking}$ on the resizer.
!! Example
The following example, show a sidebar with a label content that you can resize using the handler on the right: ${example:GtPhlowSidebarElementExamples>>#sidebarElement|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #GtPhlowSidebarElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'resizerElement',
		'widthStrategy',
		'contentStencil',
		'contentElement'
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
	widthStrategy := BrResizerElementLength exact: aNumber
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> collapse [
	self width: self resizerWidth
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
GtPhlowSidebarElement >> defaultContentStencil [
	^ GtPhlowSidebarEmptyContentStencil default
]

{ #category : #defaults }
GtPhlowSidebarElement >> defaultWidthStrategy [
	^ BrResizerElementLength weight: 0.5.
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> expand [
	self widthStrategy adjustWidthFor: self.
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> hide [
	self visibility: BlVisibility gone
]

{ #category : #initialization }
GtPhlowSidebarElement >> initialize [
	super initialize.
	widthStrategy := self defaultWidthStrategy.
	contentStencil := self defaultContentStencil.

	self addInteractiveModelState: BrLayoutHorizontalResizerModel matchParent.
	self addInteractiveModelState: BrLayoutVerticalResizerModel matchParent.		
	self initializeContentElement.
	self initializeElement.

	self addChild: self contentElement as: self contentElementName.
	self
		addLook: (BrGlamorousWithHorizontalResizerLook new 
		resizerDo: [ :theResizer | resizerElement := theResizer ]).

	self initializeListeners.
	self expand.
	
	self addLook: (BrLayoutResizerLook new
		vInherit: self;
		vInheritIn: [ :aBlock | self contentElementDo: aBlock ])
]

{ #category : #initialization }
GtPhlowSidebarElement >> initializeContentElement [
	contentElement := self contentStencil asElement.
	contentElement margin: contentElement margin + (BlInsets right: self resizerWidth).
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
GtPhlowSidebarElement >> initializeListeners [
	self resizerElement
		when: BlResizerResizedEvent
			do: [ :anEvent | self onResizerResized: anEvent ];
		when: BlDoubleClickEvent
			do: [ :anEvent | self onResizerDoubleClick: anEvent ]
]

{ #category : #'private - testing' }
GtPhlowSidebarElement >> isCollapsed [
	<return: #Boolean>
	^ self width <= self resizerWidth
]

{ #category : #'private - hooks' }
GtPhlowSidebarElement >> onContentStencilChanged [
	self updateContentElement
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
	self beExact: anEvent extent x
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> resizerElement [
	<return: #BrResizer>
	^ resizerElement
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> resizerWidth [
	^ 4
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
	contentElement margin: contentElement margin + (BlInsets right: self resizerWidth).
	self
		replaceChild: anOldContentElement
		with: self contentElement
		as: self contentElementName
]

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> widthStrategy [
	<return: #BrResizerElementLength>
	^ widthStrategy
]
