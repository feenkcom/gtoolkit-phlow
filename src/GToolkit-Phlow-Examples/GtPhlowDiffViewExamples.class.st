Class {
	#name : #GtPhlowDiffViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #'as yet unclassified' }
GtPhlowDiffViewExamples >> expectedElementClass [
	^ GtMultiSplitterDiffElement
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
