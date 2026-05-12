Class {
	#name : #GtPhlowColumnCacheValue,
	#superclass : #Object,
	#instVars : [
		'futureResultHolder',
		'exceptionResultHolder',
		'successResultHolder'
	],
	#category : 'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowColumnCacheValue >> exceptionResult [
	^ exceptionResultHolder value
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> exceptionResult: anObject [
	exceptionResultHolder := GtPhlowObject forValue: anObject
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> exceptionResultHolder [
	^ exceptionResultHolder
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> futureResult [
	^ futureResultHolder value
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> futureResult: anObject [
	futureResultHolder := GtPhlowObject forValue: anObject
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> futureResultHolder [
	^ futureResultHolder
]

{ #category : #'gt - extensions' }
GtPhlowColumnCacheValue >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Future result';
			description: self futureResultHolder gtDisplayText;
			value: self futureResultHolder.
		GtPhlowOverviewItem new
			name: 'Exception result';
			description: self exceptionResultHolder gtDisplayText;
			value: self futureResultHolder.
		GtPhlowOverviewItem new
			name: 'Success result';
			description: self successResultHolder gtDisplayText;
			value: self successResultHolder}
]

{ #category : #'gt - extensions' }
GtPhlowColumnCacheValue >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Info';
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Description'
			text: #description
			weight: 2;
		send: [ :anItem | anItem value value ]
]

{ #category : #initialization }
GtPhlowColumnCacheValue >> initialize [
	super initialize.

	futureResultHolder := GtPhlowUndefinedObject default.
	exceptionResultHolder := GtPhlowUndefinedObject default.
	successResultHolder := GtPhlowUndefinedObject default
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> successResult [
	^ successResultHolder value
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> successResult: anObject [
	successResultHolder := GtPhlowObject forValue: anObject
]

{ #category : #accessing }
GtPhlowColumnCacheValue >> successResultHolder [
	^ successResultHolder
]
