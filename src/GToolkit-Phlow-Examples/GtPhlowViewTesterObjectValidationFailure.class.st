Class {
	#name : #GtPhlowViewTesterObjectValidationFailure,
	#superclass : #GtPhlowViewTesterFailure,
	#instVars : [
		'object',
		'results'
	],
	#category : #'GToolkit-Phlow-Examples-Tester'
}

{ #category : #accessing }
GtPhlowViewTesterObjectValidationFailure >> gtResultsFor: aView [
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
GtPhlowViewTesterObjectValidationFailure >> object [
	^ object
]

{ #category : #accessing }
GtPhlowViewTesterObjectValidationFailure >> object: anObject [
	object := anObject
]

{ #category : #accessing }
GtPhlowViewTesterObjectValidationFailure >> results [
	^ results
]

{ #category : #accessing }
GtPhlowViewTesterObjectValidationFailure >> results: anObject [
	results := anObject
]
