Class {
	#name : #GtMultiSplitterDiffElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'from',
		'to',
		'splitters',
		'filterModel',
		'diffHolder',
		'filterElement',
		'diffElement'
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
	^ diffElement fromLabel
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> fromLabel: aText [
	diffElement fromLabel: aText
]

{ #category : #initialization }
GtMultiSplitterDiffElement >> initialize [
	super initialize.
	diffElement := GtDiffElement new
			aptitude: GtDiffFlatAptitude;
			vFitContentLimited;
			beSmallSize;
			moveButtonsToBottom.
	self styler: BlTextNullStyler new.
	self addChild: self makeDiffHolder as: #'diff-container'.
	diffHolder addChild: diffElement asScrollableElement.
	self addChild: self makeFilter as: #filter.
	filterElement visibility: BlVisibility gone
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> leftStyler [
	^ diffElement leftStyler
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> leftStyler: aStyler [
	self assert: aStyler notNil description: 'A styler must not be nil'.
	diffElement leftStyler: aStyler
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
	| changes |
	changes := GtDiffBuilder
			computeDifferencesFrom: from
			to: to
			using: filterModel selectedItem object.
	diffElement
		change: changes;
		scrollNext
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
	^ diffElement rightStyler
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> rightStyler: aStyler [
	self assert: aStyler notNil description: 'A styler must not be nil'.
	diffElement rightStyler: aStyler
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
	^ self leftStyler
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
	^ diffElement toLabel
]

{ #category : #accessing }
GtMultiSplitterDiffElement >> toLabel: aText [
	diffElement toLabel: aText
]
