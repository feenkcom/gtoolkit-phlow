"
Generic decoration wrapper. Its content determines preferred height. Optional fill stays behind content and never intercepts pointer events.
"
Class {
	#name : #GtPhlowColumnDecorationElement,
	#superclass : #BlElement,
	#instVars : [
		'content',
		'bar',
		'fraction'
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
	fraction := aNumber.
	self updateBarExtent
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
	"Keep positive fills visible, without exceeding the available width.
	Zero fractions remain empty."
	bar ifNotNil: [
		| visualWidth |
		visualWidth := fraction > 0
			ifTrue: [ ((self width * fraction) max: 2) min: self width ]
			ifFalse: [ 0 ].
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
