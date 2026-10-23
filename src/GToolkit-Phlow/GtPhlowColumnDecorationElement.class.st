"
Generic decoration wrapper. Its content determines preferred height. Optional fill stays behind content and never intercepts pointer events.
"
Class {
	#name : #GtPhlowColumnDecorationElement,
	#superclass : #BlElement,
	#instVars : [
		'content',
		'bar',
		'fraction',
		'baselineFraction'
	],
	#category : #'GToolkit-Phlow-Support - Decorations'
}

{ #category : #accessing }
GtPhlowColumnDecorationElement >> bar [
	^ bar
]

{ #category : #accessing }
GtPhlowColumnDecorationElement >> barColor: aColor [
	bar background: aColor
]

{ #category : #accessing }
GtPhlowColumnDecorationElement >> baselineFraction [
	^ baselineFraction ifNil: [ 0 ]
]

{ #category : #accessing }
GtPhlowColumnDecorationElement >> baselineFraction: aBaseline endpointFraction: anEndpoint [
	baselineFraction := aBaseline.
	fraction := anEndpoint.
	self updateBarExtent
]

{ #category : #accessing }
GtPhlowColumnDecorationElement >> content [
	^ content
]

{ #category : #accessing }
GtPhlowColumnDecorationElement >> content: anElement [
	content ifNotNil: [ self removeChild: content ].
	content := anElement.
	self addChild: content
]

{ #category : #accessing }
GtPhlowColumnDecorationElement >> fraction [
	^ fraction
]

{ #category : #accessing }
GtPhlowColumnDecorationElement >> fraction: aNumber [
	self baselineFraction: 0 endpointFraction: aNumber
]

{ #category : #initialization }
GtPhlowColumnDecorationElement >> initialize [
	super initialize.
	fraction := 0.
	self layout: BlFrameLayout new;
		constraintsDo: [ :c | c horizontal matchParent. c vertical fitContent ].
	self when: BlElementExtentChangedEvent do: [ :event | self updateBarExtent ]
]

{ #category : #private }
GtPhlowColumnDecorationElement >> updateBarExtent [
	"Extend from zero in either direction; retain a 2px minimum when space allows."
	bar ifNotNil: [
		| baseline delta available visualWidth left |
		baseline := self width * self baselineFraction.
		delta := (fraction - self baselineFraction) * self width.
		available := delta < 0 ifTrue: [ baseline ] ifFalse: [ self width - baseline ].
		visualWidth := delta isZero
			ifTrue: [ 0 ]
			ifFalse: [ (delta abs max: 2) min: available ].
		left := delta < 0 ifTrue: [ baseline - visualWidth ] ifFalse: [ baseline ].
		bar relocate: left @ 0.
		bar size: visualWidth @ self height ]
]

{ #category : #building }
GtPhlowColumnDecorationElement >> withBar [
	bar ifNotNil: [ ^ self ].
	bar := BlElement new
		constraintsDo: [ :c | c ignoreByLayout ];
		preventMeAndChildrenMouseEvents.
	self removeChild: content.
	self addChildren: { bar. content }
]
