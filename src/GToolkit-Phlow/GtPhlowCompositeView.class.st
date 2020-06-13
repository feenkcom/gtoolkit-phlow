Class {
	#name : #GtPhlowCompositeView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'views'
	],
	#category : #'GToolkit-Phlow-! Views and Actions'
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
	"we explicitly traverse the collection because it is possible for
	asElementDo: to not return anything when we deal with an EmptyView"
	GtPhlowUtility 
		createTabElementFor: aPhlowView 
		andDo: [ :aTab | aCollectionOfTabs add: aTab ]
]

{ #category : #converting }
GtPhlowCompositeView >> asElementDo: aBlock [
	| tabs group |
	tabs := OrderedCollection new.
	self views ifNotNil: [ :currentViews |
		currentViews do: [ :view | 
			[ self addNewTabTo: tabs forView: view ]
				on: Error
				do: [ :e | self addErrorTabTo: tabs withError: e ] ] ].
	group := BrTabGroup new.
	self beViewElement: group.
	group
		look: BrGlamorousTabGroupLook;
		addTabs: tabs.
	^ aBlock value: group
]

{ #category : #'adding - update definitions' }
GtPhlowCompositeView >> defaultUpdateDefinitions [
	^ super defaultUpdateDefinitions copyWith: 
		GtPhlowUpdateCompositeSubViewsOnMethodDefinitionChange new
]

{ #category : #ui }
GtPhlowCompositeView >> gtContainedViewsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Views' translated;
		items: [ self views ];
		column: 'View' format: [:each | each gtDisplayString];
		column: 'Title' format: [:each | each title ]
]

{ #category : #accessing }
GtPhlowCompositeView >> views [
	^ views
]

{ #category : #accessing }
GtPhlowCompositeView >> views: anObject [
	views := anObject
]
