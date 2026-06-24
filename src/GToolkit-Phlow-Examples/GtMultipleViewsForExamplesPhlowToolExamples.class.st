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
	
	aScripter multipleViewsToolStep
		label: 'Check phlow tool object';
		assertToolObjectOfType: GtMultipleViewsForExamplesObject;
		assertToolObjectValueFor: [ :anObject | anObject counter ] equals: [ 0 ];
		assertToolObjectSatisfies: [ :anObject |
			anObject log isEmpty ] description:  'Log is empty';
		play.
		
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
GtMultipleViewsForExamplesPhlowToolExamples >> pageToolWithSnippetWithExampleObjectCreation [
	<gtExample>
	| page pageTool snippet |
	
	page := LePage new
		addSnippet: ((snippet := LePharoSnippet code: 'GtMultipleViewsForExamplesObject new'));
		yourself.
	
	pageTool := LePagePhlowTool new
		page: page.
				
	^ pageTool
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

{ #category : #'examples - standalone tool' }
GtMultipleViewsForExamplesPhlowToolExamples >> standaloneToolElementExecuteIncrementAction [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter multipleViewsToolStep
		label: 'Click increment action';
		clickOnActionWithId: #incrementActionWithCurrentToolUpdate;
		play.
		
	self assert: scripter model object counter equals: 1.
	self assert: scripter model object log asArray equals: #('incremented to 1').
	
	scripter multipleViewsToolStep
		label: 'Click increment action a second time';
		clickOnActionWithId: #incrementActionWithCurrentToolUpdate;
		play.
		
	self assert: scripter model object counter equals: 2.
	self assert: scripter model object log asArray equals: #('incremented to 1' 'incremented to 2').
	
	^ scripter
]

{ #category : #'examples - standalone tool' }
GtMultipleViewsForExamplesPhlowToolExamples >> standaloneToolElementHasPlayground [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter multipleViewsToolStep
		label: 'Check playground element is present';
		assertPlaygroundElementIsPresent;
		play.
			
	^ scripter
]

{ #category : #'examples - standalone tool' }
GtMultipleViewsForExamplesPhlowToolExamples >> standaloneToolElementHasTitleLabel [
	<gtExample>
	| scripter expectedText|
	
	expectedText := 'Object: a GtMultipleViewsForExamplesObject'.
	scripter := self createToolElementInScripter.
	
	self assert: scripter element titleLabel text asString equals: expectedText.
	
	scripter multipleViewsToolStep
		label: 'Check tool title label';
		assertToolTitle: expectedText;
		play.
			
	^ scripter
]

{ #category : #'examples - standalone tool' }
GtMultipleViewsForExamplesPhlowToolExamples >> standaloneToolElementHasToolLabel [
	<gtExample>
	| expectedText scripter |
	expectedText := 'Composite view tool'.
	
	scripter := scripter := self createToolElementInScripter.
	self assert: scripter element toolLabel text asString equals: expectedText.
	
	scripter multipleViewsToolStep
		label: 'Check tool label';
		assertToolLabel: expectedText;
		play.
			
	^ scripter
]

{ #category : #'examples - standalone tool' }
GtMultipleViewsForExamplesPhlowToolExamples >> standaloneToolElementShowsActions [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter multipleViewsToolStep
		label: 'Check tool actions';
		assertHasExactToolActionsWithIds: {
			BlElementNamedId named: #incrementActionWithCurrentToolUpdate.
			BlElementNamedId named: #refreshContentAction.
			BlElementNamedId named:  #extraObjectActions};
		assertHasExactToolActionModelsWithLabels: #('Increment' 'Refresh' 'Label' );
		assertToolHasActionWithIconAndLabel: 'Increment';
		assertToolHasActionWithIconAndLabel: 'Refresh';
		play.
			
	^ scripter
]

{ #category : #'examples - standalone tool' }
GtMultipleViewsForExamplesPhlowToolExamples >> standaloneToolElementShowsTabs [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter multipleViewsToolStep
		label: 'Check tool element tabs';
		assertHasExactTabNames: #('Summary' 'Log');
		assertSelectedTabWithName: 'Summary';
		play.
		
	^ scripter
]

{ #category : #'examples - tool in world' }
GtMultipleViewsForExamplesPhlowToolExamples >> worldTabWithInitialSnippetWithExampleObject [
	<gtExample>
	<return: #BlScripter>
	| scripter pageTool |
	
	pageTool := self pageToolWithSnippetWithExampleObjectCreation.

	scripter := BlScripter new.
	scripter element: GtWorldElement new.
	scripter model: pageTool.

	scripter worldStep
		label: 'Open page in new tab';
		showInNewTabObject: pageTool;
		assertTabAtIndex: 2 hasLabel:  'Page';
		play.

	^ scripter
]

{ #category : #'examples - tool in world' }
GtMultipleViewsForExamplesPhlowToolExamples >> worldTabWithPaneWithTool [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithInitialSnippetWithExampleObject.

	scripter click
		label: 'Click on do it and inspect button';
		// GtSourceCoderDoItAndGoActionId;
		play.
		
	scripter multipleViewsToolStep
		label: 'Check phlow tool object';
		onPagerPaneWithIndex: 2;
		onMultipleViewsToolElement;
		assertToolObjectOfType: GtMultipleViewsForExamplesObject;
		assertToolObjectValueFor: [ :anObject | anObject counter ] equals: [ 0 ];
		assertToolObjectSatisfies: [ :anObject |
			anObject log isEmpty ] description:  'Log is empty';
		play.
		
	scripter worldStep
		label: 'World tab title is still Page after spawning a new pane';
		assertTabAtIndex: 2 hasLabel: 'Page';
		play.
	
	scripter phlowCompositeToolStep
		label: 'Second pane has the expected tool';
		onPagerToolInPaneWithIndex: 2;
		assertPhlowToolTabsCount: 2;
		assertPhlowToolLabels: {'Composite view tool' . 'inspector'}  
			andTypes: {GtMultipleViewsForExamplesPhlowTool . GtInspectorTool};
		assertSelectedToolAtIndex: 1 withTabName: 'Composite view tool';
		play.

	^ scripter
]

{ #category : #'examples - tool in world' }
GtMultipleViewsForExamplesPhlowToolExamples >> worldTabWithPaneWithTool_executeIncrementUpdatesCurrentView [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool.

	scripter assert
		label: 'Check that initially no label with text 1 is present';
		onPagerPaneWithIndex: 2;
		notExists;
		// BrColumnedList;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '1' ];
		play.
		
	scripter multipleViewsToolStep
		label: 'Click increment action';
		onPagerPaneWithIndex: 2;
		onMultipleViewsToolElement;
		clickOnActionWithId: #incrementActionWithCurrentToolUpdate;
		assertToolObjectValueFor: [ :anObject | anObject counter ] equals: [ 1 ];
		play.
		
	scripter assert
		label: 'Check that a label with text 1 is present';
		onPagerPaneWithIndex: 2;
		exists;
		// BrColumnedList;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '1' ];
		play.

	^ scripter
]

{ #category : #'examples - tool in world' }
GtMultipleViewsForExamplesPhlowToolExamples >> worldTabWithPaneWithTool_logViewUpdatesAfterReselection [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool.
		
	scripter multipleViewsToolStep
		label: 'Select the log view';
		clickOnTabWithName: 'Log';
		play.
		
	scripter assert
		label: 'Check that the log view does not have the correct log';
		onPagerPaneWithIndex: 2;
		notExists;
		// BrSimpleList;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = 'incremented to 1' ];
		play.
		
	scripter multipleViewsToolStep
		label: 'Switch to the summary view and click to increment data';
		onPagerPaneWithIndex: 2;
		onMultipleViewsToolElement;
		clickOnTabWithName: 'Summary';
		clickOnActionWithId: #incrementActionWithCurrentToolUpdate;
		assertToolObjectValueFor: [ :anObject | anObject counter ] equals: [ 1 ];
		play.
		
	scripter multipleViewsToolStep
		label: 'Switch back the log view';
		clickOnTabWithName: 'Log';
		play.
		
	scripter assert
		label: 'Check that the log view has the updated log';
		onPagerPaneWithIndex: 2;
		exists;
		// BrSimpleList;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = 'incremented to 1' ];
		play.

	^ scripter
]

{ #category : #'examples - tool in world' }
GtMultipleViewsForExamplesPhlowToolExamples >> worldTabWithPaneWithTool_logViewUpdatesWhenInitiallyShown [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool_executeIncrementUpdatesCurrentView.
		
	scripter multipleViewsToolStep
		label: 'Select the log view';
		clickOnTabWithName: 'Log';
		play.
		
	scripter assert
		label: 'Check that the log view has the correct log';
		onPagerPaneWithIndex: 2;
		exists;
		// BrSimpleList;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = 'incremented to 1' ];
		play.

	^ scripter
]

{ #category : #'examples - tool in world' }
GtMultipleViewsForExamplesPhlowToolExamples >> worldTabWithPaneWithTool_selectInspectorRawView [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool.

	scripter phlowCompositeToolStep
		label: 'Select inspector tool';
		onPagerToolInPaneWithIndex: 2;
		clickOnToolAtIndex: 2;
		assertSelectedToolAtIndex: 2 withPhlowName: 'inspector';
		play.

	scripter inspectorStep
		label: 'Select the Raw view in the inspector tool';
		onPagerPaneWithIndex: 2;
		clickOnTabWithName: 'Raw';
		assertSelectedTabWithName: 'Raw';
		play.

	scripter click
		label: 'Select an element in the inspector raw view';
		onPagerPaneWithIndex: 2;
		// BrColumnedTree;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = 'self' ];
		play.

	scripter worldStep
		label: 'World tab title changed after selecting a row in the raw view';
		assertTabAtIndex: 2 hasLabel: 'a GtMultipleViewsForExamplesObject';
		play.

	^ scripter
]

{ #category : #'examples - tool in world' }
GtMultipleViewsForExamplesPhlowToolExamples >> worldTabWithPaneWithTool_selectInspectorRawView_backToPage [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool_selectInspectorRawView.

	scripter click
		label: 'Click editor in first pane';
		onPagerPaneWithIndex: 1;
		// GtSourceCoderEditorInnerId;
		play.

	scripter worldStep
		label: 'World tab title is Page again';
		assertTabAtIndex: 2 hasLabel: 'Page';
		play.

	^ scripter
]

{ #category : #'examples - tool in world' }
GtMultipleViewsForExamplesPhlowToolExamples >> worldTabWithPaneWithTool_selectSelfInToolSummaryView [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool.

	scripter multipleViewsToolStep
		label: 'Select the Summary view in the second pane';
		onPagerPaneWithIndex: 2;
		clickOnTabWithName: 'Summary';
		assertSelectedTabWithName: 'Summary';
		play.

	scripter click
		label: 'Select Counter in the Summary view';
		onPagerPaneWithIndex: 2;
		// BrColumnedList;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = 'Counter' ];
		play.

	scripter worldStep
		label: 'World tab title changed after selecting self';
		assertTabAtIndex: 2 hasLabel: 'Object: a Gt...xamplesObject';
		play.

	^ scripter
]

{ #category : #'examples - tool in world' }
GtMultipleViewsForExamplesPhlowToolExamples >> worldTabWithPaneWithTool_selectSelfInToolSummaryView_backToPage [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool_selectSelfInToolSummaryView.

	scripter click
		label: 'Click editor in first pane';
		onPagerPaneWithIndex: 1;
		// GtSourceCoderEditorInnerId;
		play.

	scripter worldStep
		label: 'World tab title is Page again';
		assertTabAtIndex: 2 hasLabel: 'Page';
		play.

	^ scripter
]
