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

{ #category : #'adding - actions' }
TGtPhlowTreeNodeExpansion >> actionCollapseAndExpandButtons [
	self actionCollapseOneLevelButton.
	self actionExpandOneLevelButton
]

{ #category : #'adding - actions' }
TGtPhlowTreeNodeExpansion >> actionCollapseOneLevelButton [
	self
		actionButtonIcon: BrGlamorousVectorIcons collapsevertical
		tooltip: 'Collapse one level'
		action: [ :aButton :aTab | aTab fireEvent: GtPhlowCollapseLevelWish new ]
]

{ #category : #'adding - actions' }
TGtPhlowTreeNodeExpansion >> actionExpandOneLevelButton [
	self
		actionButtonIcon: BrGlamorousVectorIcons expandvertical
		tooltip: 'Expand one level'
		action: [ :aButton :aTab | aTab fireEvent: GtPhlowExpandLevelWish new ]
]

{ #category : #'api - expansion' }
TGtPhlowTreeNodeExpansion >> collapseAll [
	expander := GtPhlowTreeNodeExpander null.
]

{ #category : #'api - expansion' }
TGtPhlowTreeNodeExpansion >> expandAll [
	self expandUpTo: 20
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

{ #category : #'private - accessing' }
TGtPhlowTreeNodeExpansion >> expander [
	<return: #GtPhlowTreeNodeExpander>
	^ expander ifNil: [ expander := GtPhlowTreeNodeExpander null ]
]
