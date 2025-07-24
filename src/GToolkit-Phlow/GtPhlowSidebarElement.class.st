"
I am an abstract class.
I define a common API (code) for my subclasses.
For more details, see my {{gtClass:GtPhlowSidebarElement|show=#gtSubclassesFor:|expanded}}:


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

{ #category : #'api - location' }
GtPhlowSidebarElement >> beBottom [
	"We want the sidebar on the bottom side, 
	hence the content offset and resizing on the top side."
	
	self contentOffset: (GtPhlowSidebarContentOffset top: self contentOffset length)
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> beExact: aNumber [
	resizerStrategy := BrResizerElementLength exact: aNumber
]

{ #category : #'api - location' }
GtPhlowSidebarElement >> beLeft [
	"We want the sidebar on the left side, 
	hence the content offset and resizing on the right side."

	self contentOffset: (GtPhlowSidebarContentOffset right: self contentOffset length)
]

{ #category : #'api - location' }
GtPhlowSidebarElement >> beRight [
	"We want the sidebar on the right side, 
	hence the content offset and resizing on the left side."
	
	self contentOffset: (GtPhlowSidebarContentOffset left: self contentOffset length)
]

{ #category : #'api - location' }
GtPhlowSidebarElement >> beTop [
	"We want the sidebar on the top side, 
	hence the content offset and resizing on the bottom side."
	
	self contentOffset: (GtPhlowSidebarContentOffset bottom: self contentOffset length)
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> collapse [
	self contentOffset adjustElementLength: self
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
	| oldContentOffset |
	self
		assert: [ aGtPhlowSidebarContentOffset isKindOf: GtPhlowSidebarContentOffset ]
		description: [ 'Content offset must be a ' , GtPhlowSidebarContentOffset name , ' instance' ].

	contentOffset = aGtPhlowSidebarContentOffset ifTrue: [ ^ self ].

	oldContentOffset := contentOffset.
	contentOffset := aGtPhlowSidebarContentOffset.
	self
		onContentOffsetChangedFrom: oldContentOffset
		to: aGtPhlowSidebarContentOffset
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
	^ BrGlamorousWithResizerAptitude new
]

{ #category : #defaults }
GtPhlowSidebarElement >> defaultResizerStrategy [
	^ BrResizerElementLength weight: 0.5.
]

{ #category : #'api - visibility' }
GtPhlowSidebarElement >> expand [
	self contentOffset
		adjustElement: self
		lenghtWithResizerStrategy: self resizerStrategy
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
	
	self addAptitude: (BrLayoutResizerAptitude new
		vInherit;
		vInherit: [ :aBlock | self contentElementDo: aBlock ])
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
	^ self contentOffset isElementCollapsed: self
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
GtPhlowSidebarElement >> onContentOffsetChangedFrom: anOldContentOffset to: aNewContentOffset [
	self updateElementOffsetsFrom: anOldContentOffset to: aNewContentOffset.
	self updateElementConstraintsFrom: anOldContentOffset to: aNewContentOffset.
	self updateResizerElementPosition
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
	self contentOffset adjustElement: self resizerStrategyOnResizerResized: anEvent
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

{ #category : #'private - accessing' }
GtPhlowSidebarElement >> resizerStrategy: aResizerElementLength [
	resizerStrategy := aResizerElementLength
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

{ #category : #'private - updating' }
GtPhlowSidebarElement >> updateElementConstraintsFrom: oldContentOffset to: newContentOffset [
	"For now, we just expects that the other length has matchParent constraints."

	self contentOffset
		adjustElement: self
		lenghtWithResizerStrategy: self resizerStrategy.
	self contentOffset adjustElementOrthogonalLength: self
]

{ #category : #'private - updating' }
GtPhlowSidebarElement >> updateElementOffsetsFrom: oldContentOffset to: newContentOffset [
	| oldInsets newInsets existingInsets updatedInsets |
	oldInsets := oldContentOffset margin.
	newInsets := newContentOffset margin.
	existingInsets := self margin.
	updatedInsets := BlInsets
			top: existingInsets top - oldInsets top + newInsets top
			right: existingInsets right - oldInsets right + newInsets right
			bottom: existingInsets bottom - oldInsets bottom + newInsets bottom
			left: existingInsets left - oldInsets left + newInsets left.
	self contentElement margin: updatedInsets
]

{ #category : #'private - updating' }
GtPhlowSidebarElement >> updateResizerElementPosition [
	self contentOffset adjustResizerElementPosition: self resizerElement
]
