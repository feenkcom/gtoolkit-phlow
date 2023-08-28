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

{ #category : #initialization }
GtPhlowViewsCollectorSameViewError >> createMessageText [
	^ targetObject class name, '>>#', viewSelector asString
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewError >> fullDescription [
	^ 'The Phlow view created by the method ', self createMessageText, ' and run on the object "', targetObject printString, '" returned the same view that was passed as an argument. This is not allowed. Return `aView empty` instead'
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
	<gtView>
	<gtExceptionDebuggingView>
	
	^ aView explicit
		title: 'View Code';
		priority: 0;
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

{ #category : #initialization }
GtPhlowViewsCollectorSameViewError >> initializeWithViewSelector: aMessageSymbol targetObject: anObject [ 
	viewSelector := aMessageSymbol.
	targetObject := anObject.
	
	messageText := self createMessageText
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewError >> parameterReturnString [
	^ '^ aView'
]

{ #category : #accessing }
GtPhlowViewsCollectorSameViewError >> viewMethod [
	^ targetObject class lookupSelector: viewSelector
]
