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
	
	views := self currentToolContentModel collectContentViews views.
	titles := views collect: [ :each | each title asString ].
	
	self assert: views size equals: 2.
	self assert: titles asArray equals: #('Summary' 'Log').
	
	^ views
]

{ #category : #examples }
GtMultipleViewsForExamplesPhlowToolExamples >> collectsToolActions [
	<gtExample>
	| actions incrementAction extraAction refreshAction |
	
	actions := self currentToolContentModel collectToolActions.
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

{ #category : #'examples - instance creation' }
GtMultipleViewsForExamplesPhlowToolExamples >> createToolElementInScripter [
	<gtExample>
	| phlowTool anElement aScripter |
	
	phlowTool := self phlowTool.
	anElement := phlowTool asElement.
	
	aScripter := BlScripter new.
	aScripter
		model: phlowTool;
		element: anElement.
	
	self assert: anElement class equals: GtPhlowMultipleViewsContentElement.
			
	^ aScripter
]

{ #category : #'examples - instance creation' }
GtMultipleViewsForExamplesPhlowToolExamples >> currentToolContentModel [
	<gtExample>
	| aScripter toolContentModel |
	
	aScripter := self createToolElementInScripter.
	toolContentModel := aScripter element toolContentModel.
	
	self assert: toolContentModel headerTitle equals: 'Object: a GtMultipleViewsForExamplesObject'.
	self assert: toolContentModel toolIcon notNil.
	self assert: toolContentModel toolName equals: 'Composite view tool'.
	
	^ toolContentModel
]

{ #category : #'examples - instance creation' }
GtMultipleViewsForExamplesPhlowToolExamples >> exampleObject [
	<gtExample>
	| anObject |
	anObject := GtMultipleViewsForExamplesObject new.
	self assert: anObject counter equals: 0.
	self assert: anObject log isEmpty.
	^ anObject
]

{ #category : #'examples - instance creation' }
GtMultipleViewsForExamplesPhlowToolExamples >> phlowTool [
	<gtExample>
	| aTool |
	
	aTool := GtMultipleViewsForExamplesPhlowTool new
		object: self exampleObject.
		
	self assert: aTool object notNil.
	self assert: aTool name equals: 'Composite view tool'.
	self assert: aTool icon notNil.
	
	^ aTool
]

{ #category : #'examples - scripter' }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementExecuteIncrementAction [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter click
		label: 'Click increment action';
		// #headerToolbar;
		// #incrementActionWithCurrentToolUpdate;
		play.
		
	self assert: scripter model object counter equals: 1.
	self assert: scripter model object log asArray equals: #('incremented to 1').
	
	scripter click
		label: 'Click increment action a second time';
		// #headerToolbar;
		// #incrementActionWithCurrentToolUpdate;
		play.
		
	self assert: scripter model object counter equals: 2.
	self assert: scripter model object log asArray equals: #('incremented to 1' 'incremented to 2').
	
	^ scripter
]

{ #category : #'examples - scripter' }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementHasPlayground [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter assertStep: [ :aStep |
		aStep
			label: 'Tool playground exists';
			exists;
			// #playgroundPage ].
			
	^ scripter
]

{ #category : #'examples - scripter' }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementHasTitleLabel [
	<gtExample>
	| scripter expectedText|
	
	expectedText := 'Object: a GtMultipleViewsForExamplesObject'.
	scripter := self createToolElementInScripter.
	
	self assert: scripter element titleLabel text asString equals: expectedText.
	
	scripter assertStep: [ :aStep |
		aStep
			label: 'Tool title label updated';
			satisfies: [ :aLabel | aLabel text asString = expectedText ];
			// #titleContainer;
			// #titleLabel ].
			
	^ scripter
]

{ #category : #'examples - scripter' }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementHasToolLabel [
	<gtExample>
	| expectedText scripter |
	
	expectedText := 'Composite view tool'.
	scripter := scripter := self createToolElementInScripter.
	
	self assert: scripter element toolLabel text asString equals: expectedText.
	
	scripter assertStep: [ :aStep |
		aStep
			label: 'Tool name label is correct';
			value: [ :aLabel | aLabel text asString ] equals: [ expectedText ];
			// #header;
			// #toolLabel ].
]

{ #category : #'examples - scripter' }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementShowsActions [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter assertStep: [ :aStep |
		aStep
			label: 'Tool toolbar has correct number of actions';
			value: [ :aToolbar | aToolbar numberOfItems ] equals: [ 3 ];
			// #headerToolbar ].
	
	scripter assertStep: [ :aStep |
		aStep
			label: 'Tool shows Increment action';
			value: [ :aToolbar | aToolbar items collect: [:each | each label asString ] as: Array ] 
				equals: #('Increment' 'Refresh' 'Label' );
			// #headerToolbar ].
			
	^ scripter
]

{ #category : #'examples - scripter' }
GtMultipleViewsForExamplesPhlowToolExamples >> toolElementShowsTabs [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter assertStep: [ :aStep |
		aStep
			label: 'Tool element has correct number of tabs';
			value: [ :aTabGroup | aTabGroup tabs size ] equals: [ 2 ];
			// GtPhlowCompositeViewElementId ].
	
	scripter assertStep: [ :aStep |
		aStep
			label: 'Tool element tab group has Summary and Log tabs';
			value: [ :aTabGroup | (aTabGroup tabs collect: [ :each | 
				each tabLabel text asString ]) asArray ]
			equals: [  #('Summary' 'Log' ) ];
			// GtPhlowCompositeViewElementId ].
	
	^ scripter
]
