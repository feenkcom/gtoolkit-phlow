Class {
	#name : #GtPhlowLabelledViewBuilder,
	#superclass : #GtPhlowCompositeViewBuilder,
	#instVars : [
		'titleComputation'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #building }
GtPhlowLabelledViewBuilder >> buildView [
	<return: #GtPhlowLabelledView>
	| aView |
	aView := super buildView labelled: self title.
	aView originalView buildContext arguments: { aView. self context }.
	self addBuildContext: aView.
	^ aView
]

{ #category : #label }
GtPhlowLabelledViewBuilder >> title [
	^ titleComputation 
		ifNil: [ self object gtInspectorTitleString ] 
		ifNotNil: [ :aComputation | 
			aComputation cull: self object ]
]

{ #category : #accessing }
GtPhlowLabelledViewBuilder >> titleComputation: aBlock [
	titleComputation := aBlock
]
