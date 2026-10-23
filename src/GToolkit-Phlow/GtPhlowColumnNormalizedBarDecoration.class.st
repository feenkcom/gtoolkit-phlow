"
Wraps arbitrary cell content with a diverging normalized fill. minimum: and maximum: accept independently configured lazy blocks, cached until content preparation. The minimum defaults to zero; the effective domain includes zero. Invalid/reversed bounds raise an error. Negative values extend left of the zero baseline, positive values extend right. fraction: retains the custom endpoint-fraction mode with a zero baseline at the left edge. Configure bounds before materializing the view.
"
Class {
	#name : #GtPhlowColumnNormalizedBarDecoration,
	#superclass : #GtPhlowColumnDecoration,
	#instVars : [
		'maximumComputation',
		'maximumComputed',
		'maximumValue',
		'fractionComputation',
		'color',
		'minimumComputation',
		'minimumComputed',
		'minimumValue'
	],
	#category : #'GToolkit-Phlow-Support - Decorations'
}

{ #category : #computing }
GtPhlowColumnNormalizedBarDecoration >> baselineFraction [
	| bounds span |
	fractionComputation ifNotNil: [ ^ 0 ].
	bounds := self bounds.
	span := bounds value - bounds key.
	^ span isZero ifTrue: [ 0 ] ifFalse: [ bounds key negated / span ]
]

{ #category : #binding }
GtPhlowColumnNormalizedBarDecoration >> bind: anElement value: aValue rowIndex: aRowIndex columnIndex: aColumnIndex [
	anElement baselineFraction: self baselineFraction endpointFraction: (self fractionFor: aValue).
	anElement barColor: self color
]

{ #category : #private }
GtPhlowColumnNormalizedBarDecoration >> bounds [
	| lower upper |
	lower := self minimum.
	upper := self maximum.
	lower > upper ifTrue: [ self error: 'Normalized bar minimum must not exceed maximum' ].
	^ (lower min: 0) -> (upper max: 0)
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
	"Endpoint position in [0,1], rather than distance from the zero baseline."
	| aFraction bounds span |
	self validateNumber: aValue.
	aFraction := fractionComputation
		ifNotNil: [ fractionComputation value: aValue ]
		ifNil: [ bounds := self bounds.
			span := bounds value - bounds key.
			span isZero ifTrue: [ 0 ] ifFalse: [ (aValue - bounds key) / span ] ].
	self validateNumber: aFraction.
	^ (aFraction max: 0) min: 1
]

{ #category : #private }
GtPhlowColumnNormalizedBarDecoration >> maximum [
	(maximumComputed == true) ifFalse: [
		maximumComputation ifNil: [ self error: 'Configure a maximum or fraction computation' ].
		maximumValue := self validateNumber: maximumComputation value.
		maximumComputed := true ].
	^ maximumValue
]

{ #category : #scripting }
GtPhlowColumnNormalizedBarDecoration >> maximum: aBlock [
	maximumComputation := aBlock.
	fractionComputation := nil.
	self prepareForUpdateContent
]

{ #category : #private }
GtPhlowColumnNormalizedBarDecoration >> minimum [
	(minimumComputed == true) ifFalse: [
		minimumValue := self validateNumber: (minimumComputation ifNil: [ 0 ] ifNotNil: [ minimumComputation value ]).
		minimumComputed := true ].
	^ minimumValue
]

{ #category : #scripting }
GtPhlowColumnNormalizedBarDecoration >> minimum: aBlock [
	"Lazy lower bound; defaults to zero. Preserve the configured maximum."
	minimumComputation := aBlock.
	fractionComputation := nil.
	self prepareForUpdateContent
]

{ #category : #updating }
GtPhlowColumnNormalizedBarDecoration >> prepareForUpdateContent [
	maximumComputed := false.
	maximumValue := nil.
	minimumComputed := false.
	minimumValue := nil
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
