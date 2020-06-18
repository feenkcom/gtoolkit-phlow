"
I compose several views that are displayed using ${class:BrTabGroup}$.

I am typically used by other tools, e.g., inspectors and coders, to build a composition of object views. To build such views, Phlow provides ${class:GtPhlowViewsCollector}$ to collect subviews for a given object, and ${class:GtPhlowCompositeViewBuilder}$ to build composite views. It is quite unusual defining composite views by users.

!! Example

A definition like this:

${method:GtPhlowCompositeViewExamples>>#gtPhlowViewFor:|expanded=true}$

Is represented in tools as in following example:
${example:GtPhlowCompositeViewExamples>>#phlowView|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:}$

"
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
			nextPut: GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange new;
			nextPut: GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange new ]
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
GtPhlowCompositeView >> views: aCollection [
	views := aCollection asOrderedCollection
]
