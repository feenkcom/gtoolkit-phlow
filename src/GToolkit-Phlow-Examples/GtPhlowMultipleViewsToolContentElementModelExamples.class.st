Class {
	#name : #GtPhlowMultipleViewsToolContentElementModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Tool'
}

{ #category : #examples }
GtPhlowMultipleViewsToolContentElementModelExamples >> basicToolContentModel [
	<gtExample>
	| toolContentModel |
	
	toolContentModel := GtPhlowMultipleViewsToolContentElementModel new.
	toolContentModel phlowTool: self tool.
	toolContentModel targetObject: self tool object.
	
	self assert: toolContentModel headerTitle equals: nil.
	self assert: toolContentModel toolIcon notNil.
	self assert: toolContentModel toolName equals: 'Composite view tool'.
	
	^ toolContentModel
]

{ #category : #examples }
GtPhlowMultipleViewsToolContentElementModelExamples >> checkToolContentModelProperties [
	<gtExample>
	| toolContentModel |
	
	toolContentModel := self toolContentModel.
	self assert: toolContentModel headerTitle equals: 'Object: a GtMultipleViewsForExamplesObject'.
	self assert: toolContentModel toolIcon notNil.
	self assert: toolContentModel toolName equals: 'Composite view tool'.
	
	^ toolContentModel
]

{ #category : #examples }
GtPhlowMultipleViewsToolContentElementModelExamples >> collectToolViews [
	<gtExample>
	| views titles |
	
	views := self toolContentModel collectContentViews views.
	titles := views collect: [ :each | each title asString ].
	
	self assert: views size equals: 2.
	self assert: titles asArray equals: #('Summary' 'Log').
	
	^ views
]

{ #category : #examples }
GtPhlowMultipleViewsToolContentElementModelExamples >> collectsToolActions [
	<gtExample>
	| actions incrementAction extraAction refreshAction |
	
	actions := self toolContentModel collectToolActions.
	self assert: actions size equals: 3.
	
	incrementAction := actions first.
	self assert: incrementAction label asString equals: 'Increment'.
	self assert: incrementAction id equals: #incrementActionWithCurrentToolUpdate.
	self assert: incrementAction priority equals: 10.

	refreshAction := actions second.
	self assert: refreshAction label asString equals: 'Refresh'.
	self assert: refreshAction id equals: #refreshContentAction.
	self assert: refreshAction priority equals: 20.
	
	extraAction := actions third.
	self assert: extraAction label equals: nil.
	self assert: extraAction id equals: #extraObjectActions.
	self assert: extraAction priority equals: 100.
	
	
	^ actions
]

{ #category : #'examples - setup' }
GtPhlowMultipleViewsToolContentElementModelExamples >> exampleObject [
	<gtExample>
	| anObject |
	anObject := GtMultipleViewsForExamplesObject new.
	self assert: anObject counter equals: 0.
	self assert: anObject log isEmpty.
	^ anObject
]

{ #category : #'examples - setup' }
GtPhlowMultipleViewsToolContentElementModelExamples >> tool [
	<gtExample>
	| aTool |
	
	aTool := GtMultipleViewsForExamplesPhlowTool new
		object: self exampleObject.
		
	self assert: aTool object notNil.
	self assert: aTool name equals: 'Composite view tool'.
	
	^ aTool
]

{ #category : #'examples - setup' }
GtPhlowMultipleViewsToolContentElementModelExamples >> toolContentModel [
	<gtExample>
	| toolContentModel |
	
	toolContentModel := GtPhlowMultipleViewsToolContentElementModel new.
	toolContentModel phlowTool: self tool.
	toolContentModel targetObject: self tool object.
	toolContentModel headerTitleComputation: [
		'Object: ', self tool object printString  ].
	
	^ toolContentModel
]

{ #category : #examples }
GtPhlowMultipleViewsToolContentElementModelExamples >> toolModelAcceptsConfiguredPragmaNames [
	<gtExample>
	| aModel |
	aModel := GtPhlowMultipleViewsToolContentElementModel new
		contentViewPragmaNames: #(gtView gtToolView);
		toolActionPragmaNames: #(gtAction gtToolAction);
		yourself.
	self assert: aModel contentViewPragmaNames equals: #(#gtView #gtToolView).
	self assert: aModel toolActionPragmaNames equals: #(#gtAction #gtToolAction).
	^ aModel
]

{ #category : #examples }
GtPhlowMultipleViewsToolContentElementModelExamples >> toolModelUsesDefaultPragmaNames [
	<gtExample>
	| aModel |
	aModel := GtPhlowMultipleViewsToolContentElementModel new.
	self assert: aModel contentViewPragmaNames equals: #(#gtToolView).
	self assert: aModel toolActionPragmaNames equals: #(#gtToolAction).
	^ aModel
]
