Class {
	#name : 'GtPhlowLabelledViewBuilder',
	#superclass : 'GtPhlowCompositeViewBuilder',
	#category : 'GToolkit-Phlow-Collectors'
}

{ #category : 'building' }
GtPhlowLabelledViewBuilder >> buildView [
	<return: #GtPhlowLabelledView>
	| aView |
	aView := super buildView labelled: self title.
	aView originalView buildContext arguments: { aView. self context }.
	self addBuildContext: aView.
	^ aView
]

{ #category : 'label' }
GtPhlowLabelledViewBuilder >> title [
	<return: #GtPhlowLabelBuilder>
	^ GtPhlowLabelBuilder new object: self object
]
