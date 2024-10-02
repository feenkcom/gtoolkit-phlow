Class {
	#name : #GtPhlowDiffView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'from',
		'to',
		'splitter',
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
		description: [ 'from string needs to be initialize' ].

	self assert: [ to notNil ] description: [ 'to string needs to be initialize' ].

	anElement := self
			performBlock: [ | changes stencil |
				changes := GtDiffBuilder
						computeDifferencesFrom: from value
						to: to value
						using: splitter value.

				stencil := GtDiffElementWithLabelStencil new
						change: changes;
						styler: styler value.

				stencil fromLabelText: fromLabel value.
				stencil toLabelText: toLabel value.
				stencil asElement ]
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
	splitter := self defaultSplitter.
	fromLabel := ''.
	toLabel := ''
]

{ #category : #accessing }
GtPhlowDiffView >> splitter [
	^ splitter
]

{ #category : #accessing }
GtPhlowDiffView >> splitter: anObject [
	splitter := anObject
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
