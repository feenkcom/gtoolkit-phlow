Class {
	#name : #GtMultiSplitterDiffElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'from',
		'to',
		'splitters',
		'fromLabel',
		'toLabel',
		'filterModel',
		'diffHolder',
		'filterElement',
		'leftStyler',
		'rightStyler'
	],
	#category : #'GToolkit-Phlow-UI'
}

{ #category : #accessing }
GtMultiSplitterDiffElement >> from [
	^ from
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> from: anObject [
	from := anObject
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> fromLabel [
	^ fromLabel
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> fromLabel: anObject [
	fromLabel := anObject
]

{ #category : #'as yet unclassified' }
GtMultiSplitterDiffElement >> initialize [
	super initialize.

	self addChild: self makeDiffHolder as: #'diff-container'.

	self addChild: self makeFilter as: #filter
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> leftStyler [
	^ leftStyler
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> leftStyler: aStyler [
	leftStyler := aStyler
]

{ #category : #'as yet unclassified' }
GtMultiSplitterDiffElement >> makeDiffHolder [
	^ diffHolder := BrVerticalPane new matchParent
]

{ #category : #'as yet unclassified' }
GtMultiSplitterDiffElement >> makeFilter [
	filterModel := GtFilterShortListModel new.
	filterModel name: 'Split'.
	filterModel items: {}.
	filterModel weak
		when: GtFilterModelSelectedItemChanged
		send: #onSelectedItemChanged
		to: self.

	filterElement := filterModel asFilterLabeledElement.

	^ filterElement
]

{ #category : #private }
GtMultiSplitterDiffElement >> onSelectedItemChanged [
	| changes stencil |
	changes := GtDiffBuilder
			computeDifferencesFrom: from
			to: to
			using: filterModel selectedItem object.
	stencil := GtDiffElementWithLabelStencil new
			change: changes;
			leftStyler: leftStyler;
			rightStyler: rightStyler.
	stencil fromLabelText: fromLabel.
	stencil toLabelText: toLabel.
	diffHolder removeChildren addChild: stencil asElement
]

{ #category : #'as yet unclassified' }
GtMultiSplitterDiffElement >> onSplittersChanged [
	self assert: splitters size > 0 description: [ 'Splitters cannot be empty' ].

	filterModel items: splitters label: #descriptionString.
	filterModel selectFirstItem.

	splitters size = 1
		ifTrue: [ filterElement visibility: BlVisibility gone ]
		ifFalse: [ filterElement visibility: BlVisibility visible ]
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> rightStyler [
	^ rightStyler
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> rightStyler: aStyler [
	rightStyler := aStyler
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> splitters [
	^ splitters
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> splitters: anObject [
	splitters := anObject.

	self onSplittersChanged.
	self onSelectedItemChanged
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> styler [
	^ leftStyler
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> styler: aStyler [
	self
		leftStyler: aStyler;
		rightStyler: aStyler
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> to [
	^ to
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> to: anObject [
	to := anObject
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> toLabel [
	^ toLabel
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> toLabel: anObject [
	toLabel := anObject
]
