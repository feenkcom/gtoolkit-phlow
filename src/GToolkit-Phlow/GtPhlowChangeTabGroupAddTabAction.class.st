Class {
	#name : #GtPhlowChangeTabGroupAddTabAction,
	#superclass : #GtPhlowChangeAction,
	#instVars : [
		'tabGroup',
		'buildContext',
		'contentsBuilder'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

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
	contentsBuilder := [ :aPhlowView | 
		[ GtPhlowUtility newElementForView: aPhlowView ] asStencil ]
]

{ #category : #'api - actions' }
GtPhlowChangeTabGroupAddTabAction >> prepareOn: aChangeContext [
	"Can be called in any process.
	It returns an action that must be executed in a UI process."

	<return: #TGtPhlowChangeUpdateAction>
	| aNewView anAction |
	aNewView := GtPhlowView empty
			on: self buildContext object
			perform: aChangeContext affectedMethodSelector
			withContext: self buildContext context.
	GtPhlowUtility
		createSafelyTabElementFor: aNewView
		stencil: (contentsBuilder value: aNewView)
		andDo: [ :aNewTab | 
			anAction := GtPhlowChangeUpdateAction new
					changeAction: self;
					changeContext: aChangeContext;
					preparationResult: (GtPhlowChangeViewAndElementPreparation new
							phlowView: aNewView;
							element: aNewTab) ].
	^ anAction ifNil: [ GtPhlowChangeEmptyUpdateAction default ]
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

{ #category : #'api - actions' }
GtPhlowChangeTabGroupAddTabAction >> update: aResult on: aChangeContext [
	"Must be called in a UI process."

	| aNewView aNewTab anIndex |
	aNewView := aResult phlowView.
	aNewTab := aResult element.
	aChangeContext isTabSelected ifTrue: [ aNewTab select ].
	anIndex := GtPhlowUtility findIndexFor: aNewView in: self compositeView views.
	self tabGroup addTab: aNewTab at: anIndex.
	self compositeView views add: aNewView beforeIndex: anIndex
]
