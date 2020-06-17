"
I exemplify ${class:GtPhlowCompositeView}$.
"
Class {
	#name : #GtPhlowCompositeViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> addViewThreeDefinition [
	<gtExample>
	| aTabGroup aView aCommand aNewSubView aContainer anInitialTabs aFinalTabs |
	aContainer := self container.
	aTabGroup := self element.
	anInitialTabs := aTabGroup viewModel tabs copy.

	aContainer addChild: aTabGroup.
	aView := aTabGroup phlow entity.
	aNewSubView := self subViewThree.
	
	aCommand := GtPhlowAddCompositeSubView new
		elementContext: aTabGroup phlow;
		compiledMethod: aNewSubView definingMethod compiledMethod.
	BlUseAsyncFeatures disableDuring: [
		aCommand execute ].

	aFinalTabs := aTabGroup viewModel tabs copy.

	self assert: aFinalTabs size equals: 3.
	self assert: aFinalTabs first equals: anInitialTabs first.
	self assert: aFinalTabs second equals: anInitialTabs second.
	self assert: aFinalTabs third widget label asString equals: 'Auto Updating Text'.

	self assert: aView views size equals: 3.
	self assert: aView views third title asString equals: 'Auto Updating Text'.

	^ aContainer
]

{ #category : #'examples - elements' }
GtPhlowCompositeViewExamples >> element [
	<gtExample>
	| aView aTabGroup anInitialTabs |
	aView := self phlowView.
	aTabGroup := aView asElementDo: [ :theElement | theElement ].

	self assertViewElement: aTabGroup ofClass: BrTabGroup inView: aView.

	anInitialTabs := aTabGroup viewModel tabs.
	self assert: anInitialTabs size equals: 2.
	self assert: anInitialTabs first widget label asString equals: 'View One'.
	self assert: anInitialTabs second widget label asString equals: 'View Two'.
	
	^ aTabGroup
]

{ #category : #'examples - sub-views' }
GtPhlowCompositeViewExamples >> gtAutoUpdatingFor: aView [
	^ GtPhlowTextEditorViewExamples new gtAutoUpdatingFor: aView
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
	aView buildContext: (GtPhlowBuildContext new 
		object: self;
		argument: aView originalView).
	theSubViews := { self subViewOne. self subViewTwo } asOrderedCollection.
	aView views: theSubViews.
	self assert: aView views equals: theSubViews.
	^ aView
]

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> removeViewOneDefinition [
	<gtExample>
	| aTabGroup aView aSubView aCommand aContainer anInitialTabs aFinalTabs |
	aContainer := self container.
	aTabGroup := self element.
	anInitialTabs := aTabGroup viewModel tabs copy.

	aContainer addChild: aTabGroup.
	aView := aTabGroup phlow entity.
	aSubView := aView views first.
	
	aCommand := GtPhlowRemoveCompositeSubView new
		elementContext: aTabGroup phlow;
		compiledMethod: aSubView definingMethod compiledMethod.
	BlUseAsyncFeatures disableDuring: [
		aCommand execute ].

	aFinalTabs := aTabGroup viewModel tabs copy.

	self assert: aFinalTabs size equals: 1.
	self assert: aFinalTabs first equals: anInitialTabs second.
	self assert: aFinalTabs first widget label asString equals: 'View Two'.

	^ aContainer
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
