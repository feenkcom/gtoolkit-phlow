Class {
	#name : #GtPhlowViewWithError,
	#superclass : #GtPhlowView,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowViewWithError >> asElementDo: aBlock [
	| anElement |
	anElement := exception asDebuggableElement.
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
GtPhlowViewWithError >> exception [
	^ exception
]

{ #category : #accessing }
GtPhlowViewWithError >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
GtPhlowViewWithError >> runViewCreationComputation [
	| newArguments |
	newArguments := {self buildContext arguments first class empty}
		, self buildContext arguments allButFirst.
	newArguments first
		basicOn: self buildContext object 
		perform: self methodSelector 
		withArguments: newArguments
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
				aButton phlow fireToolUpdateWish ]);
		yourself
]
