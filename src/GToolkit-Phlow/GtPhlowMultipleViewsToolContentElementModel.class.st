Class {
	#name : #GtPhlowMultipleViewsToolContentElementModel,
	#superclass : #Object,
	#instVars : [
		'phlowTool',
		'targetObject'
	],
	#category : #'GToolkit-Phlow-Tool - Element'
}

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> collectContentViews [ 
	^ GtPhlowViewsCollector new
		pragmaName: #gtToolView;
		fromObject: self targetObject
		collect
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> collectToolActions [ 
	^ GtPhlowActionsCollector new
		pragmaName: #gtToolAction;
		fromObject: self targetObject;
		collect
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> createTitleNotifier [
	^GtPhlowTitleIconAndLabelNotifier new 
		longLabel: [self toolName];
		icon: [ self toolIcon ] asStencil
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
	targetObject := anObject
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> toolIcon [
	^ phlowTool icon
]

{ #category : #accessing }
GtPhlowMultipleViewsToolContentElementModel >> toolName [
	^ phlowTool name
]
