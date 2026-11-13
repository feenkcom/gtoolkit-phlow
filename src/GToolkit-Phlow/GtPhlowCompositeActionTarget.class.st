"
I define where a {{gtClass:GtPhlowAction}} should be displayed.
I am a composite action target that defines several action targets for one action.
Individual {{gtClass:GtPhlowAction}} instances, can be composed using the {{gtMethod: GtPhlowActionTarget >> #, | label=#selector}} (comma) method.

In the following example, we can see the same button in two positions: {{gtExample: GtPhlowWithCompositeActionTarget >> #itself | noCode=true}}

See, my definition in {{gtMethod: GtPhlowWithCompositeActionTarget >> #gtDemoActionWithTargetFor: | expanded=true}} 
"
Class {
	#name : #GtPhlowCompositeActionTarget,
	#superclass : #GtPhlowActionTarget,
	#instVars : [
		'targets'
	],
	#category : #'GToolkit-Phlow-Action Targets'
}

{ #category : #enumerating }
GtPhlowCompositeActionTarget >> actionsForObject: anObject do: aBlock [
	"When I am used to request actions, evaluate aBlock with each action
	that is shown in any of my targets (each action once)"

	anObject gtActions
		select: [ :eachAction | self includesTargetOf: eachAction ]
		thenDo: aBlock
]

{ #category : #enumerating }
GtPhlowCompositeActionTarget >> actionsForObject: anObject inContext: aPhlowContext do: aBlock [
	"When I am used to request actions, evaluate aBlock with each action
	that is shown in any of my targets (each action once)"

	(anObject gtActionsInContext: aPhlowContext)
		select: [ :eachAction | self includesTargetOf: eachAction ]
		thenDo: aBlock
]

{ #category : #'gt - extensions' }
GtPhlowCompositeActionTarget >> gtTargetsFor: aView [

	<gtView>
	^ aView list
		  title: 'Targets';
		  items: [ self targets ifNil: [ #(  ) ] ]
]

{ #category : #testing }
GtPhlowCompositeActionTarget >> includesTargetOf: aPhlowAction [
	"Return true if aPhlowAction is shown in any of my leaf targets"

	self
		targetsDo: [ :eachTarget | (aPhlowAction target isForTarget: eachTarget) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #initialization }
GtPhlowCompositeActionTarget >> initialize [

	super initialize.

	targets := #(  )
]

{ #category : #testing }
GtPhlowCompositeActionTarget >> isForTarget: aTarget [

	^ self targets anySatisfy: [ :eachTarget | 
		  eachTarget isForTarget: aTarget ]
]

{ #category : #testing }
GtPhlowCompositeActionTarget >> isForViewDefinedIn: aSymbol [

	^ self targets anySatisfy: [ :eachTarget | 
		  eachTarget isForViewDefinedIn: aSymbol ]
]

{ #category : #actions }
GtPhlowCompositeActionTarget >> phlowActionsForObject: anObject [
	^ Array streamContents: [ :aStream |
		self actionsForObject: anObject do: [ :anAction |
			aStream nextPut: anAction ] ]
]

{ #category : #accessing }
GtPhlowCompositeActionTarget >> targets [

	^ targets
]

{ #category : #accessing }
GtPhlowCompositeActionTarget >> targets: anObject [

	targets := anObject
]

{ #category : #enumerating }
GtPhlowCompositeActionTarget >> targetsDo: aBlock [

	 "Iterate over all leaf action targets. For example, 
	 I do not evaluate aBlock for composite targets."
	 
	 targets do: [ :eachTarget | eachTarget targetsDo: aBlock ]
]
