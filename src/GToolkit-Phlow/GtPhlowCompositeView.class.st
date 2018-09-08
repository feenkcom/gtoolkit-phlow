Class {
	#name : #GtPhlowCompositeView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'views'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #private }
GtPhlowCompositeView >> addErrorTabTo: aCollectionOfTabs withError: anException [
	anException freeze.
	anException messageText: 'You likely did not return the proper view (' 
		, anException messageText , ')'.
	aCollectionOfTabs
		add:
			(BrTab new
				look: BrGlamorousTabLook;
				label: 'Error';
				stencil: [ anException asDebuggableElement ])
]

{ #category : #private }
GtPhlowCompositeView >> addNewTabTo: aCollectionOfTabs forView: aPhlowView [
	| aTab |
	"we explicitly traverse the collection because it is possible for
	asElementDo: to not return anything when we deal with an EmptyView"
	aPhlowView
		ifItHasContent: [ aTab := BrTab new.
			self registerShowDefinitionEventOn: aTab forView: aPhlowView.
			aTab phlow
				beView;
				entity: aPhlowView.
			aTab
				look: BrGlamorousTabLook;
				label: aPhlowView title;
				stencil: [ aPhlowView asTaskItView
						asElementDo: [ :element | 
							element phlow beViewContent.
							element asScrollableElement margin: (BlInsets all: 10) ] ];
				actionsStencil: (aPhlowView actionsToolbarForElement: aTab).
			aCollectionOfTabs add: aTab ]
]

{ #category : #converting }
GtPhlowCompositeView >> asElementDo: aBlock [
	| tabs group |
	tabs := OrderedCollection new.
	self views do: [ :view | 
		[ self addNewTabTo: tabs forView: view ]
			on: Error
			do: [ :e | self addErrorTabTo: tabs withError: e ] ].
	group := BrTabGroup new.
	group phlow
		beView;
		entity: self.
	group
		look: BrGlamorousTabGroupLook;
		addTabs: tabs.
	^ aBlock value: group
]

{ #category : #private }
GtPhlowCompositeView >> registerShowDefinitionEventOn: tab forView: view [
	tab
		when: BlMouseDownEvent
		do: [ :event | 
			event modifiers isAlt
				ifTrue: [ event consumed: true.
					tab
						fireEvent:
							(GtPhlowObjectToSpawn new
								object: view definingMethod;
								sourceElement: tab) ] ]
]

{ #category : #accessing }
GtPhlowCompositeView >> views [
	^ views
]

{ #category : #accessing }
GtPhlowCompositeView >> views: anObject [
	views := anObject
]
