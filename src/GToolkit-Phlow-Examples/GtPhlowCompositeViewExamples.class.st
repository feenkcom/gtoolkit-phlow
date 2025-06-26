"
I exemplify {{gtClass:GtPhlowCompositeView}}.


"
Class {
	#name : #GtPhlowCompositeViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples-Views'
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
	self assert: aFinalTabs third widget label asString equals: 'Auto updating text'.

	self assert: aView views size equals: 3.
	self assert: aView views third title asString equals: 'Auto updating text'.

	^ aContainer
]

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> addViewThreeDefinition_WithEmptyView [
	<gtExample>
	| aTabGroup aView aCommand aNewSubView aContainer anInitialTabs aFinalTabs |
	aContainer := self container.
	aTabGroup := self element.
	anInitialTabs := aTabGroup viewModel tabs copy.

	aContainer addChild: aTabGroup.
	aView := aTabGroup phlow entity.
	aNewSubView := self subViewEmpty.
	
	aCommand := GtPhlowAddCompositeSubView new
		elementContext: aTabGroup phlow;
		compiledMethod: aNewSubView definingMethod compiledMethod.
	BlUseAsyncFeatures disableDuring: [
		aCommand execute ].

	aFinalTabs := aTabGroup viewModel tabs copy.

	self assert: aFinalTabs size equals: 2.
	self assert: aFinalTabs first equals: anInitialTabs first.
	self assert: aFinalTabs second equals: anInitialTabs second.

	self assert: aView views size equals: 2.

	^ aContainer
]

{ #category : #'examples - collector' }
GtPhlowCompositeViewExamples >> collectorUsage [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtPhlowViewWithCollectorFor:.
	self assert: aView class equals: GtPhlowCompositeView.
	self assert: aView views size equals: 2.
	self assert: aView views first definingMethod selector equals: #gtTenLinesFor:.
	self assert: aView views second definingMethod selector equals: #gtAutoUpdatingFor:.
	self assert: aView autoUpdates size equals: aView defaultUpdateDefinitions size.

	^ aView
]

{ #category : #'examples - collector' }
GtPhlowCompositeViewExamples >> collectorUsageElement [
	<gtExample>
	| aView anElement |
	aView := self collectorUsage.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: anElement class equals: BrTabGroup.
	self assert: anElement viewModel tabs size equals: 2.

	^ anElement
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

{ #category : #'examples - element' }
GtPhlowCompositeViewExamples >> expectedElementClass [
	^ BrTabGroup
]

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> fireViewUpdateWish [
	"See https://github.com/feenkcom/gtoolkit/issues/4556"

	<gtExample>
	| aTabGroup aScripter someEvents anOriginalElement |
	someEvents := OrderedCollection new.
	aTabGroup := self element.
	aTabGroup
		when: GtPhlowViewUpdateWish
		do: [ :anEvent | someEvents add: anEvent ].
	aScripter := BlScripter new element: aTabGroup.

	aScripter do
		label: 'Store current view element';
		block: [ :anElement | 
			aScripter userData at: #originalElement put: anElement.
			anOriginalElement := anElement ];
		// #'phlow--random-color';
		play.

	aScripter do
		label: 'Fire view update wish';
		block: [ :anElement | anElement phlow fireViewUpdateWish ];
		play.

	self assert: someEvents size equals: 1.
	self
		assert: someEvents first isConsumed
		description: [ 'Event must be consumed' ].


	aScripter assert
		label: 'Assert element is changed';
		satisfies: [ :anElement | 
				aScripter userData at: #newElement put: anElement.
				anElement ~= anOriginalElement ]
			description: [ :anElement | 
				'Elements must be different instances: {1} vs. {2}'
					format: {anElement.
							anOriginalElement} ];
		// #'phlow--random-color';
		play.


	^ aScripter
]

{ #category : #'examples - updating' }
GtPhlowCompositeViewExamples >> fireViewUpdateWishFromContextMenu [
	"See https://github.com/feenkcom/gtoolkit/issues/4606"

	<gtExample>
	| aTabGroup aScripter someEvents aCompositeView data anItemsView |
	someEvents := OrderedCollection new.
	data := OrderedCollection withAll: (1 to: 10).
	aCompositeView := GtPhlowView empty composite.
	anItemsView := GtPhlowView new on: data perform: #gtItemsFor:.
	anItemsView
		contextItemLabel: 'Remove item'
		action: [ :anElement :anItem | 
			data remove: anItem.
			anElement phlow fireViewUpdateWish ].
	aCompositeView views: {anItemsView}.

	aTabGroup := aCompositeView asElementDo: [ :theElement | theElement ].
	aTabGroup
		when: GtPhlowViewUpdateWish
		do: [ :anEvent | someEvents add: anEvent ].
	aScripter := BlScripter new element: aTabGroup.

	aScripter assert
		label: 'Assert 10 items in the columned list';
		value: [ :anInfiniteList | anInfiniteList childrenCount ] equals: 10;
		// GtPhlowColumnedListId;
		/ #scrollable;
		play.

	aScripter menuStep
		openContextMenu;
		// GtPhlowColumnedListId;
		// GtPhlowCellElement;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		@ 1;
		play.

	aScripter menuStep
		clickMenuItemWithId: [ :anElement | (anElement isKindOf: BrLabel) and: [ anElement text asString = 'Remove item' ] ];
		onMenuContainer;
		play.

	self assert: data size equals: 9.
	self assert: (data includes: 7) not.

	self assert: someEvents size equals: 1.
	self
		assert: someEvents first isConsumed
		description: [ 'Event must be consumed' ].

	^ aScripter
]

{ #category : #'gt-extensions' }
GtPhlowCompositeViewExamples >> gtAutoUpdatingFor: aView [
	<gtDemoView>
	^ (GtPhlowTextEditorViewExamples new gtAutoUpdatingFor: aView)
		priority: 2
]

{ #category : #'gt-extensions' }
GtPhlowCompositeViewExamples >> gtPhlowEmptyViewFor: aView [
	^ GtPhlowEmptyViewExamples new gtPhlowViewFor: aView
]

{ #category : #'gt-extensions' }
GtPhlowCompositeViewExamples >> gtPhlowViewFor: aView [
	<gtView>
	^ aView composite
		title: 'Composite';
		views: { self subViewOne. self subViewTwo } asOrderedCollection
]

{ #category : #'gt-extensions' }
GtPhlowCompositeViewExamples >> gtPhlowViewWithCollectorFor: aView [
	<gtView>
	^ aView composite
		title: 'Collector';
		collectorDo: [ :aCollector | 
			aCollector
				pragmaName: #gtDemoView;
				fromObject: self ]
]

{ #category : #'gt-extensions' }
GtPhlowCompositeViewExamples >> gtTenLinesFor: aView [
	<gtDemoView>
	^ (GtPhlowListViewExamples new gtTenLinesFor: aView)
		priority: 1
]

{ #category : #'gt-extensions' }
GtPhlowCompositeViewExamples >> itself [
	<gtExample>
	^ self
]

{ #category : #'examples - view' }
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
	aView := GtPhlowView empty on: GtPhlowEmptyViewExamples new perform: #gtPhlowEmptyViewFor:.
	aView title: 'Empty View'.
	aView priority: 4.
	^ aView
]

{ #category : #'examples - sub-views' }
GtPhlowCompositeViewExamples >> subViewFour [
	<gtExample>
	| aView |
	aView := GtPhlowColumnedListViewExamples new viewWithItems.
	aView title: 'View Four'.
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
	self assert: aFinalTabs second widget label asString equals: 'Auto updating text'.

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
