"
Wraps arbitrary cell content with a normalized fill. A maximum block is evaluated lazily and cached until content preparation.
"
Class {
	#name : #GtPhlowColumnNormalizedBarDecoration,
	#superclass : #GtPhlowColumnDecoration,
	#instVars : [
		'maximumComputation',
		'maximumComputed',
		'maximumValue',
		'fractionComputation',
		'color'
	],
	#category : #'GToolkit-Phlow-Support - Decorations'
}

{ #category : #binding }
GtPhlowColumnNormalizedBarDecoration >> bind: anElement value: aValue rowIndex: aRowIndex columnIndex: aColumnIndex [
	anElement fraction: (self fractionFor: aValue); barColor: self color
]

{ #category : #accessing }
GtPhlowColumnNormalizedBarDecoration >> color [
	^ color ifNil: [ Color blue alpha: 0.15 ]
]

{ #category : #scripting }
GtPhlowColumnNormalizedBarDecoration >> color: aColor [
	color := aColor
]

{ #category : #scripting }
GtPhlowColumnNormalizedBarDecoration >> fraction: aBlock [
	fractionComputation := aBlock.
	maximumComputation := nil.
	self prepareForUpdateContent
]

{ #category : #computing }
GtPhlowColumnNormalizedBarDecoration >> fractionFor: aValue [
	| aFraction aMaximum |
	self validateNumber: aValue.
	aFraction := fractionComputation
		ifNotNil: [ fractionComputation value: aValue ]
		ifNil: [ aMaximum := self maximum.
			aMaximum isZero ifTrue: [ 0 ] ifFalse: [ aValue / aMaximum ] ].
	self validateNumber: aFraction.
	^ (aFraction max: 0) min: 1
]

{ #category : #private }
GtPhlowColumnNormalizedBarDecoration >> maximum [
	(maximumComputed == true) ifFalse: [
		maximumComputation ifNil: [ self error: 'Configure a maximum or fraction computation' ].
		maximumValue := self validateNumber: maximumComputation value.
		maximumValue < 0 ifTrue: [ self error: 'Normalized bar maximum must be nonnegative' ].
		maximumComputed := true ].
	^ maximumValue
]

{ #category : #scripting }
GtPhlowColumnNormalizedBarDecoration >> maximum: aBlock [
	maximumComputation := aBlock.
	fractionComputation := nil.
	self prepareForUpdateContent
]

{ #category : #updating }
GtPhlowColumnNormalizedBarDecoration >> prepareForUpdateContent [
	maximumComputed := false.
	maximumValue := nil
]

{ #category : #private }
GtPhlowColumnNormalizedBarDecoration >> validateNumber: aNumber [
	(aNumber isNumber and: [ aNumber asFloat isFinite ])
		ifFalse: [ self error: 'Normalized bars require finite numbers' ].
	^ aNumber
]

{ #category : #building }
GtPhlowColumnNormalizedBarDecoration >> wrap: anElement [
	^ (super wrap: anElement) withBar
]
