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
	#category : #'GToolkit-Phlow-! Views'
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

{ #category : #typing }
GtPhlowProtoView class >> gtViewArgumentType: aNode [
	<gtVariableType>
	^ ((aNode pragmasNamed: #gtView) notEmpty
		and: [ aNode = aNode topParent variables first ])
		ifTrue: [ ^ GtPhlowProtoView ]
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

	self assignMeAsEntityFor: anElement.
	self subscribeToElement: anElement.
	anElement phlow beViewContent.
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
GtPhlowProtoView >> canvassable [
	<return: #GtPhlowCanvassableView>
	^ GtPhlowCanvassableView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> columnedList [
	<return: #GtPhlowColumnedListView>
	^ GtPhlowColumnedListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> columnedTree [
	<return: #GtPhlowColumnedTreeView>
	^ GtPhlowColumnedTreeView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> composite [
	<return: #GtPhlowCompositeView>
	^ GtPhlowCompositeView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
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

{ #category : #accessing }
GtPhlowProtoView >> definingMethodProvider [
	"Get a provider that knows how to return the method defining the view"
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowProtoView >> definingSelector [
	^ self definingMethod selector
]

{ #category : #decorating }
GtPhlowProtoView >> diff [
	<return: #GtPhlowDiffView>
	^ GtPhlowDiffView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> empty [
	<return: #GtPhlowEmptyView>
	^ GtPhlowEmptyView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> explicit [
	<return: #GtPhlowExplicitView>
	^ GtPhlowExplicitView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> forward [
	<return: #GtPhlowForwarderView>
	^ GtPhlowForwarderView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> groupedList [
	<return: #GtPhlowGroupedListView>
	^ GtPhlowGroupedListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
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
	<return: #GtPhlowLabelledView>
	^ GtPhlowLabelledView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> labelled: aStringOrText [
	^ self labelled
		label: aStringOrText;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> list [
	<return: #GtPhlowListView>
	^ GtPhlowListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
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
	<return: #GtPhlowPannableView>
	^ GtPhlowPannableView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
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
	<return: #GtPhlowSpartaView>
	^ GtPhlowSpartaView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #'private - elements' }
GtPhlowProtoView >> subscribeToElement: anElement [
	"subclasses can subscribe to an element events"
]

{ #category : #decorating }
GtPhlowProtoView >> table [
	<return: #GtPhlowTableView>
	^ GtPhlowTableView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> text [
	<return: #GtPhlowTextView>
	^ GtPhlowTextView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowProtoView >> textEditor [
	<return: #GtPhlowTextEditorView>
	^ GtPhlowTextEditorView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
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
	<return: #GtPhlowTreeView>
	^ GtPhlowTreeView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #updating }
GtPhlowProtoView >> updateContent: anOldElement [
	"anElement is previously computed content from asElementDo:"
	self subclassResponsibility
]
