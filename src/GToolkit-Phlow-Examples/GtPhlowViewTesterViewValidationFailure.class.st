Class {
	#name : #GtPhlowViewTesterViewValidationFailure,
	#superclass : #GtPhlowViewTesterFailure,
	#instVars : [
		'actualResult',
		'expectedResult'
	],
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterViewValidationFailure >> actualResult [
	^ actualResult
]

{ #category : #accessing }
GtPhlowViewTesterViewValidationFailure >> actualResult: anObject [
	actualResult := anObject
]

{ #category : #accessing }
GtPhlowViewTesterViewValidationFailure >> expectedResult [
	^ expectedResult
]

{ #category : #accessing }
GtPhlowViewTesterViewValidationFailure >> expectedResult: anObject [
	expectedResult := anObject
]

{ #category : #accessing }
GtPhlowViewTesterViewValidationFailure >> gtActualResultFor: aView [
	<gtView>
	<gtExceptionView>

	^ aView forward
		title: 'Failure';
		priority: 5;
		object: [ actualResult ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtPhlowViewTesterViewValidationFailure >> gtExceptionsFor: aView [
	<gtView>
	<gtExceptionView>

	^ aView forward
		title: 'Exceptions';
		priority: 6;
		object: [ actualResult ];
		view: #gtExceptionsFor:
]
