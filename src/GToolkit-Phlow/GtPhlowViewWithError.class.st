Class {
	#name : #GtPhlowViewWithError,
	#superclass : #GtPhlowView,
	#instVars : [
		'error'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowViewWithError >> asElementDo: aBlock [
	| anElement |
	anElement := error asDebuggableElement.
	anElement id: GtPhlowExceptionId.
	anElement := self wrapWithFailedComputation: anElement.
	self beViewElement: anElement.
	^ aBlock value: anElement
]

{ #category : #testing }
GtPhlowViewWithError >> canRerunViewComputation [
	^ self buildContext notNil and: [
		self definingMethod notNil ]
]

{ #category : #accessing }
GtPhlowViewWithError >> error [
	^ error
]

{ #category : #accessing }
GtPhlowViewWithError >> error: anObject [
	error := anObject
]

{ #category : #accessing }
GtPhlowViewWithError >> runViewCreationComputation [
	GtPhlowView empty 
		basicOn: self buildContext object 
		perform: self methodSelector 
		withArguments: self buildContext arguments
]

{ #category : #accessing }
GtPhlowViewWithError >> wrapWithFailedComputation: anElement [ 

	self canRerunViewComputation ifNil: [ ^ anElement ].
	
	^ BrHorizontalPane new 
		matchParent;
		alignCenter;
		cellSpacing: 10;
		addChild: (anElement
			fitContent);
		addChild: (BrButton new 
			aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
			icon: BrGlamorousIcons play;
			label: 'Re-run';
			beSmallSize;
			action: [ :aButton |
				self runViewCreationComputation .
				"Here we update the entire inspector.
				A better solution would be to take the view returned when retrying to
				run the creation code and replace it with the current view."
				aButton phlow fireUpdateWish ]);
		yourself
]
