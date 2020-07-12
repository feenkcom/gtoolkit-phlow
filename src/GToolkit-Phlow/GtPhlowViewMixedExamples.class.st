"
!Phlow views by example 

!!Explicit view

The most fine grained view is the explicit one through which you can specify the detailed stencil to be used to create the final element.

${example:GtPhlowViewMixedExamples>>#explicitViewWithElementStencil|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$


!!Text view

${example:GtPhlowTextEditorViewExamples>>#textView|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$

!!List view

${example:GtPhlowListViewExamples>>#itemsAsDefaultTexts|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$


!!Columned view

${example:GtPhlowColumnedListViewExamples>>#viewWithItems|previewHeight=150|previewExpanded=|previewShow=#gtLiveFor:}$

"
Class {
	#name : #GtPhlowViewMixedExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples - Views'
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

{ #category : #examples }
GtPhlowViewMixedExamples >> emptyExplicitView [
	<gtExample>
	| view element |
	view := self explicitViewWithElementStencil empty.
	view asElementDo: [ :el | element := el ].
	self assert: element isNotNil.
	^ view
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

{ #category : #'gt-extension' }
GtPhlowViewMixedExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #updating }
GtPhlowViewMixedExamples >> updatingExtension [
	<gtExample>
	^ self
]
