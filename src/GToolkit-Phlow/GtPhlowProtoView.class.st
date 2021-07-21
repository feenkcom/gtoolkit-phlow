"
I define a common API that should be implemented by all Phlow views.


"
Class {
	#name : #GtPhlowProtoView,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#classVars : [
		'IsTaskItViewGloballyEnabled'
	],
	#category : 'GToolkit-Phlow-! Views'
}

{ #category : #setup }
GtPhlowProtoView class >> disableTaskItViews [
	<script>
	IsTaskItViewGloballyEnabled := false.
]

{ #category : #setup }
GtPhlowProtoView class >> enableTaskItViews [
	<script>
	IsTaskItViewGloballyEnabled := true.
]

{ #category : #'class initialization' }
GtPhlowProtoView class >> initialize [
	IsTaskItViewGloballyEnabled := true.
]

{ #category : #'api - converting' }
GtPhlowProtoView >> asElement [
	^ self asElementDo: [ :anElement | anElement ]
]

{ #category : #'api - converting' }
GtPhlowProtoView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"
	self subclassResponsibility
]

{ #category : #'api - converting' }
GtPhlowProtoView >> asTaskItView [
	^ self isTaskItViewGloballyEnabled
		ifTrue: [
			BlUseAsyncFeatures 
				ifEnabledDo: [ GtPhlowTaskItView new originalView: self ]
				otherwise: [ self ] ]
		ifFalse: [ self ]
]

{ #category : #'private - elements' }
GtPhlowProtoView >> assignMeAsEntityFor: anElement [
	anElement phlow entity: self.
]

{ #category : #'private - elements' }
GtPhlowProtoView >> beViewElement: anElement [
	"Set up a given element to play a role of the root element for a phlow view.
	The given element is marked as a view and its phlow entity is set to me.
	In addition we also setup auto updates"

	self subscribeToElement: anElement.
	anElement phlow beView.
	self assignMeAsEntityFor: anElement.
]

{ #category : #accessing }
GtPhlowProtoView >> buildContext [
	<return: #GtPhlowBuildContext>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowProtoView >> buildContext: aGtPhlowBuildContext [
	self subclassResponsibility
]

{ #category : #decorating }
GtPhlowProtoView >> columnedList [
	^ GtPhlowColumnedListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowProtoView >> columnedTree [
	^ GtPhlowColumnedTreeView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowProtoView >> composite [
	^ GtPhlowCompositeView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #copying }
GtPhlowProtoView >> copyAutoUpdatesFrom: aGtPhlowUpdateDefinitions [

]

{ #category : #copying }
GtPhlowProtoView >> copyTransformationFrom: aSendBlock [

]

{ #category : #accessing }
GtPhlowProtoView >> definingMethod [
	"Get view defining method.
	It is a method where a view is defined."
	<return: #RGMethodDefinition>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowProtoView >> definingMethod: aRGMethodDefinition [
	"Set view defining method.
	It is a method where a view is defined."
	^ self subclassResponsibility
]

{ #category : #decorating }
GtPhlowProtoView >> empty [
	^ GtPhlowEmptyView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowProtoView >> explicit [
	^ GtPhlowExplicitView new 
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowProtoView >> forward [
	^ GtPhlowForwarderView new 
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #ui }
GtPhlowProtoView >> gtDefiningMethodFor: aView [
	<gtView>
	self definingMethod ifNil: [ ^ aView empty ].
	^ (self definingMethod gtSourceFor: aView)
			priority: 2
]

{ #category : #ui }
GtPhlowProtoView >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ 
			| aContainer |
			aContainer := BlElement new
				margin: (BlInsets all: 20);
				background: Color white;
				aptitude: BrShadowAptitude;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ].
			self asElementDo: [ :aNewElement | 
				aContainer addChild: aNewElement ].
			aContainer ]
]

{ #category : #testing }
GtPhlowProtoView >> hasBuildContext [
	^ self buildContext isBuildContext
]

{ #category : #'api - converting' }
GtPhlowProtoView >> ifItHasContent: aBlock [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPhlowProtoView >> isTaskItViewGloballyEnabled [
	^ IsTaskItViewGloballyEnabled ifNil: [ true ]
]

{ #category : #decorating }
GtPhlowProtoView >> labelled [
	^ GtPhlowLabelledView new 
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowProtoView >> labelled: aStringOrText [
	^ self labelled 
		label: aStringOrText;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowProtoView >> lazyList [
	^ GtPhlowRemoteListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowProtoView >> list [
	^ GtPhlowListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #convenience }
GtPhlowProtoView >> object: anObject argument: anArgument [
	self buildContext: (GtPhlowBuildContext new
		object: anObject;
		argument: anArgument)
]

{ #category : #convenience }
GtPhlowProtoView >> object: anObject arguments: theExecutionArguments [
	self buildContext: (GtPhlowBuildContext new
		object: anObject;
		arguments: theExecutionArguments)
]

{ #category : #decorating }
GtPhlowProtoView >> pannable [
	^ GtPhlowPannableView new 
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #accessing }
GtPhlowProtoView >> priority [
	"Get view priority defining a view order.
	Lower priority is supposed to be displayed to the left."
	<return: #Number>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowProtoView >> priority: aNumber [
	"Set view priority defining a view order.
	Lower priority is supposed to be displayed to the left."
	^ self subclassResponsibility
]

{ #category : #decorating }
GtPhlowProtoView >> sparta [
	^ GtPhlowSpartaView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #'private - elements' }
GtPhlowProtoView >> subscribeToElement: anElement [
	"subclasses can subscribe to an element events"
]

{ #category : #decorating }
GtPhlowProtoView >> table [
	^ GtPhlowTableView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowProtoView >> text [
	^ GtPhlowTextView new 
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #decorating }
GtPhlowProtoView >> textEditor [
	^ GtPhlowTextEditorView new 
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #accessing }
GtPhlowProtoView >> title [
	"Return view title, a user friendly view name.
	It is supposed to be a short name"
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowProtoView >> title: aString [
	"Set view title, a user friendly view name.
	It is supposed to be a short name"
	^ self subclassResponsibility
]

{ #category : #decorating }
GtPhlowProtoView >> tree [
	^ GtPhlowTreeView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]

{ #category : #updating }
GtPhlowProtoView >> updateContent: anOldElement [
	"anElement is previously computed content from asElementDo:"
	self subclassResponsibility
]
