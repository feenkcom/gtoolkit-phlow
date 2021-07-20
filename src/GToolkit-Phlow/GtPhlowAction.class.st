Class {
	#name : 'GtPhlowAction',
	#superclass : 'Object',
	#traits : 'TBlDebug + TGtPhlowActionTooltipBuilder',
	#classTraits : 'TBlDebug classTrait + TGtPhlowActionTooltipBuilder classTrait',
	#instVars : [
		'definingMethod',
		'priority',
		'target'
	],
	#category : 'GToolkit-Phlow-! Actions'
}

{ #category : 'defaults' }
GtPhlowAction class >> defaultPriority [
	^ 50
]

{ #category : 'accessing' }
GtPhlowAction class >> noAction [
	^ GtPhlowNoAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : 'converting' }
GtPhlowAction >> asElement: aBlock withHostElement: aTargetElement [
	"Return an element that represents the action in Bloc space, e.g., a button"
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : 'converting' }
GtPhlowAction >> attachShowDefinitionEventHandler: element [
	self definingMethod
		ifNotNil: [ element
				when: BlMouseDownEvent
				do: [ :event | 
					(self isDefinitionRequested: event)
						ifTrue: [ event consumed: true.
							element phlow spawnObject: self definingMethod ] ] ]
]

{ #category : 'decorating' }
GtPhlowAction >> button [
	^ GtPhlowButtonAction new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : 'initialization' }
GtPhlowAction >> defaultPriority [
	^ self class defaultPriority
]

{ #category : 'initialization' }
GtPhlowAction >> defaultTarget [
	^ GtPhlowObjectActionCategory uniqueInstance
]

{ #category : 'accessing' }
GtPhlowAction >> definingMethod [
	^ definingMethod
]

{ #category : 'accessing' }
GtPhlowAction >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : 'decorating' }
GtPhlowAction >> dropdown [
	^ GtPhlowDropdownAction new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : 'decorating' }
GtPhlowAction >> explicit [
	^ GtPhlowExplicitAction new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : 'accessing' }
GtPhlowAction >> forViewDefinedIn: aSymbol [
	"Symbol is a method name where a view is defined.
	Such Phlow action will be displayed in a given view."
	self 
		assert: [ aSymbol notNil ]
		description: [ 'Phlow view action target must be non-nil' ].
	self target: (GtPhlowViewActionTarget new definingMethodSelector: aSymbol)
]

{ #category : 'gt-extension' }
GtPhlowAction >> gtDefiningMethodFor: aView [
	<gtView>
	self definingMethod ifNil: [ ^ aView empty ].
	^ (self definingMethod gtSourceFor: aView)
			priority: 2
]

{ #category : 'gt-extension' }
GtPhlowAction >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ self asElement: [ :x | x ] withHostElement: nil ];
		actionButtonIcon: BrGlamorousVectorIcons play
			action: [ :aButton | aButton phlow 
				spawnObject: (self asElement: [ :x | x ] withHostElement: nil) ]
]

{ #category : 'accessing' }
GtPhlowAction >> help: aString [
	"Ignored for now. Suppose to be a tooltip explaining a button action"
]

{ #category : 'initialization' }
GtPhlowAction >> initialize [
	super initialize.
	target := self defaultTarget.
	priority := self defaultPriority.
	self initializeTooltipBuilder
]

{ #category : 'testing' }
GtPhlowAction >> isDefaultTarget [
	^ self target = self defaultTarget
]

{ #category : 'testing' }
GtPhlowAction >> isDefinitionRequested: anEvent [
	"Return true, if a user wants to see an action definition"
	<return: #Boolean>
	^ GtPhlowUtility isDefinitionRequested: anEvent
]

{ #category : 'decorating' }
GtPhlowAction >> noAction [
	^ GtPhlowNoAction new
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : 'accessing' }
GtPhlowAction >> priority [
	^ priority
]

{ #category : 'accessing' }
GtPhlowAction >> priority: aNumber [
	priority := aNumber
]

{ #category : 'accessing' }
GtPhlowAction >> target [
	<return: #GtPhlowActionTarget>
	^ target
]

{ #category : 'accessing' }
GtPhlowAction >> target: aGtPhlowActionTarget [
	self 
		assert: [ aGtPhlowActionTarget notNil ]
		description: [ 'Phlow action target must be non-nil' ].
	target := aGtPhlowActionTarget
]

{ #category : 'decorating' }
GtPhlowAction >> toggle [
	^ GtPhlowToggleAction new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]
