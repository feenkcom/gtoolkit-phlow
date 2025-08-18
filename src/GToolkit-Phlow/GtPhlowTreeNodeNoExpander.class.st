Class {
	#name : #GtPhlowTreeNodeNoExpander,
	#superclass : #GtPhlowTreeNodeExpander,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Support - Tree Expansion'
}

{ #category : #'api - actions' }
GtPhlowTreeNodeNoExpander >> expandTree: aBrTree [
	"Do nothing. Nodes are collapsed by default."
]
