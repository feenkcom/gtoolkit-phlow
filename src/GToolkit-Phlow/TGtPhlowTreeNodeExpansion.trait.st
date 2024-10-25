"
I provide expanding API for {{gtClass:GtPhlowTreeView}} and {{gtClass:GtPhlowColumnedTreeView}}.

"
Trait {
	#name : #TGtPhlowTreeNodeExpansion,
	#instVars : [
		'expander'
	],
	#category : #'GToolkit-Phlow-Support - Tree Expansion'
}

{ #category : #'api - expansion' }
TGtPhlowTreeNodeExpansion >> collapseAll [
	expander := GtPhlowTreeNodeExpander null.
]

{ #category : #'api - expansion' }
TGtPhlowTreeNodeExpansion >> expandAll [
	self expandUpTo: 20
]

{ #category : #'private - accessing' }
TGtPhlowTreeNodeExpansion >> expander [
	<return: #GtPhlowTreeNodeExpander>
	^ expander ifNil: [ expander := GtPhlowTreeNodeExpander null ]
]

{ #category : #'api - expansion' }
TGtPhlowTreeNodeExpansion >> expandOneLevel [
	self expandUpTo: 1
]

{ #category : #'api - expansion' }
TGtPhlowTreeNodeExpansion >> expandSuchThat: aBlock [
	"It stops expanding children if a parent node does not satisfy the condition.
	The block receives [ :aTreeNode :aNodeValue | ... ]"
	expander := GtPhlowTreeNodeExpander suchThat: aBlock.
]

{ #category : #'private - building' }
TGtPhlowTreeNodeExpansion >> expandTree: aBrTree [ 
	expander ifNil: [ ^ self ].
	expander expandTree: aBrTree.
]

{ #category : #'api - expansion' }
TGtPhlowTreeNodeExpansion >> expandUpTo: aLevelIndex [
	expander := GtPhlowTreeNodeExpander upTo: aLevelIndex.
]
