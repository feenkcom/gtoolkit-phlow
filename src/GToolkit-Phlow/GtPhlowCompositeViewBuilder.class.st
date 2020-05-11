Class {
	#name : #GtPhlowCompositeViewBuilder,
	#superclass : #GtPhlowViewBuilder,
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #actions }
GtPhlowCompositeViewBuilder >> actions [ 
	<return: #Array of: #GtPhlowAction>
	^ self object gtActions
]

{ #category : #actions }
GtPhlowCompositeViewBuilder >> addActionsInto: aView [
	self actions
		do: [ :action | 
			action isDefaultTarget
				ifTrue: [ aView addPhlowAction: action ] ]
]

{ #category : #building }
GtPhlowCompositeViewBuilder >> build [
	<return: #GtPhlowCompositeView>
	| aView |
	aView := self buildView.
	self addActionsInto: aView.
	^ aView
]

{ #category : #building }
GtPhlowCompositeViewBuilder >> buildView [
	<return: #GtPhlowCompositeView>
	^ self view composite views: self views
]

{ #category : #views }
GtPhlowCompositeViewBuilder >> views [
	<return: #Array of: #GtPhlowView>
	^ self object gtViewsInContext: self context
]
