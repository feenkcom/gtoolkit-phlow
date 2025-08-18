"
I update a {{gtClass:GtPhlowCompositeView}} subview and its corresponding {{gtClass:BrTab}} label and position in {{gtClass:BrTabGroup}}.
I am used by {{gtClass:GtPhlowUpdateCompositeSubViewListOnDefiningMethodChange}} and by {{gtClass:GtPhlowUpdateCompositeSubViewTitlesAndPositionsOnDefiningMethodChange}}.

1. # Updating Tab


The first tab:

{{gtExample:GtPhlowCompositeViewExamples>>#element|codeExpanded=false|previewExpanded=true}}

is moved to the second position and renamed:

{{gtExample:GtPhlowCompositeViewExamples>>#updateViewOneDefinition|codeExpanded=false|previewExpanded=true}}


1. # Removing Tab


If a new view is in instance of {{gtClass:GtPhlowEmptyView}}, the tab is removed. In the same example above, the first tab is removed in such scenario: 

{{gtExample:GtPhlowCompositeViewExamples>>#updateViewOneDefinition_ByEmptyView|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtPhlowUpdateCompositeSubViewTitleAndPosition,
	#superclass : #GtPhlowUpdateCommand,
	#instVars : [
		'subView'
	],
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #comparing }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> = anObject [
	^ super = anObject and: [ 
		self subViewDefiningMethod = anObject subViewDefiningMethod ]
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> basicRemoveTabModel: aTabModel [
	self element viewModel removeTab: aTabModel.
	self view views remove: self subView ifAbsent: [ "ignore" ].
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> basicUpdateTabModel: aTabModel with: aNewSubView [
	| aNewIndex aCurrentIndex |
	self view views remove: self subView ifAbsent: [ ].
	aNewIndex := GtPhlowUtility
		findIndexFor: aNewSubView
		in: self view views.
	aTabModel widget label: aNewSubView title value asRopedText.
	aTabModel stencil: [ GtPhlowUtility newElementForView: aNewSubView ].
	aTabModel toolbarStencil: [ GtPhlowUtility newToolbarForTab: aTabModel widget view: aNewSubView ].
	self element viewModel moveTab: aTabModel at: aNewIndex.
	aCurrentIndex := self view views indexOf: self subView.
	self view views add: aNewSubView beforeIndex: aNewIndex.
]

{ #category : #'accessing - ui' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> detectTab [
	^ self element viewModel tabs 
		detect: [ :eachTabModel | (eachTabModel widget phlow entity = self subView)
			or: [ eachTabModel widget phlow entity definingMethod = self subViewDefiningMethod ] ]
		ifFound: [ :aTabModel | aTabModel ]
		ifNone: [ nil "Trying to find a tab that does not exist" ].
]

{ #category : #evaluating }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> execute [
	<return: #GtPhlowView>
	| aTabModel aNewSubView |
	aTabModel := self detectTab.
	aTabModel ifNil: [ ^ self ].
	aNewSubView := self newPhlowSubView.
	aNewSubView ifItHasContent: [
		self updateTabModel: aTabModel with: aNewSubView.
		^ aNewSubView ].
	self removeTabModel: aTabModel.
	^ aNewSubView
]

{ #category : #comparing }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> hash [
	^ super hash bitXor: self subView hash
]

{ #category : #'instance creation' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> newPhlowSubView [
	^ GtPhlowView empty
		on: self subViewObject
		perform: self subViewMethodSelector
		withSomeArguments: self subViewArguments
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> removeTabModel: aTabModel [
	self scheduleValuable: [
		self basicRemoveTabModel: aTabModel ]
]

{ #category : #accessing }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> subView [
	^ subView
]

{ #category : #accessing }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> subView: anObject [
	subView := anObject
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> subViewArguments [
	^ self subViewBuildContext arguments
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> subViewBuildContext [
	^ self subView buildContext
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> subViewDefiningMethod [
	^ self subView definingMethod
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> subViewMethodSelector [
	^ self subView methodSelector
]

{ #category : #'accessing - convenience' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> subViewObject [
	^ self subViewBuildContext object
]

{ #category : #'private - updating' }
GtPhlowUpdateCompositeSubViewTitleAndPosition >> updateTabModel: aTabModel with: aNewSubView [
	self scheduleValuable: [ self basicUpdateTabModel: aTabModel with: aNewSubView ]
]
