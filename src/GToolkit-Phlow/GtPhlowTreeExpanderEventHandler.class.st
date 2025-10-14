Class {
	#name : #GtPhlowTreeExpanderEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'treeElement'
	],
	#category : #'GToolkit-Phlow-Support - Tree Expansion'
}

{ #category : #'api - accessing' }
GtPhlowTreeExpanderEventHandler >> eventsToHandle [
	^ {GtPhlowCollapseLevelWish.
		GtPhlowExpandLevelWish}
]

{ #category : #'api - event managing' }
GtPhlowTreeExpanderEventHandler >> phlowCollapseLevelWish: aWish [
	| aRootNode aMaxDepth |
	aWish consumed: true.
	treeElement ifNil: [ ^ self ].

	aRootNode := treeElement viewModel root.
	aMaxDepth := 0.
	aRootNode
		allChildrenNodesBreadthFirstConditionedDo: [ :eachNode | 
			aMaxDepth := aMaxDepth max: eachNode depth.
			eachNode isExpanded ].
	aMaxDepth isZero ifTrue: [ ^ self ].
	aMaxDepth := aMaxDepth - 1.
	
	aRootNode
		allChildrenNodesBreadthFirstConditionedDo: [ :eachNode | 
			eachNode depth >= aMaxDepth ifTrue: [ eachNode collapse ].
			eachNode isExpanded and: [ eachNode depth <= aMaxDepth ] ]
]

{ #category : #'api - event managing' }
GtPhlowTreeExpanderEventHandler >> phlowExpandLevelWish: aWish [
	| aRootNode aMaxDepth |
	aWish consumed: true.
	treeElement ifNil: [ ^ self ].

	aRootNode := treeElement viewModel root.
	aMaxDepth := 0.
	aRootNode
		allChildrenNodesBreadthFirstConditionedDo: [ :eachNode | 
			aMaxDepth := aMaxDepth max: eachNode depth.
			eachNode isExpanded ].

	aRootNode
		allChildrenNodesBreadthFirstConditionedDo: [ :eachNode | 
			eachNode depth <= aMaxDepth ifTrue: [ eachNode expand ].
			eachNode depth <= aMaxDepth ]
]

{ #category : #accessing }
GtPhlowTreeExpanderEventHandler >> treeElement [
	^ treeElement
]

{ #category : #accessing }
GtPhlowTreeExpanderEventHandler >> treeElement: anObject [
	treeElement := anObject
]
