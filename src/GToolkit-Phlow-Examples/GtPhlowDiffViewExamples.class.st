Class {
	#name : #GtPhlowDiffViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #'as yet unclassified' }
GtPhlowDiffViewExamples >> expectedElementClass [
	^ GtMultiSplitterDiffElement
]

{ #category : #examples }
GtPhlowDiffViewExamples >> paneStylerFactories [
	<gtExample>
	| aView sources aLeft aRight aCommon anElement calls |
	sources := OrderedCollection new.
	aLeft := BlTextNullStyler new.
	aRight := BlTextNullStyler new.
	aView := GtPhlowView empty diff
			from: [ 'old' ];
			to: [ 'new' ];
			styler: [ :aSource | 
				sources add: aSource.
				aSource = 'old' ifTrue: [ aLeft ] ifFalse: [ aRight ] ];
			yourself.
	anElement := aView asElementDo: [ :each | each ].
	self assert: sources asArray equals: #('old' 'new').
	self assert: anElement leftStyler == aLeft.
	self assert: anElement rightStyler == aRight.

	calls := 0.
	aView
		styler: [ calls := calls + 1.
			BlTextNullStyler new ].
	anElement := aView asElementDo: [ :each | each ].
	self assert: calls equals: 2.
	self assert: anElement leftStyler ~~ anElement rightStyler.

	aCommon := BlTextNullStyler new.
	aView styler: aCommon.
	anElement := aView asElementDo: [ :each | each ].
	self assert: anElement leftStyler == aCommon.
	self assert: anElement rightStyler == aCommon.
	^ anElement
]

{ #category : #'as yet unclassified' }
GtPhlowDiffViewExamples >> phlowView [
	<gtExample>
	^ GtPhlowView empty diff
		from: [ (GtPhlowDiffViewExamples >> #phlowView) sourceCode ];
		to: [ 'phlowView
	<gtExample>
	^ nil' ]
]

{ #category : #examples }
GtPhlowDiffViewExamples >> sharedAndIndependentStylers [
	<gtExample>
	| common left right builders |
	common := BlTextNullStyler new.
	left := BlTextNullStyler new.
	right := BlTextNullStyler new.
	builders := {GtMultiSplitterDiffElement new.
			GtDiffElementWithLabelStencil new}.
	builders
		do: [ :builder | 
			builder styler: common.
			self assert: builder leftStyler == common.
			self assert: builder rightStyler == common.
			builder leftStyler: left.
			self assert: builder leftStyler == left.
			self assert: builder rightStyler == common.
			builder rightStyler: right.
			self assert: builder leftStyler == left.
			self assert: builder rightStyler == right.
			builder styler: common.
			self assert: builder leftStyler == common.
			self assert: builder rightStyler == common ].
	^ builders
]

{ #category : #'as yet unclassified' }
GtPhlowDiffViewExamples >> viewWithLabels [
	<gtExample>
	| view |
	view := self phlowView.

	view
		fromLabel: 'From:';
		toLabel: 'To:'.

	^ view
]

{ #category : #'as yet unclassified' }
GtPhlowDiffViewExamples >> viewWithSplitter [
	<gtExample>
	| view |
	view := self phlowView.

	view splitter: [ GtSmaCCDiffSplitter forPharo ].

	^ view
]

{ #category : #'as yet unclassified' }
GtPhlowDiffViewExamples >> viewWithSplitters [
	<gtExample>
	| view |
	view := self phlowView.

	view
		splitters: [ {GtSmaCCDiffSplitter forPharo.
				GtLineDiffSplitter new} ].

	^ view
]

{ #category : #'as yet unclassified' }
GtPhlowDiffViewExamples >> viewWithStyler [
	<gtExample>
	| view |
	view := self phlowView.

	view styler: [ GtCodeDiffRBTextStyler new isForWorkspace: false ].

	^ view
]
