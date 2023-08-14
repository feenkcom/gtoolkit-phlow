Class {
	#name : #GtPhlowViewTesterExceptionFailure,
	#superclass : #GtPhlowViewTesterFailure,
	#instVars : [
		'exceptionElements'
	],
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterExceptionFailure >> exceptionElements [
	^ exceptionElements
]

{ #category : #accessing }
GtPhlowViewTesterExceptionFailure >> exceptionElements: anObject [
	exceptionElements := anObject
]

{ #category : #accessing }
GtPhlowViewTesterExceptionFailure >> gtLiveFor: aView [
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
