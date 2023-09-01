Class {
	#name : #GtPhlowViewTester,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #asserting }
GtPhlowViewTester >> assertEmpty: aTesterResult [
	self assertResult: aTesterResult equals: GtPhlowViewTesterNoElementFailureResult new
]

{ #category : #testing }
GtPhlowViewTester >> assertObject: anObject [
	| theResults |

	theResults := self testObject: anObject.
	(theResults allSatisfy: [ :eachResult | eachResult isOk or: [ eachResult isEmpty ] ])
		ifTrue: [ ^ self ].
	
	(GtPhlowViewTesterObjectValidationFailure new
		object: anObject;
		results: theResults) signal
]

{ #category : #asserting }
GtPhlowViewTester >> assertOk: aTesterResult [
	self assertResult: aTesterResult equals: GtPhlowViewTesterOkResult new
]

{ #category : #asserting }
GtPhlowViewTester >> assertResult: anActualTesterResult equals: anExpectedResult [
	anActualTesterResult = GtPhlowViewTesterNoElementFailureResult new
		ifTrue: [ ^ self ].

	^ (GtPhlowViewTesterViewValidationFailure new
		actualResult: anActualTesterResult;
		expectedResult: anExpectedResult) signal
]

{ #category : #testing }
GtPhlowViewTester >> assertViewEmpty: aPhlowView [
	self assertEmpty: (self testView: aPhlowView)
]

{ #category : #testing }
GtPhlowViewTester >> assertViewOk: aPhlowView [
	self assertOk: (self testView: aPhlowView)
]

{ #category : #testing }
GtPhlowViewTester >> testObject: anObject [
	<return: #GtPhlowViewTesterResult>
	| theViews theResults |

	theViews := anObject gtViewsInContext: GtPhlowContext new.
	theResults := theViews collect: [ :eachView | self testView: eachView ].

	^ theResults
]

{ #category : #testing }
GtPhlowViewTester >> testView: aPhlowView [
	<return: #GtPhlowViewTesterResult>
	| result |
	
	result := GtPhlowViewTesterNoElementFailureResult new
		phlowView: aPhlowView;
		phlowElement: nil.

	aPhlowView asElementDo: [ :anElement | 
		result := self testView: aPhlowView andElement: anElement ].

	^ result
]

{ #category : #testing }
GtPhlowViewTester >> testView: aPhlowView andElement: aPhlowViewElement [
	<return: #GtPhlowViewTesterResult>
	| scripter |
	
	scripter := BlScripter new.
	scripter element: aPhlowViewElement.
	scripter elementWithoutParent.
	
	(aPhlowViewElement id = GtPhlowExceptionId asBlocElementId)
		ifTrue: [
			^ GtPhlowViewTesterViewCreationExceptionFailureResult new
				phlowView: aPhlowView;
				phlowElement: aPhlowViewElement;
				exceptionElement: aPhlowViewElement ].
	
	(aPhlowViewElement query // GtPhlowExceptionId) all
		ifNotEmpty: [ :theExceptionElements |
			^ GtPhlowViewTesterViewContentExceptionFailureResult new
				phlowView: aPhlowView;
				phlowElement: aPhlowViewElement;
				exceptionElements: theExceptionElements ].
	
	^ GtPhlowViewTesterOkResult new
		phlowView: aPhlowView;
		phlowElement: aPhlowViewElement
]
