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
	| aMethods anAnnouncements |
	aMethods := self definingMethods.
	anAnnouncements := OrderedCollection new.
	aMethods 
		subscribe: GtPhlowDefinitionUpdated
		do: [ :anAnnouncement | anAnnouncements add: anAnnouncement ].
	self fooMethodDefinition.
	self assert: anAnnouncements size equals: 1.
	^ aMethods
]

{ #category : #updating }
GtPhlowViewExamples >> bazMethodDefinition [
	<gtExample>
	| aCompiledMethod |
	aCompiledMethod := self demoClass compile: 'bazFor: aView
	<gtView>
	^ aView explicit 
		title: ''Baz'';
		stencil: [ BlElement new
			background: Color random;
			size: 150@300 ]' classified: 'gt-extension'.
	self assert: aCompiledMethod equals: #bazFor:.
	^ (self demoClass >> #bazFor:) asRingDefinition
]

{ #category : #updating }
GtPhlowViewExamples >> collectionOfDefiningMethods [
	<gtExample>
	^ Array 
		with: self fooMethodDefinition
		with: self bazMethodDefinition
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
	| aMethods |
	aMethods := GtPhlowAnnouncingDefiningMethods new
		methods: self collectionOfDefiningMethods.
	self assert: aMethods methods equals: self collectionOfDefiningMethods.
	^ aMethods
]

{ #category : #updating }
GtPhlowViewExamples >> demoClass [
	<gtExample>
	| aClass |
	aClass := self class environment
		at: self demoClassName
		ifAbsent: [ Object
				subclass: self demoClassName
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'GToolkit-PhlowTempPackage' ].
	self
		assert: (self class environment at: self demoClassName)
		equals: aClass.
	^ aClass
]

{ #category : #updating }
GtPhlowViewExamples >> demoClassName [
	<gtExample>
	^ #GtPhlowDemoClass
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

{ #category : #updating }
GtPhlowViewExamples >> fooMethodDefinition [
	<gtExample>
	| aCompiledMethod |
	aCompiledMethod := self demoClass compile: 'fooFor: aView
	<gtView>
	^ aView explicit 
		title: ''Foo'';
		stencil: [ BlElement new
			background: Color random;
			size: 300@150 ]' classified: 'gt-extension'.
	self assert: aCompiledMethod equals: #fooFor:.
	^ (self demoClass >> #fooFor:) asRingDefinition
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

{ #category : #'reused views' }
GtPhlowViewExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithError [
	<gtExample>
	| aView |
	aView := GtPhlowView empty on: nil perform: #nonExistingMethod:.
	self assert: aView class equals: GtPhlowViewWithError.
	^ aView
]

{ #category : #'secure execution' }
GtPhlowViewExamples >> onPerformWithErrorBlocElement [
	<gtExample>
	| aView anElement |
	aView := self onPerformWithError.
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
