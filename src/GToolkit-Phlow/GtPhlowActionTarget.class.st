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

{ #category : #enumerating }
GtPhlowActionTarget >> targetsDo: aBlock [

	 "Iterate over all leaf action targets. For example, 
	 I do not evaluate aBlock for composite targets."
	 
	 aBlock value: self
]
