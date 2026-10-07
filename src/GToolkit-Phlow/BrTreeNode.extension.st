Extension { #name : #BrTreeNode }

{ #category : #'*GToolkit-Phlow' }
BrTreeNode >> asPhlowSelectionItem [
	^ GtPhlowListingViewTreeSelectionItem new
		nodeIdentifier: (GtPhlowNodeIdentifier 
			forTreePath: self phlowTreePath);
		selectionIndex: self indexInTree
]

{ #category : #'*GToolkit-Phlow' }
BrTreeNode >> phlowTreePath [
	| path |
	path := OrderedCollection new.
	self withAllParentNodesDo: [ :node |
		node hasParent ifTrue: [ path add: node indexInChildren ] ].
	^ path asArray
]
