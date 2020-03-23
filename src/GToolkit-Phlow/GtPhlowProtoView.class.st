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
	#category : #'GToolkit-Phlow-Views and Actions'
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

{ #category : #converting }
GtPhlowProtoView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"
	self subclassResponsibility
]

{ #category : #converting }
GtPhlowProtoView >> asTaskItView [
	^ self isTaskItViewGloballyEnabled
		ifTrue: [
			BlUseAsyncFeatures 
				ifEnabledDo: [ GtPhlowTaskItView new originalView: self ]
				otherwise: [ self ] ]
		ifFalse: [ self ]
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
		definingMethod: thisContext stack second method asRingDefinition
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
				look: BrShadowLook;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ].
			self asElementDo: [ :aNewElement | 
				aContainer addChild: aNewElement ].
			aContainer ]
]

{ #category : #converting }
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
GtPhlowProtoView >> list [
	^ GtPhlowListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
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

{ #category : #decorating }
GtPhlowProtoView >> table [
	^ GtPhlowTableView new
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
