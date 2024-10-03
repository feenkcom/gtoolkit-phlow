Class {
	#name : #GtPhlowChangeTabGroupAddTabAction,
	#superclass : #GtPhlowChangeAction,
	#instVars : [
		'tabGroup',
		'buildContext',
		'contentsBuilder'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #'api - actions' }
GtPhlowChangeTabGroupAddTabAction >> actOn: aChangeContext [
	| aCompositeView aNewView |
	self tabGroup ifNil: [ ^ self ].
	self buildContext isBuildContext ifFalse: [ ^ self ].
	aCompositeView := self compositeView ifNil: [ ^ self ].
	contentsBuilder ifNil: [ ^ self ].

	aNewView := self newPhlowViewOn: aChangeContext.
	GtPhlowUtility
		createSafelyTabElementFor: aNewView
		stencil: (contentsBuilder value: aNewView)
		andDo: [ :aTab | self addTab: aTab ofView: aNewView ]
]

{ #category : #private }
GtPhlowChangeTabGroupAddTabAction >> addTab: aTab ofView: aPhlowView [
	BlTaskAction
		enqueueElement: self tabGroup
		action: [ self basicAddTab: aTab ofView: aPhlowView ]
]

{ #category : #private }
GtPhlowChangeTabGroupAddTabAction >> basicAddTab: aTab ofView: aPhlowView [
	| anIndex |
	anIndex := GtPhlowUtility
		findIndexFor: aPhlowView
		in: self compositeView views.
	self tabGroup addTab: aTab at: anIndex.
	self compositeView views add: aPhlowView beforeIndex: anIndex.
]

{ #category : #accessing }
GtPhlowChangeTabGroupAddTabAction >> buildContext [
	<return: #GtPhlowBuildContext>
	^ buildContext
]

{ #category : #accessing }
GtPhlowChangeTabGroupAddTabAction >> buildContext: anObject [
	buildContext := anObject
]

{ #category : #accessing }
GtPhlowChangeTabGroupAddTabAction >> compositeView [
	^ self tabGroup phlow entity
]

{ #category : #accessing }
GtPhlowChangeTabGroupAddTabAction >> contentsBuilder [
	^ contentsBuilder
]

{ #category : #accessing }
GtPhlowChangeTabGroupAddTabAction >> contentsBuilder: anObject [
	contentsBuilder := anObject
]

{ #category : #initialization }
GtPhlowChangeTabGroupAddTabAction >> initialize [
	super initialize.
	buildContext := GtPhlowBuildContext null.
	contentsBuilder := [ :aPhlowView | [ GtPhlowUtility newElementForView: aPhlowView ] ]
]

{ #category : #'instance creation' }
GtPhlowChangeTabGroupAddTabAction >> newPhlowViewOn: aChangeContext [ 
	^ GtPhlowView empty
		on: self buildContext object 
		perform: aChangeContext affectedMethodSelector
		withContext: self buildContext context
]

{ #category : #accessing }
GtPhlowChangeTabGroupAddTabAction >> tabGroup [
	<return: #BrTabGroup>
	^ tabGroup
]

{ #category : #accessing }
GtPhlowChangeTabGroupAddTabAction >> tabGroup: anObject [
	tabGroup := anObject
]
