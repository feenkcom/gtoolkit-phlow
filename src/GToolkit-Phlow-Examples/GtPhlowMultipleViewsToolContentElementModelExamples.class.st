Class {
	#name : #GtPhlowMultipleViewsToolContentElementModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Tool'
}

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
GtPhlowMultipleViewsToolContentElementModelExamples >> toolContentModelProperties [
	<gtExample>
	| toolContentModel |
	
	toolContentModel := self toolContentModel.
	self assert: toolContentModel headerTitle equals: 'Object: a GtMultipleViewsForExamplesObject'.
	self assert: toolContentModel toolIcon notNil.
	self assert: toolContentModel toolName equals: 'Composite view tool'.
	
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
