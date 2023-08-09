"
I exemplify {{gtClass:GtPhlowActionTarget}} and its subclasses.
"
Class {
	#name : #GtPhlowActionTargetExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Core'
}

{ #category : #'examples - composite' }
GtPhlowActionTargetExamples >> basicCompositeActionTarget [

	<gtExample>
	| aTarget |
	aTarget := GtPhlowCompositeActionTarget new.

	self assert: (aTarget isForViewDefinedIn: #gtLiveFor:) not.

	^ aTarget
]

{ #category : #'examples - object' }
GtPhlowActionTargetExamples >> basicObjectActionTarget [

	<gtExample>
	| aTarget |
	aTarget := GtPhlowObjectActionTarget uniqueInstance.

	self assert: (aTarget isForViewDefinedIn: #gtLiveFor:) not.

	^ aTarget
]

{ #category : #'examples - view' }
GtPhlowActionTargetExamples >> basicViewActionTarget [

	<gtExample>
	| aTarget |
	aTarget := GtPhlowViewActionTarget new.

	self assert: (aTarget isForViewDefinedIn: #gtLiveFor:) not.

	^ aTarget
]

{ #category : #'examples - composite' }
GtPhlowActionTargetExamples >> composingCompositeAndViewTargets [

	<gtExample>
	| aLeftTarget aRightTarget aCompositeTarget |
	aLeftTarget := self composingObjectAndViewTargets.
	aRightTarget := self basicViewActionTarget definingMethodSelector: #gtPrintFor:.
	aCompositeTarget := aLeftTarget , aRightTarget.

	self 
		assert: aCompositeTarget targets 
		equals: (aLeftTarget targets copyWith: aRightTarget).
	self assert: (aCompositeTarget isForViewDefinedIn: #gtLiveFor:).
	self assert: (aCompositeTarget isForViewDefinedIn: #gtPrintFor:).
	self assert: (aCompositeTarget isForViewDefinedIn: #gtSomethingElseFor:) not.

	^ aCompositeTarget
]

{ #category : #'examples - composite' }
GtPhlowActionTargetExamples >> composingObjectAndViewTargets [

	<gtExample>
	| anObjectTarget aViewTarget aCompositeTarget |
	anObjectTarget := self basicObjectActionTarget.
	aViewTarget := self viewActionTarget.
	aCompositeTarget := anObjectTarget , aViewTarget.

	self assert: aCompositeTarget targets equals: { anObjectTarget. aViewTarget }.
	self assert: (aCompositeTarget isForViewDefinedIn: #gtLiveFor:).
	self assert: (aCompositeTarget isForViewDefinedIn: #gtSomethingElseFor:) not.

	^ aCompositeTarget
]

{ #category : #'examples - composite' }
GtPhlowActionTargetExamples >> compositeActionTargetWithViewAndObject [

	<gtExample>
	| aTarget aCollection |
	aTarget := self basicCompositeActionTarget.
	aCollection := { self basicObjectActionTarget. self viewActionTarget }.
	aTarget targets: aCollection.

	self assert: aTarget targets equals: aCollection.
	self assert: (aTarget isForViewDefinedIn: #gtLiveFor:).
	self assert: (aTarget isForViewDefinedIn: #gtSomethingElseFor:) not.

	^ aTarget
]

{ #category : #'examples - view' }
GtPhlowActionTargetExamples >> viewActionTarget [

	<gtExample>
	| aTarget |
	aTarget := self basicViewActionTarget.

	aTarget definingMethodSelector: #gtLiveFor:.

	self assert: aTarget definingMethodSelector equals: #gtLiveFor:.

	self assert: (aTarget isForViewDefinedIn: #gtLiveFor:).
	self assert: (aTarget isForViewDefinedIn: #gtSomethingElseFor:) not.

	^ aTarget
]
