Class {
	#name : #GtPhlowMultipleViewsToolContentElementModel,
	#superclass : #Object,
	#instVars : [
		'phlowTool',
		'targetObject',
		'contentViewPragmaNames',
		'toolActionPragmaNames',
		'headerTitleComputation'
	],
	#category : #'GToolkit-Phlow-Tool - Element'
}

{ #category : #views }
GtPhlowMultipleViewsToolContentElementModel >> collectContentViews [
	| views |
	
	views := GtPhlowViewsCollector new
		pragmaNames: self contentViewPragmaNames;
		fromObject: self targetObject;
		collect.
	
	^ GtPhlowEmptyView empty composite views: views
]

{ #category : #actions }
GtPhlowMultipleViewsToolContentElementModel >> collectToolActions [
	^ GtPhlowActionsCollector new
		pragmaNames: self toolActionPragmaNames;
		fromObject: self targetObject;
		collect
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> contentViewPragmaNames [
	^ contentViewPragmaNames
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> contentViewPragmaNames: aCollection [
	contentViewPragmaNames := aCollection
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> createTitleNotifier [
	^GtPhlowTitleIconAndLabelNotifier new 
		longLabel: [self toolName];
		icon: [ self toolIcon ] asStencil
]

{ #category : #defaults }
GtPhlowMultipleViewsToolContentElementModel >> defaultContentViewPragmaNames [
	^ #(#gtToolView)
]

{ #category : #defaults }
GtPhlowMultipleViewsToolContentElementModel >> defaultToolActionPragmaNames [
	^ #(#gtToolAction)
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> headerTitle [
	^ headerTitleComputation value
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> headerTitleComputation: aBlock [
	headerTitleComputation := aBlock
]

{ #category : #initialization }
GtPhlowMultipleViewsToolContentElementModel >> initialize [
	super initialize.
	
	contentViewPragmaNames := self defaultContentViewPragmaNames.
	toolActionPragmaNames := self defaultToolActionPragmaNames
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> phlowTool [
	^ phlowTool
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> phlowTool: aPhlowTool [
	phlowTool := aPhlowTool
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> targetObject [
	^ targetObject
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> targetObject: anObject [
	targetObject := anObject.
	^ self
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> toolActionPragmaNames [
	^ toolActionPragmaNames
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> toolActionPragmaNames: aCollection [
	toolActionPragmaNames := aCollection
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> toolIcon [
	^ phlowTool icon
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> toolName [
	^ phlowTool name
]
