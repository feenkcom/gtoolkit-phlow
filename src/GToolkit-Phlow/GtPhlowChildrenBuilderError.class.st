"
I am displayed as a child when a parent produces an error during children computation.
I am used by {{gtClass:GtPhlowTreeView}} and {{gtClass:GtPhlowColumnedTreeView}}.


"
Class {
	#name : #GtPhlowChildrenBuilderError,
	#superclass : #Object,
	#instVars : [
		'exception',
		'parent',
		'childrenBuilder'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowChildrenBuilderError >> childrenBuilder [
	^ childrenBuilder
]

{ #category : #accessing }
GtPhlowChildrenBuilderError >> childrenBuilder: anObject [
	childrenBuilder := anObject
]

{ #category : #'gt - extensions' }
GtPhlowChildrenBuilderError >> doesNotUnderstand: aMessage [ 
	self error: 'Cannot build children'
]

{ #category : #accessing }
GtPhlowChildrenBuilderError >> exception [
	^ exception
]

{ #category : #accessing }
GtPhlowChildrenBuilderError >> exception: anObject [
	exception := anObject
]

{ #category : #'gt - extensions' }
GtPhlowChildrenBuilderError >> gtDebugActionFor: anAction [
	<gtAction>
	self parent ifNil: [ ^ anAction noAction ].
	self childrenBuilder ifNil: [ ^ anAction noAction ].
	^ anAction button
		icon: BrGlamorousVectorIcons debug;
		label: 'Debug';
		tooltip: 'Debug children builder action';
		priority: 1;
		action: [ :aButton | 
			[ (self childrenBuilder value: self parent) debug ] fork ]
]

{ #category : #printing }
GtPhlowChildrenBuilderError >> gtDisplayString [
	^ self exception
		ifNotNil: #gtDisplayString 
		ifNil: [ super gtDisplayString ]
]

{ #category : #printing }
GtPhlowChildrenBuilderError >> gtDisplayText [
	^ super gtDisplayText
		glamorousCodeFontAndSmallSize;
		foreground: BrGlamorousColors linkWithErrorColor
]

{ #category : #'gt - extensions' }
GtPhlowChildrenBuilderError >> gtLiveFor: aView [
	<gtView>
	self exception ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Building children error';
		priority: 1;
		object: [ self exception ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtPhlowChildrenBuilderError >> gtParentActionFor: anAction [
	<gtAction>
	self parent ifNil: [ ^ anAction noAction ].
	^ anAction button
		icon: BrGlamorousVectorIcons inspect;
		label: 'Parent';
		tooltip: 'Inspect parent object';
		priority: 2;
		action: [ :aButton | 
			aButton phlow spawnObject: self parent ]
]

{ #category : #'gt - extensions' }
GtPhlowChildrenBuilderError >> gtSourceCodeFor: aView [
	<gtView>
	self childrenBuilder ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Children builder';
		priority: 2;
		object: [ self childrenBuilder ];
		view: #gtSourceCodeFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Builder' 
			tooltip: 'Inspect children builder' 
			action: [ :aButton | aButton phlow spawnObject: self childrenBuilder ]
]

{ #category : #accessing }
GtPhlowChildrenBuilderError >> parent [
	^ parent
]

{ #category : #accessing }
GtPhlowChildrenBuilderError >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
GtPhlowChildrenBuilderError >> printOn: aStream [
	super printOn: aStream.
	self exception ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		print: self exception;
		nextPut: $)
]
