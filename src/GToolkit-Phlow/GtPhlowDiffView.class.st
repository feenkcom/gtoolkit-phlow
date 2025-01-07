Class {
	#name : #GtPhlowDiffView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'from',
		'to',
		'splitters',
		'styler',
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
			performBlock: [ GtMultiSplitterDiffElement new matchParent
					from: from value;
					to: to value;
					styler: styler value;
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
	^ GtCodeDiffRBTextStyler new
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

	styler := self defaultStyler.
	splitters := [ {self defaultSplitter} ].
	fromLabel := ''.
	toLabel := ''
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
	^ styler
]

{ #category : #accessing }
GtPhlowDiffView >> styler: anObject [
	styler := anObject
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
