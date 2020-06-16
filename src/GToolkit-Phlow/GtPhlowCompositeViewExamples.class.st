"
I exemplify ${class:GtPhlowCompositeView}$.
"
Class {
	#name : #GtPhlowCompositeViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #accessing }
GtPhlowCompositeViewExamples >> element [
	<gtExample>
	| aView anElement |
	aView := self phlowView.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: anElement class equals: BrTabGroup.
	self assert: anElement viewModel tabs size equals: 2.
	^ anElement
]

{ #category : #'gt-extensions' }
GtPhlowCompositeViewExamples >> gtPhlowViewFor: aView [
	<gtView>
	^ aView composite
		title: 'Composite View';
		views: { self subViewOne. self subViewTwo }
]

{ #category : #'gt-extensions' }
GtPhlowCompositeViewExamples >> itself [
	<gtExample>
	^ self
]

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> phlowView [
	<gtExample>
	| aView theSubViews |
	aView := GtPhlowView empty composite.
	theSubViews := { self subViewOne. self subViewTwo } asOrderedCollection.
	aView views: theSubViews.
	self assert: aView views equals: theSubViews.
	^ aView
]

{ #category : #'examples - sub-views' }
GtPhlowCompositeViewExamples >> subViewEmpty [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: GtPhlowEmptyViewExamples new perform: #gtPhlowViewFor:.
	aView title: 'Empty View'.
	aView priority: 4.
	^ aView
]

{ #category : #'examples - sub-views' }
GtPhlowCompositeViewExamples >> subViewOne [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: GtPhlowExplicitViewExamples new perform: #gtUpdatingFor:.
	aView title: 'View One'.
	aView priority: 1.
	^ aView
]

{ #category : #'examples - sub-views' }
GtPhlowCompositeViewExamples >> subViewThree [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: GtPhlowTextEditorViewExamples new perform: #gtAutoUpdatingFor:.
	aView title: 'View Three'.
	aView priority: 3.
	^ aView
]

{ #category : #'examples - sub-views' }
GtPhlowCompositeViewExamples >> subViewTwo [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: GtPhlowListViewExamples new perform: #gtTenLinesFor:.
	aView title: 'View Two'.
	aView priority: 2.
	^ aView
]

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> updateViewOneDefinition [
	<gtExample>
	| aTabGroup aView aSubView aCommand aNewSubView aContainer anInitialTabs aFinalTabs |
	aContainer := self container.
	aTabGroup := self element.
	anInitialTabs := aTabGroup viewModel tabs copy.

	self assert: anInitialTabs size equals: 2.
	self assert: anInitialTabs first widget label asString equals: 'View One'.
	self assert: anInitialTabs second widget label asString equals: 'View Two'.

	aContainer addChild: aTabGroup.
	aView := aTabGroup phlow entity.
	aSubView := aView views first.
	aNewSubView := self subViewThree.
	aSubView buildContext object: aNewSubView buildContext object.
	aSubView definingMethod: aNewSubView definingMethod.
	
	aCommand := GtPhlowUpdateCompositeSubViewTitleAndPosition new
		elementContext: aTabGroup phlow;
		subView: aSubView.
	BlUseAsyncFeatures disableDuring: [
		aCommand execute ].

	aFinalTabs := aTabGroup viewModel tabs copy.

	self assert: aFinalTabs size equals: 2.
	self assert: aFinalTabs first equals: anInitialTabs second.
	self assert: aFinalTabs second equals: anInitialTabs first.
	self assert: aFinalTabs first widget label asString equals: 'View Two'.
	self assert: aFinalTabs second widget label asString equals: 'Auto Updating Text'.

	^ aContainer
]

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> updateViewOneDefinition_ByEmptyView [
	<gtExample>
	| aTabGroup aView aSubView aCommand aNewSubView aContainer anInitialTabs aFinalTabs |
	aContainer := self container.
	aTabGroup := self element.
	anInitialTabs := aTabGroup viewModel tabs copy.

	self assert: anInitialTabs size equals: 2.
	self assert: anInitialTabs first widget label asString equals: 'View One'.
	self assert: anInitialTabs second widget label asString equals: 'View Two'.

	aContainer addChild: aTabGroup.
	aView := aTabGroup phlow entity.
	aSubView := aView views first.
	aNewSubView := self subViewEmpty.
	aSubView buildContext object: aNewSubView buildContext object.
	aSubView definingMethod: aNewSubView definingMethod.
	
	aCommand := GtPhlowUpdateCompositeSubViewTitleAndPosition new
		elementContext: aTabGroup phlow;
		subView: aSubView.
	BlUseAsyncFeatures disableDuring: [
		aCommand execute ].

	aFinalTabs := aTabGroup viewModel tabs copy.

	self assert: aFinalTabs size equals: 1.
	self assert: aFinalTabs first equals: anInitialTabs second.
	self assert: aFinalTabs first widget label asString equals: 'View Two'.

	^ aContainer
]
