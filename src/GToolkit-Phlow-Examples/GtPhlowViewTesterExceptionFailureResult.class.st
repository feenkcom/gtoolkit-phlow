Class {
	#name : #GtPhlowViewTesterExceptionFailureResult,
	#superclass : #GtPhlowViewTesterFailureResult,
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterExceptionFailureResult >> exceptionElements [
	^ self subclassResponsibility
]

{ #category : #'gt - extensions' }
GtPhlowViewTesterExceptionFailureResult >> gtExceptionsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Exceptions';
		priority: 6;
		items: [ self exceptionElements collect: [ :each | each userData at: #exception ] ]
]

{ #category : #'gt - extensions' }
GtPhlowViewTesterExceptionFailureResult >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Failure';
		priority: 5;
		stencil: [
			| aContainer anExplainationText |
			self exceptionElements do: [ :eachExceptionElement |
				eachExceptionElement
					addChild: (BrButton new
						geometry: BlEllipseGeometry new;
						size: 8@8;
						constraintsDo: [ :c |
							c ignoreByLayout.
							c ignored horizontal alignCenter.
							c ignored vertical alignCenter ];
						aptitude: (GtExplainerTargetAptitude new explanationModel: #phlowException)). ].
				
			anExplainationText := 'Phlow view failed because of the ' asRopedText,
				('exceptions' asRopedText glamorousExplanationFor: #phlowException).
		
			aContainer := BrVerticalPane new
				matchParent.
				
			aContainer addChild: (BrEditor new
				aptitude: BrGlamorousRegularEditorAptitude;
				text: anExplainationText;
				margin: (BlInsets all: 10);
				hMatchParent;
				vFitContent).
				
			(self phlowElement gtLiveFor: GtPhlowEmptyView new)
				asElementDo: [ :aPreviewElement | aContainer addChild: aPreviewElement ].
				
			aContainer explainer isExplanationHolder: true.
			aContainer
		]
]
