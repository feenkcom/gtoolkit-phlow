Class {
	#name : #GtPhlowViewTesterObjectValidationError,
	#superclass : #AssertionFailure,
	#instVars : [
		'object',
		'results'
	],
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterObjectValidationError >> gtResultsFor: aView [
	<gtView>
	<gtExceptionDebuggingView>
	
	^ aView columnedList
		title: 'Views';
		priority: 5;
		items: [ results ];
		column: 'View' text: [ :each | each phlowView definingMethod printString ];
		column: 'Result' text: [ :each |
			each isOk
				ifTrue: [ 'Ok' ]
				ifFalse: [ each isEmpty
					ifTrue: [ 'Empty' ]
					ifFalse: [ 'Error' ] ] ]
]

{ #category : #accessing }
GtPhlowViewTesterObjectValidationError >> object [
	^ object
]

{ #category : #accessing }
GtPhlowViewTesterObjectValidationError >> object: anObject [
	object := anObject
]

{ #category : #accessing }
GtPhlowViewTesterObjectValidationError >> results [
	^ results
]

{ #category : #accessing }
GtPhlowViewTesterObjectValidationError >> results: anObject [
	results := anObject
]
