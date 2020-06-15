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
	[ self createTabElementFor: aPhlowView andDo: aBlock ]
		on: Error
		do: [ :anException | 
			self createTabErrorElementFor: aPhlowView withError: anException andDo: aBlock ] 
]

{ #category : #'instance creation' }
GtPhlowUtility class >> createTabElementFor: aPhlowView andDo: aBlock [
	"we explicitly traverse the collection because it is possible for
	asElementDo: to not return anything when we deal with an EmptyView"
	aPhlowView ifItHasContent: [ 
		| aTab |
		 aTab := BrTab new.
		self registerShowDefinitionEventOn: aTab forView: aPhlowView.
		aTab phlow
			beView;
			entity: aPhlowView.
		aTab
			look: BrGlamorousTabLook;
			label: aPhlowView title;
			stencil: [
				| aTaskItView |
				aTaskItView := aPhlowView asTaskItView.
				aTaskItView asElementDo: [ :element | 
					element phlow beViewContent; entity: aTaskItView.
					element asScrollableElement ] ];
			toolbarStencil: [ aPhlowView actionsToolbarForElement: aTab ].
		aBlock value: aTab ]
]

{ #category : #'instance creation' }
GtPhlowUtility class >> createTabErrorElementFor: aPhlowView withError: anException andDo: aBlock [
	| aTab |
	anException freeze.
	anException messageText: 'You likely did not return the proper view (' 
		, anException messageText , ')'.
	aTab := BrTab new
		look: BrGlamorousTabLook;
		label: 'Error';
		stencil: [ anException asDebuggableElement ].
	aTab phlow
			beView;
			entity: aPhlowView.
	aBlock value: aTab.
]

{ #category : #enumerating }
GtPhlowUtility class >> findIndexFor: aNewPhlowView in: aGtPhlowViews [
	<return: #Integer>
	^ aGtPhlowViews 
		detectIndex: [ :anExistingPhlowView | 
			self hasHigherPriority: aNewPhlowView than: anExistingPhlowView. ]
		ifNone: [ aGtPhlowViews size + 1 ].
]

{ #category : #testing }
GtPhlowUtility class >> hasHigherPriority: aViewOrActionOne than: aViewOrActionTwo [
	^ [ aViewOrActionOne priority < aViewOrActionTwo priority ]
			on: Error
			do: [ :anException | anException return: true ]
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

{ #category : #subscriptions }
GtPhlowUtility class >> registerShowDefinitionEventOn: aBrTab forView: aPhlowView [
	aBrTab
		when: BlMouseDownEvent
		do: [ :anEvent | 
			(self isDefinitionRequested: anEvent)
				ifTrue: [ 
					anEvent consumed: true.
					aBrTab phlow spawnObject: aPhlowView allDefiningMethods ] ]
]

{ #category : #sorting }
GtPhlowUtility class >> sortByPriority: aGtPhlowViews [
	aGtPhlowViews sort: [ :a :b | 
		self hasHigherPriority: a than: b ].
]
