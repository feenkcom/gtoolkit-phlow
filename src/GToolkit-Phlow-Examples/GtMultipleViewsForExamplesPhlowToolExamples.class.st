"
I contain executable examples for {{gtClass:GtMultipleViewsForExamplesPhlowTool}} and related multiple-views infrastructure.
"
Class {
	#name : #GtMultipleViewsForExamplesPhlowToolExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Tool'
}

{ #category : #examples }
GtMultipleViewsForExamplesPhlowToolExamples >> collectToolViews [
	<gtExample>
	| views titles |
	
	views := self toolContentModel collectContentViews views.
	titles := views collect: [ :each | each title asString ].
	
	self assert: views size equals: 2.
	self assert: titles asArray equals: #('Summary' 'Log').
	
	^ views
]

{ #category : #examples }
GtMultipleViewsForExamplesPhlowToolExamples >> collectsToolActions [
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

{ #category : #'instance creation' }
GtMultipleViewsForExamplesPhlowToolExamples >> exampleObject [
	<gtExample>
	| anObject |
	anObject := GtMultipleViewsForExamplesObject new.
	self assert: anObject counter equals: 0.
	self assert: anObject log isEmpty.
	^ anObject
]

{ #category : #'instance creation' }
GtMultipleViewsForExamplesPhlowToolExamples >> tool [
	<gtExample>
	| aTool |
	
	aTool := GtMultipleViewsForExamplesPhlowTool new
		object: self exampleObject.
		
	self assert: aTool object notNil.
	self assert: aTool name equals: 'Composite view tool'.
	
	^ aTool
]

{ #category : #'instance creation' }
GtMultipleViewsForExamplesPhlowToolExamples >> toolContentModel [
	<gtExample>
	| aModel |
	
	aModel := GtPhlowMultipleViewsToolContentElementModel new.
	aModel phlowTool: self tool.
	aModel targetObject: self tool object.
	
	^ aModel
]

{ #category : #'instance creation' }
GtMultipleViewsForExamplesPhlowToolExamples >> toolContentModelProperties [
	<gtExample>
	| toolContentModel |
	
	toolContentModel := self toolContentModel.
	self assert: toolContentModel headerTitle equals: 'Object: a GtMultipleViewsForExamplesObject'.
	self assert: toolContentModel toolIcon notNil.
	self assert: toolContentModel toolName equals: 'Composite view tool'.
	
	^ toolContentModel
]

{ #category : #scripter }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementExecuteIncrementAction [
	<gtExample>
	| aScripter |
	
	aScripter := self toolElementInScripter.
	
	aScripter click
		label: 'Click increment action';
		// #headerToolbar;
		// #incrementActionWithCurrentToolUpdate;
		play.
		
	self assert: aScripter model object counter equals: 1.
	self assert: aScripter model object log asArray equals: #('incremented to 1').
	
	aScripter click
		label: 'Click increment action a second time';
		// #headerToolbar;
		// #incrementActionWithCurrentToolUpdate;
		play.
		
	self assert: aScripter model object counter equals: 2.
	self assert: aScripter model object log asArray equals: #('incremented to 1' 'incremented to 2').
	
	^ aScripter
]

{ #category : #scripter }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementHasPlayground [
	<gtExample>
	| aScripter |
	
	aScripter := self toolElementInScripter.
	
	aScripter assertStep: [ :aStep |
		aStep
			label: 'Tool playground exists';
			exists;
			// #playgroundPage ].
			
	^ aScripter
]

{ #category : #scripter }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementHasTitleLabel [
	<gtExample>
	| aScripter expectedText|
	
	expectedText := 'Object: a GtMultipleViewsForExamplesObject'.
	aScripter := self toolElementInScripter.
	
	self assert: aScripter element titleLabel text asString equals: expectedText.
	
	aScripter assertStep: [ :aStep |
		aStep
			label: 'Tool title label updated';
			satisfies: [ :aLabel | aLabel text asString = expectedText ];
			// #titleContainer;
			// #titleLabel ].
			
	^ aScripter
]

{ #category : #scripter }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementHasToolLabel [
	<gtExample>
	| expectedText aScripter |
	
	expectedText := 'Composite view tool'.
	aScripter := aScripter := self toolElementInScripter.
	
	self assert: aScripter element toolLabel text asString equals: expectedText.
	
	aScripter assertStep: [ :aStep |
		aStep
			label: 'Tool name label is correct';
			value: [ :aLabel | aLabel text asString ] equals: [ expectedText ];
			// #header;
			// #toolLabel ].
]

{ #category : #scripter }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementInScripter [
	<gtExample>
	| aTool anElement aScripter |
	
	aTool := GtMultipleViewsForExamplesPhlowTool new
		object: self exampleObject.
	anElement := aTool asElement.
	
	aScripter := BlScripter new.
	aScripter
		model: aTool;
		element: anElement.
	
	self assert: anElement class equals: GtPhlowMultipleViewsContentElement.
			
	^ aScripter
]

{ #category : #examples }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementShowsActions [
	<gtExample>
	| aScripter |
	
	aScripter := self toolElementInScripter.
	
	aScripter assertStep: [ :aStep |
		aStep
			label: 'Tool toolbar has correct number of actions';
			value: [ :aToolbar | aToolbar numberOfItems ] equals: [ 3 ];
			// #headerToolbar ].
	
	aScripter assertStep: [ :aStep |
		aStep
			label: 'Tool shows Increment action';
			value: [ :aToolbar | aToolbar items collect: [:each | each label asString ] as: Array ] 
				equals: #('Increment' 'Refresh' 'Label' );
			// #headerToolbar ].
			
	^ aScripter
]

{ #category : #examples }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementShowsTabs [
	<gtExample>
	| aScripter |
	
	aScripter := self toolElementInScripter.
	
	aScripter assertStep: [ :aStep |
		aStep
			label: 'Tool element has correct number of tabs';
			value: [ :aTabGroup | aTabGroup tabs size ] equals: [ 2 ];
			// GtPhlowCompositeViewElementId ].
	
	aScripter assertStep: [ :aStep |
		aStep
			label: 'Tool element tab group has Summary and Log tabs';
			value: [ :aTabGroup | (aTabGroup tabs collect: [ :each | 
				each tabLabel text asString ]) asArray ]
			equals: [  #('Summary' 'Log' ) ];
			// GtPhlowCompositeViewElementId ].
	
	^ aScripter
]
