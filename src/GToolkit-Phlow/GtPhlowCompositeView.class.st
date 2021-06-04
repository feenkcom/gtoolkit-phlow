"
I compose several views that are displayed using {{gtClass:BrTabGroup}}.

I am typically used by other tools, e.g., inspectors and coders, to build a composition of object views. To build such views, Phlow provides {{gtClass:GtPhlowViewsCollector}} to collect subviews for a given object, and {{gtClass:GtPhlowCompositeViewBuilder}} to build composite views. It is quite unusual defining composite views by users.

1. # Example
## Manual Definition of Sub-Views 

A definition like this:

{{gtMethod:GtPhlowCompositeViewExamples>>#gtPhlowViewFor:|expanded=true}}

Is represented in tools as in following example:
{{gtExample:GtPhlowCompositeViewExamples>>#phlowView|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:}}

1. ## Sub-View Collector Usage

A definition like this:

{{gtMethod:GtPhlowCompositeViewExamples>>#gtPhlowViewWithCollectorFor:|expanded=true}}

Is represented in tools as in following example:
{{gtExample:GtPhlowCompositeViewExamples>>#collectorUsage|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:}}


"
Class {
	#name : #GtPhlowCompositeView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'views'
	],
	#category : #'GToolkit-Phlow-! Views'
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
		aptitude: BrGlamorousTabGroupAptitude;
		addTabs: tabs.
	^ aBlock value: group
]

{ #category : #'api - building' }
GtPhlowCompositeView >> collectorDo: aBlock [
	"configure ${class:GtPhlowViewsCollector}$ to collect views"
	| aCollector |
	aCollector := GtPhlowViewsCollector new.
	aBlock value: aCollector.
	self views: aCollector collect.
]

{ #category : #'adding - update definitions' }
GtPhlowCompositeView >> defaultUpdateDefinitions [
	^ Array new: 3 streamContents: [ :aStream |
		aStream 
			nextPutAll: super defaultUpdateDefinitions;
			nextPut: GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange;
			nextPut: GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange ]
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
	<return: #Array of: #GtPhlowView>
	^ views
]

{ #category : #accessing }
GtPhlowCompositeView >> views: aCollection [
	views := aCollection asOrderedCollection
]
