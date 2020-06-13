Class {
	#name : #GtPhlowCompositeViewBuilder,
	#superclass : #GtPhlowViewBuilder,
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #building }
GtPhlowCompositeViewBuilder >> buildView [
	<return: #GtPhlowCompositeView>
	| aView |
	aView := self view composite views: self views.
	self addBuildContext: aView.
	^ aView
]

{ #category : #views }
GtPhlowCompositeViewBuilder >> views [
	<return: #Array of: #GtPhlowView>
	^ self object gtViewsInContext: self context
]
