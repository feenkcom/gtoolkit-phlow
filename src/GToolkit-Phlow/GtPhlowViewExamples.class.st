"
!Phlow views by example 

!!Explicit view

The most fine grained view is the explicit one through which you can specify the detailed stencil to be used to create the final element.

${example:GtPhlowViewExamples>>#explicitViewWithElementStencil|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$


!!Text view

${example:GtPhlowViewExamples>>#textView|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$

!!List view

${example:GtPhlowViewExamples>>#listView|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$


!!Columned view

${example:GtPhlowColumnedListViewExamples>>#viewWithItems|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$

"
Class {
	#name : #GtPhlowViewExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #updating }
GtPhlowViewExamples >> announceDefiningMethodChange [
	<gtExample>
	| aMethods anAnnouncements aDemo |
	aDemo := GtPhlowDemoDefinitionsExamples new.
	aMethods := self definingMethods.
	anAnnouncements := OrderedCollection new.
	aMethods 
		subscribe: GtPhlowDefinitionUpdated
		do: [ :anAnnouncement | anAnnouncements add: anAnnouncement ].
	aDemo compileFooMethod.
	self assert: anAnnouncements size equals: 1.
	^ aMethods
]

{ #category : #examples }
GtPhlowViewExamples >> compositeView [
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
GtPhlowViewExamples >> definingMethods [
	<gtExample>
	| aMethods aDemo |
	aDemo := GtPhlowDemoDefinitionsExamples new.
	aMethods := GtPhlowAnnouncingDefiningMethods new
		methods: aDemo collectionOfDefiningMethods.
	self assert: aMethods methods equals: aDemo collectionOfDefiningMethods.
	^ aMethods
]

{ #category : #examples }
GtPhlowViewExamples >> emptyExplicitView [
	<gtExample>
	| view element |
	view := self explicitViewWithElementStencil empty.
	view asElementDo: [ :el | element := el ].
	self assert: element isNil.
	^ view
]

{ #category : #updating }
GtPhlowViewExamples >> explicitViewUpdate [
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
	GtPhlowUseTaskItView 
		value: false during: [ anElement phlow update ].
	self assert: aParent children first background paint color equals: Color green.
	self assert: aParent children first phlow isViewContent.
	^ aParent
]

{ #category : #examples }
GtPhlowViewExamples >> explicitViewWithElementStencil [
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
GtPhlowViewExamples >> extraViewActions [
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

{ #category : #'gt-extension' }
GtPhlowViewExamples >> gtExtraObjectActionFor: anAction [
	<gtAction>
	^ anAction button
		label: 'I am a labeled view action';
		priority: 60
]

{ #category : #'gt-extension' }
GtPhlowViewExamples >> gtExtraViewActionFor: anAction [
	<gtAction>
	^ anAction button
		label: 'I am a view action';
		priority: 60;
		forViewDefinedIn: #gtViewWithExtraActionsFor:
]

{ #category : #'gt-extension' }
GtPhlowViewExamples >> gtUpdatingFor: aView [ 
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
GtPhlowViewExamples >> gtViewWithExceptionAtCreationFor: aView [
	<gtView>
	1/0.
	^ aView title: 'With error during view creation'
]

{ #category : #'gt-extension' }
GtPhlowViewExamples >> gtViewWithExtraActionsFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Extra actions';
		text: 'Use <Alt + mouse click> on buttons to see their definitions' asRopedText monospace.
]

{ #category : #examples }
GtPhlowViewExamples >> labelledCompositeView [
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

{ #category : #'reused views' }
GtPhlowViewExamples >> levelOneView [
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
GtPhlowViewExamples >> levelOneViewFor: aView [
	<gtView>
	<gtLevelOneView>
	^ aView textEditor
		title: 'Level One';
		text: [ 'Level One' ]
]

{ #category : #'reused views' }
GtPhlowViewExamples >> levelTwoView [
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
GtPhlowViewExamples >> levelTwoViewFor: aView [
	<gtView>
	<gtLevelTwoView>
	^ (self levelOneViewFor: aView)
		title: 'Level Two';
		text: [ 'Level Two' ]
]

{ #category : #examples }
GtPhlowViewExamples >> listView [
	<gtExample>
	| view element |
	view := GtPhlowView empty list items: (1 to: 100).
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BrColumnedList).
	self assert: element phlow isView.
	self assert: element phlow entity equals: view.
	^ view
]

{ #category : #'gt-extension' }
GtPhlowViewExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithErrorAtCreation [
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
GtPhlowViewExamples >> onPerformWithNonExistingMethodError [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #nonExistingMethod:.
	self assert: aView class equals: GtPhlowViewWithError.
	^ aView
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithNonExistingMethodErrorBlocElement [
	<gtExample>
	| aView anElement |
	aView := self onPerformWithNonExistingMethodError.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithoutError [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: self perform: #gtViewsFor:.
	self assert: aView class equals: GtPhlowLabelledView.
	self assert: aView originalView originalView class equals: GtPhlowEmptyView.
	^ aView
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithoutErrorBlocElement [
	<gtExample>
	| aView anElement |
	aView := self onPerformWithoutError.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement
]

{ #category : #examples }
GtPhlowViewExamples >> textView [
	<gtExample>
	| view element |
	view := GtPhlowView empty textEditor text: 'abc' asRopedText.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BrEditorElement).
	self assert: element phlow isView.
	self assert: element phlow entity equals: view.
	^ view
]

{ #category : #updating }
GtPhlowViewExamples >> updatingExtension [
	<gtExample>
	^ self
]
