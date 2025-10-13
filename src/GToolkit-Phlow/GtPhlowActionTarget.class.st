"
I define where a {{gtClass:GtPhlowAction}} should be displayed. 
I am an abstract class. My subclasses define specific targets: {{gtClass:GtPhlowActionTarget | show=#gtSubclassesFor: | expanded=true}}
"
Class {
	#name : #GtPhlowActionTarget,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Action Targets'
}

{ #category : #'instance creation' }
GtPhlowActionTarget class >> default [

	^ GtPhlowObjectActionTarget uniqueInstance
]

{ #category : #'instance creation' }
GtPhlowActionTarget class >> forViewSelector: aSelector [

	^ GtPhlowViewActionTarget new definingMethodSelector: aSelector
]

{ #category : #composing }
GtPhlowActionTarget >> + aTarget [

	^ self, aTarget asPhlowTarget
]

{ #category : #composing }
GtPhlowActionTarget >> , aTarget [

	| aComposition aCollection |
	aComposition := GtPhlowCompositeActionTarget new.
	
	aCollection := Array streamContents: [ :aStream | 
		self targetsDo: [ :eachTarget | aStream nextPut: eachTarget ].
		aTarget targetsDo: [ :eachTarget | aStream nextPut: eachTarget ] ].

	aComposition targets: aCollection.
	^ aComposition
]

{ #category : #enumerating }
GtPhlowActionTarget >> actionsForObject: anObject [
	^ self actionsForObject: anObject collect: [ :e | e ]
]

{ #category : #enumerating }
GtPhlowActionTarget >> actionsForObject: anObject collect: aBlock [
	^ anObject gtActions
		select: [ :eachAction | eachAction target isForTarget: self ]
		thenCollect: aBlock
]

{ #category : #enumerating }
GtPhlowActionTarget >> actionsForObject: anObject do: aBlock [
	anObject gtActions
		select: [ :eachAction | eachAction target isForTarget: self ]
		thenDo: aBlock
]

{ #category : #enumerating }
GtPhlowActionTarget >> actionsForObject: anObject inContext: aPhlowContext do: aBlock [
	(anObject gtActionsInContext: aPhlowContext)
		select: [ :eachAction | eachAction target isForTarget: self ]
		thenDo: aBlock
]

{ #category : #converting }
GtPhlowActionTarget >> asPhlowTarget [
	^ self
]

{ #category : #testing }
GtPhlowActionTarget >> isForTarget: aTarget [
	^ self = aTarget asPhlowTarget
]

{ #category : #testing }
GtPhlowActionTarget >> isForViewDefinedIn: aSymbol [
	^ false
]

{ #category : #converting }
GtPhlowActionTarget >> menuItemsForObject: anObject hostElement: aHostElement [
	| aMenuItems |
	aMenuItems := BrMenuItems new.
	
	self
		menuItemsForObject: anObject
		hostElement: aHostElement
		do: [ :aMenuItem | aMenuItems addItem: aMenuItem ].
	
	^ aMenuItems
]

{ #category : #converting }
GtPhlowActionTarget >> menuItemsForObject: anObject hostElement: aHostElement do: aBlock [
	self
		actionsForObject: anObject
		do: [ :eachAction | 
			eachAction
				asMenuItem: [ :aMenuItem | aBlock value: aMenuItem ]
				withHostElement: aHostElement ].
]

{ #category : #converting }
GtPhlowActionTarget >> menuItemsForObject: anObject inContext: aPhlowContext hostElement: aHostElement [
	| aMenuItems |
	aMenuItems := BrMenuItems new.
	self
		actionsForObject: anObject
		inContext: aPhlowContext
		do: [ :eachAction | 
			eachAction
				asMenuItem: [ :aMenuItem | aMenuItems addItem: aMenuItem ]
				withHostElement: aHostElement ].

	^ aMenuItems
]

{ #category : #converting }
GtPhlowActionTarget >> menuItemsForObject: anObject inContext: aPhlowContext hostElement: aHostElement do: aBlock [
	self
		actionsForObject: anObject
		inContext: aPhlowContext 
		do: [ :eachAction | 
			eachAction
				asMenuItem: [ :aMenuItem | aBlock value: aMenuItem ]
				withHostElement: aHostElement ].
]

{ #category : #enumerating }
GtPhlowActionTarget >> targetsDo: aBlock [

	 "Iterate over all leaf action targets. For example, 
	 I do not evaluate aBlock for composite targets."
	 
	 aBlock value: self
]
