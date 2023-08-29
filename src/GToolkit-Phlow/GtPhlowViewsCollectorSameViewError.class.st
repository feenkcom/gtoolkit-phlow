"
Indicates that a phlow view definition  returned the same view that was passed as an argument. This is not allowed. You should use  `aView empty` instead.


An example of a wrong view signaling this error is: {{gtMethod:GtPhlowViewWithErrorExamples>>gtViewWithReturningSameViewFor:|expanded}}
"
Class {
	#name : #GtPhlowViewsCollectorSameViewError,
	#superclass : #GtPhlowViewsCollectorError,
	#instVars : [
		'viewSelector',
		'targetObject'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #'instance creation' }
GtPhlowViewsCollectorSameViewError class >> signalForViewSelector: aMessageSymbol fromObject: anObject [ 
	^ (self new 
		initializeWithViewSelector: aMessageSymbol
		targetObject: anObject)
			signal
]

{ #category : #'gt - extensions' }
GtPhlowViewsCollectorSameViewError >> createAnnotatedCoderElement [
	| coder returnsStyler coderViewModel coderElement |
	coder := ((GtPharoMethodCoder forMethod: self viewMethod asRingDefinition) 
		highlighter: (GtRBPatternHighlighter new
		 			 ast: (RBParser 
		 			 	parseRewriteExpression: self parameterReturnString);
					  yourself)
				yourself).
	returnsStyler := GtDirectParameterExplanationLinkStyler new
		parameterName: self parameterName withIdentifier: #viewParameter.
	
	coderViewModel := coder asCoderViewModel.
	coderViewModel addStylers: { returnsStyler }.
	coderViewModel expanded: true.

	coderElement := coderViewModel asExpandedOnlyElement vFitContentLimited.
	coderElement margin: (BlInsets all: 10).

	^ coderElement
]

{ #category : #'gt - extensions' }
GtPhlowViewsCollectorSameViewError >> createExplanationText [
	^ 'The Phlow view created by the method ' asRopedText
			,(self viewMethod printString asRopedText italic)
			,' returned directly the' asRopedText
			, (self parameterName asRopedText glamorousExplanationFor: #viewParameter)
			, ' argument. This is not allowed. Return  'asRopedText 
			, (self parameterName, ' empty') asRopedText italic,
			' instead.' asRopedText
]

{ #category : #'gt - extensions' }
GtPhlowViewsCollectorSameViewError >> createExplanationWithCoderElement [
	| container |
	container := BrVerticalPane new
		matchParent.
				
	container addChild: (BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude;
		text: self createExplanationText;
		margin: (BlInsets all: 10);
		hMatchParent;
		vFitContent).
				
	container addChild: self createAnnotatedCoderElement.
				
	container explainer isExplanationHolder: true.
	^ container
]

{ #category : #initialization }
GtPhlowViewsCollectorSameViewError >> createMessageText [
	^ targetObject class name, '>>#', viewSelector asString
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewError >> fullDescription [
	^ 'The Phlow view created by the method ', self createMessageText, ' and run on the object "', targetObject printString, '" returned the same view that was passed as an argument. This is not allowed. Return `aView empty` instead'
]

{ #category : #'gt - extensions' }
GtPhlowViewsCollectorSameViewError >> gtDebuggingExtensionConfiguration [
	^ super gtDebuggingExtensionConfiguration
		globalDebuggingActionPragmas: #(gtPhlowSaveViewReturnFixDebugAction)
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewError >> gtViewDescriptionFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Description';
		priority: 5;
		text: [ self fullDescription ]
]

{ #category : #'gt - extensions' }
GtPhlowViewsCollectorSameViewError >> gtViewViewCodeFor: aView [
	"<gtView>
	<gtExceptionDebuggingView>"
	
	^ aView explicit
		title: 'View Code';
		priority: 0;
		actionDropdownButtonIcon: BrGlamorousVectorIcons driller 
			tooltip: 'Refactor view return' 
			content: [ self refactoringContentElement];
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ self gtBrowse ];
		stencil: [ 
			((GtPharoMethodCoder forMethod: self viewMethod asRingDefinition) 
				highlighter: (GtRBPatternHighlighter new
		 			 ast: (RBParser 
		 			 	parseRewriteExpression: self parameterReturnString);
					  yourself)
				yourself)
				asExpandedOnlyElement vFitContentLimited ]
]

{ #category : #'gt - extensions' }
GtPhlowViewsCollectorSameViewError >> gtViewViewCodeWithExplanationFor: aView [
	<gtView>
	<gtExceptionDebuggingView>
	
	^ aView explicit
		title: 'View Code';
		priority: 0;
		actionDropdownButtonIcon: BrGlamorousVectorIcons driller 
			tooltip: 'Refactor view return' 
			content: [ self refactoringContentElement];
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ self gtBrowse ];
		stencil: [ 
			self createExplanationWithCoderElement ]
]

{ #category : #initialization }
GtPhlowViewsCollectorSameViewError >> initializeWithViewSelector: aMessageSymbol targetObject: anObject [ 
	viewSelector := aMessageSymbol.
	targetObject := anObject.
	
	messageText := self createMessageText
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewError >> parameterName [
	^ self viewMethod argumentNames first
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewError >> parameterReturnString [
	^ '^ ', self parameterName
]

{ #category : #'gt - extensions' }
GtPhlowViewsCollectorSameViewError >> refactoringContentElement [
	| container|
	
	container := BrFrame new
		hExact: 650;
		vExact: 300.
	container addChild: ((self refactoringModel
		gtApplyingChangesFor:  GtPhlowView empty) 
			asElementDo: [:e | e]).
	
	^ container
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewError >> refactoringModel [
	| model rewriter targetMethod |
	
	model := RBNamespace new.
	rewriter := RBParseTreeRewriter new.
	rewriter 
		replace: self parameterReturnString 
		with: self parameterReturnString, ' empty'.
	targetMethod := self viewMethod.

	(rewriter executeTree: targetMethod ast copy)
		ifTrue: [ 
			(model classFor: targetMethod methodClass) compileTree: rewriter tree ] .

	^ model
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewError >> viewMethod [
	^ targetObject class lookupSelector: viewSelector
]
