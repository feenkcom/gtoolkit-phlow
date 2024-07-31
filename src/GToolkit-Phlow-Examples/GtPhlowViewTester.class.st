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
	^ self 
		assertObject: anObject 
		withViewsSelector: #gtViewsInContext:
]

{ #category : #testing }
GtPhlowViewTester >> assertObject: anObject withViews: aCollectionOfViews [
	| theResults |

	theResults := self testViews: aCollectionOfViews.
	(theResults allSatisfy: [ :eachResult | eachResult isOk or: [ eachResult isEmpty ] ])
		ifTrue: [ ^ self ].
	
	(GtPhlowViewTesterObjectValidationFailure new
		object: anObject;
		results: theResults) signal
]

{ #category : #testing }
GtPhlowViewTester >> assertObject: anObject withViewsSelector: aViewsSelector [
	^ self 
		assertObject: anObject 
		withViews: (thisContext 
			object: anObject
			perform: aViewsSelector
			withArguments: {GtPhlowContext new}
			inClass: anObject class)
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

{ #category : #testing }
GtPhlowViewTester >> testViews: aCollectionOfViews [
	<return: #GtPhlowViewTesterResult>
	| theResults |

	theResults := aCollectionOfViews collect: [ :eachView | 
		self testView: eachView ].

	^ theResults
]
