Class {
	#name : #GtPhlowExplicitAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'GToolkit-Phlow-! Actions'
}

{ #category : #converting }
GtPhlowExplicitAction >> asElement: aBlock withHostElement: aTargetElement [
	| anElement |
	anElement := [ 
		self newExplicitElementWithTargetElement: aTargetElement.
	] 
		on: Error do: [ :anError | 
			self 
				newErrorElementFor: anError 
				targetElement: aTargetElement ].
	id ifNotNil: [ anElement id: self id ].
	
	self attachShowDefinitionEventHandler: anElement.
	self attachShowContextMenuEventHandler: anElement.
	self attachTooltipFor: anElement hostElement: aTargetElement.
	
	^ aBlock value: anElement
]

{ #category : #converting }
GtPhlowExplicitAction >> asMenuItem: aBlock withHostElement: aTargetElement [
	"Return a menu item that represents the action in BrMenuItems, e.g., action"

	<return: #BrMenuItem>
	| aMenuItem |
	aMenuItem := BrMenuSubmenuItem new.
	aMenuItem
		stencil: [ [ self newExplicitElementWithTargetElement: aTargetElement ]
				on: Error
				do: [ :anError | self newErrorElementFor: anError targetElement: aTargetElement ] ].
	id ifNotNil: [ aMenuItem id: self id ].

	self tooltipBuilder
		applyAsLabelOnMenuLabeledItem: aMenuItem
		hostElement: aTargetElement.
		
	self
		menuItemGroupIfPresent: [ :aGroup | aMenuItem group: aGroup ]
		ifAbsent: [  ].

	^ aBlock value: aMenuItem
]

{ #category : #'as yet unclassified' }
GtPhlowExplicitAction >> label [
	^ nil
]

{ #category : #'instance creation' }
GtPhlowExplicitAction >> newErrorElementFor: anError targetElement: aTargetElement [
	anError freeze.
	^ GtPhlowActionWithError new
		error: anError;
		definingMethod: self definingMethod;
		asElement: [ :errorElement | errorElement ]
			withHostElement: aTargetElement
]

{ #category : #'instance creation' }
GtPhlowExplicitAction >> newExplicitElementWithTargetElement: aTargetElement [
	| anExplicitElement |
	stencilBuilder targetElement: aTargetElement.
	anExplicitElement := stencilBuilder asElement.
	anExplicitElement phlow
		beAction;
		entity: self.
	self 
		attachTooltipFor: anExplicitElement 
		hostElement: aTargetElement.
	^ anExplicitElement
]

{ #category : #accessing }
GtPhlowExplicitAction >> stencil: aStencilBuilder [
	stencilBuilder := aStencilBuilder asStencilBuilder: GtPhlowActionStencilBuilder  
]

{ #category : #accessing }
GtPhlowExplicitAction >> stencilBuilder [
	^ stencilBuilder
]
