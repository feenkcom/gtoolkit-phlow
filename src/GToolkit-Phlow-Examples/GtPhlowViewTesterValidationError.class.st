Class {
	#name : #GtPhlowViewTesterValidationError,
	#superclass : #AssertionFailure,
	#instVars : [
		'actualResult',
		'expectedResult'
	],
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterValidationError >> actualResult [
	^ actualResult
]

{ #category : #accessing }
GtPhlowViewTesterValidationError >> actualResult: anObject [
	actualResult := anObject
]

{ #category : #accessing }
GtPhlowViewTesterValidationError >> expectedResult [
	^ expectedResult
]

{ #category : #accessing }
GtPhlowViewTesterValidationError >> expectedResult: anObject [
	expectedResult := anObject
]

{ #category : #accessing }
GtPhlowViewTesterValidationError >> gtActualResultFor: aView [
	<gtView>
	<gtExceptionDebuggingView>

	^ aView forward
		title: 'Failure';
		priority: 5;
		object: [ actualResult ];
		view: #gtLiveFor:
]
