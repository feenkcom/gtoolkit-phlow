Class {
	#name : #GtPhlowCompositeView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'views'
	],
	#category : #'GToolkit-Phlow-! Views and Actions'
}

{ #category : #private }
GtPhlowCompositeView >> addNewTabTo: aCollectionOfTabs forView: aPhlowView [
	"we explicitly traverse the collection because it is possible for
	asElementDo: to not return anything when we deal with an EmptyView"
	GtPhlowUtility 
		createSafelyTabElementFor: aPhlowView 
		andDo: [ :aTab | aCollectionOfTabs add: aTab ]
]

{ #category : #converting }
GtPhlowCompositeView >> asElementDo: aBlock [
	| tabs group |
	tabs := OrderedCollection new.
	self views ifNotNil: [ :currentViews |
		currentViews do: [ :view | 
			self addNewTabTo: tabs forView: view ] ].
	group := BrTabGroup new.
	self beViewElement: group.
	group
		look: BrGlamorousTabGroupLook;
		addTabs: tabs.
	^ aBlock value: group
]

{ #category : #'adding - update definitions' }
GtPhlowCompositeView >> defaultUpdateDefinitions [
	^ Array new: 3 streamContents: [ :aStream |
		aStream 
			nextPutAll: super defaultUpdateDefinitions;
			nextPut: GtPhlowUpdateCompositeSubViewTitlesOnMethodChange new;
			nextPut: GtPhlowUpdateCompositeSubViewListOnMethodChange new ]
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
