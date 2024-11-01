Class {
	#name : #GtPhlowUtility,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Utilities'
}

{ #category : #enumerating }
GtPhlowUtility class >> compositeViewElementIn: anElement [
	"Return a composite view element that was constructed using GtPhlowCompositeView."
	<return: #BrTabGroup or: nil>
	anElement phlow 
		firstChildWithCompositeViewDo: [ :aBrTabGroup | ^ aBrTabGroup ].
	^ nil
]

{ #category : #'instance creation' }
GtPhlowUtility class >> createSafelyTabElementFor: aPhlowView andDo: aBlock [
	"We remove the updates on method changes, because
	this Phlow view is part of composite view which takes
	care of updates on method changes."
	aPhlowView autoUpdates removeUpdateOnMethodChanged.
	
	[ self createTabElementFor: aPhlowView andDo: aBlock ]
		on: Error
		do: [ :anException | 
			self createTabErrorElementFor: aPhlowView withError: anException andDo: aBlock ] 
]

{ #category : #'instance creation' }
GtPhlowUtility class >> createSafelyTabElementFor: aPhlowView stencil: aStencil andDo: aBlock [
	aPhlowView autoUpdates removeUpdateOnMethodChanged.
	[ self createTabElementFor: aPhlowView stencil: aStencil andDo: aBlock ]
		on: Error
		do: [ :anException | 
			self createTabErrorElementFor: aPhlowView withError: anException andDo: aBlock ] 
]

{ #category : #'instance creation' }
GtPhlowUtility class >> createTabElementFor: aPhlowView andDo: aBlock [
	"we explicitly traverse the collection because it is possible for
	asElementDo: to not return anything when we deal with an EmptyView"

	self
		createTabElementFor: aPhlowView
		stencil: [ self newElementForView: aPhlowView ]
		andDo: aBlock
]

{ #category : #'instance creation' }
GtPhlowUtility class >> createTabElementFor: aPhlowView stencil: aStencil andDo: aBlock [
	"we explicitly traverse the collection because it is possible for
	asElementDo: to not return anything when we deal with an EmptyView"
	aPhlowView ifItHasContent: [ 
		| aTab |
		aTab := BrTab new.
		aTab phlow
			beView;
			entity: aPhlowView.
		aTab
			aptitude: BrGlamorousTabAptitude +
				(GtPhlowBrowseDefinitionAptitude new
					definition: [ aPhlowView allDefiningMethods ]);
			label: aPhlowView title;
			stencil: aStencil;
			toolbarStencil: [ self newToolbarForTab: aTab view: aPhlowView ].
		aPhlowView attachTooltipFor: aTab.
		aBlock value: aTab ]
]

{ #category : #'instance creation' }
GtPhlowUtility class >> createTabErrorElementFor: aPhlowView withError: anException andDo: aBlock [
	| aTab |
	anException freeze.
	anException messageText: 'You likely did not return the proper view (' 
		, anException messageText , ')'.
	aTab := BrTab new
		aptitude: BrGlamorousTabAptitude;
		label: 'Error';
		stencil: [ anException asDebuggableElement ].
	aTab phlow
			beView;
			entity: aPhlowView.
	GtPhlowTooltipLabelBuilder new
		text: 'You likely did not return the proper view';
		applyOn: aTab.
	aBlock value: aTab.
]

{ #category : #testing }
GtPhlowUtility class >> defaultPriority [
	^ 75
]

{ #category : #enumerating }
GtPhlowUtility class >> findIndexFor: aNewPhlowView in: aGtPhlowViews [
	<return: #Integer>
	| anIndex |
	anIndex := 1.
	aGtPhlowViews do: [ :anExistingPhlowView | 
		anExistingPhlowView ifItHasContent: [ 
			(self hasHigherPriority: aNewPhlowView than: anExistingPhlowView)
					ifTrue: [ ^ anIndex ].
			anIndex := anIndex + 1 ] ].

	^ anIndex
]

{ #category : #testing }
GtPhlowUtility class >> hasHigherPriority: aViewOrActionOne than: aViewOrActionTwo [
	^ (aViewOrActionOne priority ifNil: [ self defaultPriority ])
		< (aViewOrActionTwo priority ifNil: [ self defaultPriority ])
]

{ #category : #testing }
GtPhlowUtility class >> isDefinitionRequested: anEvent [
	"Return true, if a user wants to see an action definition"
	<return: #Boolean>
	^ anEvent modifiers isAlt and: [ 
		anEvent modifiers isCmd not and: [ 
			anEvent modifiers isCtrl not and: [ 
				anEvent modifiers isShift not ] ] ]
]

{ #category : #'instance creation' }
GtPhlowUtility class >> newElementForView: aPhlowView [
		| aTaskItView |
		aTaskItView := aPhlowView asTaskItView.
		^ aTaskItView asElementDo: [ :anElement | 
			anElement phlow beViewContent.
			anElement asScrollableElement ] 
]

{ #category : #'instance creation' }
GtPhlowUtility class >> newItemLabel [

	^ BrLabel new
		  aptitude: BrGlamorousListLabelAptitude;
		  alignCenterLeft;
		  hMatchParent;
		  vFitContent
]

{ #category : #'instance creation' }
GtPhlowUtility class >> newToolbarForTab: aTab view: aPhlowView [ 
	<return: #BrToolbar>
	^ aPhlowView actionsToolbarForElement: aTab
]

{ #category : #sorting }
GtPhlowUtility class >> sortByPriority: aGtPhlowViews [
	aGtPhlowViews sort: [ :a :b | 
		self hasHigherPriority: a than: b ].
]
