Class {
	#name : #GtPhlowDiffViewExamples,
	#superclass : #GtPhlowViewExamples,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #'as yet unclassified' }
GtPhlowDiffViewExamples >> expectedElementClass [
	^ BrVerticalPane
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
GtPhlowDiffViewExamples >> viewWithStyler [
	<gtExample>
	| view |
	view := self phlowView.

	view styler: [ GtCodeDiffRBTextStyler new isForWorkspace: false ].

	^ view
]
