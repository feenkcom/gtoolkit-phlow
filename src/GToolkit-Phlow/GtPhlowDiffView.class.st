Class {
	#name : #GtPhlowDiffView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'from',
		'to',
		'splitters',
		'leftStyler',
		'rightStyler',
		'fromLabel',
		'toLabel'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #'as yet unclassified' }
GtPhlowDiffView >> asElementDo: aBlock [
	| anElement |
	self
		assert: [ from notNil ]
		description: [ 'from string needs to be initialized' ].
	self assert: [ to notNil ] description: [ 'to string needs to be initialized' ].
	anElement := self
			performBlock: [ | aFromSource aToSource |
				aFromSource := from value.
				aToSource := to value.
				GtMultiSplitterDiffElement new matchParent
					from: aFromSource;
					to: aToSource;
					leftStyler: (self leftStyler gtValueWithArgs: {aFromSource});
					rightStyler: (self rightStyler gtValueWithArgs: {aToSource});
					fromLabel: fromLabel value;
					toLabel: toLabel value;
					splitters: splitters value ]
			onExceptionErrorElement: [ :anErrorElement | ^ aBlock value: anErrorElement ].
	self beViewElement: anElement.
	^ aBlock value: anElement
]

{ #category : #'as yet unclassified' }
GtPhlowDiffView >> defaultSplitter [
	^ GtCharacterGroupDiffSplitter words ignoreWhitespace
]

{ #category : #'as yet unclassified' }
GtPhlowDiffView >> defaultStyler [
	^ BlTextNullStyler new
]

{ #category : #accessing }
GtPhlowDiffView >> from [
	^ from
]

{ #category : #accessing }
GtPhlowDiffView >> from: anObject [
	from := anObject
]

{ #category : #accessing }
GtPhlowDiffView >> fromLabel [
	^ fromLabel
]

{ #category : #accessing }
GtPhlowDiffView >> fromLabel: anObject [
	fromLabel := anObject
]

{ #category : #'as yet unclassified' }
GtPhlowDiffView >> initialize [
	super initialize.

	self styler: self defaultStyler.
	splitters := [ {self defaultSplitter} ].
	fromLabel := ''.
	toLabel := ''
]

{ #category : #accessing }
GtPhlowDiffView >> leftStyler [
	^ leftStyler
]

{ #category : #accessing }
GtPhlowDiffView >> leftStyler: aStyler [
	"Accept a styler, a zero-argument factory, or a block receiving this pane's source."

	leftStyler := aStyler
]

{ #category : #accessing }
GtPhlowDiffView >> rightStyler [
	^ rightStyler
]

{ #category : #accessing }
GtPhlowDiffView >> rightStyler: aStyler [
	"Accept a styler, a zero-argument factory, or a block receiving this pane's source."

	rightStyler := aStyler
]

{ #category : #accessing }
GtPhlowDiffView >> splitter: anObject [
	"it’s best to use #splitters: instead. this method is left for convenience"
	splitters := [ {anObject value} ]
]

{ #category : #accessing }
GtPhlowDiffView >> splitters: anObject [
	splitters := anObject
]

{ #category : #accessing }
GtPhlowDiffView >> styler [
	^ self leftStyler
]

{ #category : #accessing }
GtPhlowDiffView >> styler: aStyler [
	self
		leftStyler: aStyler;
		rightStyler: aStyler
]

{ #category : #accessing }
GtPhlowDiffView >> to [
	^ to
]

{ #category : #accessing }
GtPhlowDiffView >> to: anObject [
	to := anObject
]

{ #category : #accessing }
GtPhlowDiffView >> toLabel [
	^ toLabel
]

{ #category : #accessing }
GtPhlowDiffView >> toLabel: anObject [
	toLabel := anObject
]
