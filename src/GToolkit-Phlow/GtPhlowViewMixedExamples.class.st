"
!Phlow views by example 

!!Explicit view

The most fine grained view is the explicit one through which you can specify the detailed stencil to be used to create the final element.

${example:GtPhlowViewMixedExamples>>#explicitViewWithElementStencil|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$


!!Text view

${example:GtPhlowViewMixedExamples>>#textView|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$

!!List view

${example:GtPhlowViewMixedExamples>>#listView|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$


!!Columned view

${example:GtPhlowColumnedListViewExamples>>#viewWithItems|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$

"
Class {
	#name : #GtPhlowViewMixedExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #updating }
GtPhlowViewMixedExamples >> announceDefiningMethodChange [
	<gtExample>
	| aMethods anAnnouncements aDemo |
	aDemo := GtPhlowDemoDefinitionsExamples new.
	aMethods := self definingMethods.
	anAnnouncements := OrderedCollection new.
	aMethods
		when: GtPhlowDefinitionUpdated
		do: [ :anAnnouncement | anAnnouncements add: anAnnouncement ].
	aDemo compileFooMethod.
	self assert: anAnnouncements size equals: 1.
	^ aMethods
]

{ #category : #'examples - auto-updated views' }
GtPhlowViewMixedExamples >> autoUpdatedForwardedView [
	<gtExample>
	<noTest>
	| anAnnouncer aView aParent anElementOne aSpace |
	anAnnouncer := Announcer new.
	aView := self forwardedView
		updateWhen: Announcement in: [ anAnnouncer ].
	aParent := BlElement new.
	anElementOne := aView asElementDo: [ :anElement | anElement ].
	aParent addChild: anElementOne.
	BlUseAsyncFeatures disableDuring: [ 
		anAnnouncer announce: Announcement new ].
	self assert: aParent taskQueue asArray size equals: 1.
	aSpace := BlSpace new.
	aSpace addChild: aParent.
	aSpace pulse.
	self assert: aParent childrenCount equals: 1.
	self assert: (aParent children first == anElementOne) not.
	self assert: anElementOne hasParent not.
	^ aView
]

{ #category : #'examples - columned tree view' }
GtPhlowViewMixedExamples >> columnedTreeViewWithItems [
	<gtExample>
	| aView anElement |
	aView := self emptyColumnedTreeView.
	aView items: [ 1 to: 10 ].
	aView column: 'x' item: [ :aNumber | aNumber ].
	aView column: 'x * x' item: [ :aNumber | aNumber * aNumber ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: anElement children second viewModel root children size equals: 10.
	^ aView
]

{ #category : #'examples - columned tree view' }
GtPhlowViewMixedExamples >> columnedTreeViewWithItemsAndChildren [
	<gtExample>
	| aView anElement |
	aView := self columnedTreeViewWithItems.
	aView items: [ 1 to: 10 ].
	aView children: [ :aNumber | aNumber < 3 ifTrue: [ #() ] ifFalse: [ 1 to: (aNumber - 1) ] ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: anElement children second viewModel root children size equals: 10.
	^ aView
]

{ #category : #'examples - columned tree view' }
GtPhlowViewMixedExamples >> columnedTreeViewWithItemsAndChildren_WithChildrenError [
	<gtExample>
	| aView anElement |
	aView := self columnedTreeViewWithItems.
	aView items: [ 1 to: 10 ].
	aView children: [ :aNumber | 21/0. aNumber < 3 ifTrue: [ #() ] ifFalse: [ 1 to: (aNumber - 1) ] ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement class equals: BrFrame.
	^ aView
]

{ #category : #'examples - columned tree view' }
GtPhlowViewMixedExamples >> columnedTreeViewWithItems_WithItemsError [
	<gtExample>
	| aView anElement |
	aView := self columnedTreeViewWithItems.
	aView items: [ 4/0. 1 to: 10 ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement class equals: BrFrame.
	^ aView
]

{ #category : #examples }
GtPhlowViewMixedExamples >> compositeView [
	<gtExample>
	| view element |
	view := GtPhlowView empty composite views: {self explicitViewWithElementStencil}.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BrTabGroup).
	self assert: element phlow isView.
	self assert: element phlow entity = view.
	^ view
]

{ #category : #updating }
GtPhlowViewMixedExamples >> definingMethods [
	<gtExample>
	| aMethods aDemo |
	aDemo := GtPhlowDemoDefinitionsExamples new.
	aMethods := GtPhlowAnnouncingDefiningMethods new
		methods: aDemo collectionOfDefiningMethods.
	self assert: aMethods methods equals: aDemo collectionOfDefiningMethods.
	^ aMethods
]

{ #category : #'examples - columned tree view' }
GtPhlowViewMixedExamples >> emptyColumnedTreeView [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty columnedTree.
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: anElement phlow isView.
	self assert: anElement phlow entity equals: aView.
	^ aView
]

{ #category : #examples }
GtPhlowViewMixedExamples >> emptyExplicitView [
	<gtExample>
	| view element |
	view := self explicitViewWithElementStencil empty.
	view asElementDo: [ :el | element := el ].
	self assert: element isNil.
	^ view
]

{ #category : #'examples - tree view' }
GtPhlowViewMixedExamples >> emptyTree [
	<gtExample>
	| aView anElement |
	aView := GtPhlowView empty tree.
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BrColumnedTree).
	self assert: anElement phlow isView.
	self assert: anElement phlow entity equals: aView.
	^ aView
]

{ #category : #updating }
GtPhlowViewMixedExamples >> explicitViewUpdate [
	<gtExample>
	| aView anElement aColor aParent |
	aColor := Color red.
	aView := GtPhlowView empty explicit 
		title: 'Sample';
		stencil: [ BlElement new background: aColor ].
	aView asElementDo: [ :el | anElement := el ].
	self assert: (anElement isKindOf: BlElement).
	self assert: anElement phlow isView.
	self assert: anElement background paint color equals: Color red.
	aParent := BlElement new addChild: anElement.
	aColor := Color green.
	BlUseAsyncFeatures disableDuring: [ anElement phlow update ].
	self assert: aParent children first background paint color equals: Color green.
	self assert: aParent children first phlow isView.
	^ aParent
]

{ #category : #examples }
GtPhlowViewMixedExamples >> explicitViewWithElementStencil [
	<gtExample>
	| view element |
	view := GtPhlowView empty explicit 
		title: 'Sample';
		stencil: [ BlElement new ].
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BlElement).
	self assert: element phlow isView.
	^ view
]

{ #category : #'extra actions' }
GtPhlowViewMixedExamples >> extraViewActions [
	<gtExample>
	| aView anExtendedViewCollection anExtendedView anActions anAction aLabeledViewActions |
	aView := self gtViewsFor: GtPhlowView empty.
	anExtendedViewCollection := aView originalView views select: [ :eachView | eachView definingMethod selector = #gtViewWithExtraActionsFor: ].
	self assert: anExtendedViewCollection size equals: 1.
	anExtendedView := anExtendedViewCollection first.
	self assert: anExtendedView actions isNotEmpty.
	anActions := anExtendedView actions select: [ :eachAction | eachAction definingMethod selector = #gtExtraViewActionFor: ].
	self assert: anActions size equals: 1.
	anAction := anActions first.
	self assert: anAction target definingMethodSelector equals: #gtViewWithExtraActionsFor:.
	"Labeled view should not have the view action"
	aLabeledViewActions := aView actions select: [ :eachAction | eachAction definingMethod selector = #gtExtraViewActionFor: ].
	self assert: aLabeledViewActions isEmpty.
	"Let's remove other views for this example"
	aView originalView views removeAllSuchThat: [ :eachView | eachView ~= anExtendedView ].
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowViewMixedExamples >> forwardedIntegerView [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ 2 ];
		view: #gtPreviewFor:.

	self assert: aView viewObject equals: 2.
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BlElement).
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowViewMixedExamples >> forwardedTransformedIntegerView [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ 2 ];
		view: #gtPreviewFor:;
		transformed: #asScrollableElement.

	self assert: aView viewObject equals: 2.
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BlScrollableElement).
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowViewMixedExamples >> forwardedView [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ self ];
		view: #gtUpdatingFor:.

	"Assertions before initializing forwarded phlow"
	self assert: aView title equals: 'Forwarded'.
	self assert: aView priority isNumber.
	self assert: aView object isNotNil.
	self assert: aView object class equals: [ nil ] class.
	self assert: aView viewSymbol equals: #gtUpdatingFor:.
	self assert: aView viewObject equals: self.
	self assert: aView actions size equals: 0.

	"Assertions after the forwarded view initialization"
	self assert: aView phlowView isNotNil.
	self assert: aView phlowView equals: aView phlowView.
	
	aView title: 'Forwarded view'.
	self assert: aView title equals: 'Forwarded view'.

	self assert: aView actions size equals: 0.
	self assert: aView allActions size equals: 1.
	self assert: aView actions size equals: 1.
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BlElement).
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowViewMixedExamples >> forwardedViewWithObjectCreationError [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ Error signal. self ];
		view: #gtUpdatingFor:.

	"Assertions before initializing forwarded phlow"
	self assert: aView title equals: 'Forwarded'.
	self assert: aView priority isNumber.
	self assert: aView object isNotNil.
	self assert: aView object class equals: [ nil ] class.
	self assert: aView viewSymbol equals: #gtUpdatingFor:.
	self assert: aView viewObject class equals: Error.
	self assert: aView actions size equals: 0.

	"Assertions after the forwarded view initialization"
	self assert: aView phlowView isNotNil.
	self assert: aView phlowView class equals: GtPhlowViewWithError.
	self assert: aView phlowView error signalerContext method selector equals: #forwardedViewWithObjectCreationError.
	
	self assert: ((aView asElementDo: [ :anElement | anElement ]) isKindOf: BlElement).
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowViewMixedExamples >> forwardedWithTransformationError [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ 2 ];
		view: #gtPreviewFor:;
		transformed: [ :anElement | Error signal. anElement asScrollableElement ].

	self assert: aView viewObject equals: 2.
	self assert: (aView asElementDo: [ :anElement | anElement ]) class equals: BrFrame.
	^ aView
]

{ #category : #'forwarded view' }
GtPhlowViewMixedExamples >> forwardedWithUndefinedViewMessage [
	<gtExample>
	| aView |
	aView := GtPhlowForwarderView new
		object: [ self ];
		view: #gtUndefinedViewMessageFor:.

	self assert: aView viewObject equals: self.
	self assert: aView phlowView class equals: GtPhlowViewWithError.
	self assert: (aView asElementDo: [ :anElement | anElement ]) class equals: BrFrame.
	^ aView
]

{ #category : #'gt-extension' }
GtPhlowViewMixedExamples >> gtExtraObjectActionFor: anAction [
	<gtAction>
	^ anAction button
		label: 'I am a labeled view action';
		priority: 60
]

{ #category : #'gt-extension' }
GtPhlowViewMixedExamples >> gtExtraViewActionFor: anAction [
	<gtAction>
	^ anAction button
		label: 'I am a view action';
		priority: 60;
		forViewDefinedIn: #gtViewWithExtraActionsFor:
]

{ #category : #'gt-extension' }
GtPhlowViewMixedExamples >> gtForwardedViewFor: aView [ 
	<gtView>
	^ aView forward 
		title: 'Forwarded Update on click';
		object: [ self ];
		view: #gtUpdatingFor:
]

{ #category : #'gt-extension' }
GtPhlowViewMixedExamples >> gtUpdatingFor: aView [ 
	<gtView>
	^ aView explicit 
		title: 'Update on click';
		stencil: [ BlElement new 
				look: BrShadowLook;
				background: Color random;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c margin: (BlInsets all: 40) ]  ];
		actionStencil: [ :aTab | 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons refresh asElement;
				action: [ aTab viewContentElement phlow update ] ]
]

{ #category : #'gt-extension' }
GtPhlowViewMixedExamples >> gtViewWithExceptionAtCreationFor: aView [
	<gtView>
	1/0.
	^ aView title: 'With error during view creation'
]

{ #category : #'gt-extension' }
GtPhlowViewMixedExamples >> gtViewWithExtraActionsFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Extra actions';
		text: 'Use <Alt + mouse click> on buttons to see their definitions' asRopedText monospace.
]

{ #category : #examples }
GtPhlowViewMixedExamples >> labelledCompositeViewElement [
	<gtExample>
	| view element childElementsWithView |
	view := self compositeView labelled label: 'Composite'.
	view asElementDo: [ :el | element := el ].
	self assert: element notNil.
	self assert: (element isKindOf: BrTabGroup).
	self assert: (element phlow firstChildWithView isKindOf: BrTab).
	self assert: (element phlow firstChildWithView phlow entity = view).
	self assert: (element phlow firstChildWithView viewContentElement phlow isView).
	childElementsWithView := element allChildrenBreadthFirstSelect: [:each | each phlow isView ].
	self assert: childElementsWithView size = 3.
	^ view
]

{ #category : #'extra actions' }
GtPhlowViewMixedExamples >> labelledCompositeViewShouldHaveActionsMarkedAsActions [
	<gtExample>
	| aView anElement |
	aView := self gtViewsFor: GtPhlowView empty.
	aView asElementDo: [:e | anElement := e. e forceLayout ].
	self assert: anElement notNil.
	self assert: anElement phlow allChildrenWithAction notEmpty.
	"Removed the next assert because on Jenkins it is either 3 or 4, randomly"
	"self assert: anElement phlow allChildrenWithAction size equals: 3."
	^ anElement
]

{ #category : #'reused views' }
GtPhlowViewMixedExamples >> levelOneView [
	<gtExample>
	| aViews |
	aViews := GtPhlowViewsCollector new
		pragmaName: #gtLevelOneView;
		fromObject: self;
		collect.
	self assert: aViews size equals: 1.
	self assert: aViews first definingMethod selector equals: #levelOneViewFor:.
	self assert: aViews first class equals: GtPhlowTextEditorView.
	^ aViews first
]

{ #category : #'reused views' }
GtPhlowViewMixedExamples >> levelOneViewFor: aView [
	<gtView>
	<gtLevelOneView>
	^ aView textEditor
		title: 'Level One';
		text: [ 'Level One' ]
]

{ #category : #'reused views' }
GtPhlowViewMixedExamples >> levelTwoView [
	<gtExample>
	| aViews |
	aViews := GtPhlowViewsCollector new
		pragmaName: #gtLevelTwoView;
		fromObject: self;
		collect.
	self assert: aViews size equals: 1.
	self assert: aViews first definingMethod class equals: GtPhlowDefiningMethods.
	self assert: aViews first definingMethod methods size equals: 2.
	self assert: aViews first definingMethod methods first selector equals: #levelTwoViewFor:.
	self assert: aViews first definingMethod methods second selector equals: #levelOneViewFor:.
	^ aViews first
]

{ #category : #'reused views' }
GtPhlowViewMixedExamples >> levelTwoViewFor: aView [
	<gtView>
	<gtLevelTwoView>
	^ (self levelOneViewFor: aView)
		title: 'Level Two';
		text: [ 'Level Two' ]
]

{ #category : #examples }
GtPhlowViewMixedExamples >> listView [
	<gtExample>
	| view element |
	view := GtPhlowView empty list items: (1 to: 100).
	view asElementDo: [ :el | element := el ].
	self assert: element class equals: BlSceneInformingElement.
	self assert: element childrenCount equals: 1.
	self assert: element children first class equals: BrColumnedList.
	self assert: element phlow isView.
	self assert: element phlow entity equals: view.
	^ view
]

{ #category : #'gt-extension' }
GtPhlowViewMixedExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #'secure execution' }
GtPhlowViewMixedExamples >> onPerformWithErrorAtCreation [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtViewWithExceptionAtCreationFor:.
	self assert: aView class equals: GtPhlowViewWithError.
	self 
		assert: aView definingMethod 
		equals: (self class >> #gtViewWithExceptionAtCreationFor:) asRingDefinition.
	^ aView
]

{ #category : #'secure execution' }
GtPhlowViewMixedExamples >> onPerformWithNonExistingMethodError [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #nonExistingMethod:.
	self assert: aView class equals: GtPhlowViewWithError.
	^ aView
]

{ #category : #'secure execution' }
GtPhlowViewMixedExamples >> onPerformWithNonExistingMethodErrorBlocElement [
	<gtExample>
	| aView anElement |
	aView := self onPerformWithNonExistingMethodError.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement
]

{ #category : #'secure execution' }
GtPhlowViewMixedExamples >> onPerformWithoutError [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtViewsFor:.
	self assert: aView class equals: GtPhlowLabelledView.
	self assert: aView originalView originalView class equals: GtPhlowEmptyView.
	^ aView
]

{ #category : #'secure execution' }
GtPhlowViewMixedExamples >> onPerformWithoutErrorBlocElement [
	<gtExample>
	| aView anElement |
	aView := self onPerformWithoutError.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement
]

{ #category : #examples }
GtPhlowViewMixedExamples >> textView [
	<gtExample>
	| view element |
	view := GtPhlowView empty textEditor text: 'abc' asRopedText.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BrEditorElement).
	self assert: element phlow isView.
	self assert: element phlow entity equals: view.
	^ view
]

{ #category : #'examples - tree view' }
GtPhlowViewMixedExamples >> treeViewWithItems [
	<gtExample>
	| aView anElement |
	aView := self emptyTree.
	aView items: [ 1 to: 10 ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BrColumnedTree).
	self assert: anElement viewModel root children size equals: 10.
	^ aView
]

{ #category : #'examples - tree view' }
GtPhlowViewMixedExamples >> treeViewWithItemsAndChildren [
	<gtExample>
	| aView anElement |
	aView := self treeViewWithItems.
	aView children: [ :aNumber | aNumber // 2 to: aNumber ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: (anElement isKindOf: BrColumnedTree).
	self assert: anElement viewModel root children size equals: 10.
	^ aView
]

{ #category : #'examples - tree view' }
GtPhlowViewMixedExamples >> treeViewWithItemsAndChildrenWithChildrenError [
	<gtExample>
	| aView anElement |
	aView := self treeViewWithItems.
	aView children: [ :aNumber | 3/0. aNumber // 2 to: aNumber ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement class equals: BrFrame.
	^ aView
]

{ #category : #'examples - tree view' }
GtPhlowViewMixedExamples >> treeViewWithItemsWithItemsError [
	<gtExample>
	| aView anElement |
	aView := self emptyTree.
	aView items: [ 3/0. 1 to: 10 ].
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement class equals: BrFrame.
	^ aView
]

{ #category : #updating }
GtPhlowViewMixedExamples >> updatingExtension [
	<gtExample>
	^ self
]
