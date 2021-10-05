Class {
	#name : #GtPhlowTreeNodeExpander,
	#superclass : #Object,
	#category : 'GToolkit-Phlow-Support - Tree Expansion'
}

{ #category : #'api - instance creation' }
GtPhlowTreeNodeExpander class >> null [
	^ GtPhlowTreeNodeNoExpander default
]

{ #category : #'api - instance creation' }
GtPhlowTreeNodeExpander class >> suchThat: aBlock [
	^ GtPhlowTreeNodeConditionalExpander new condition: aBlock
]

{ #category : #'api - instance creation' }
GtPhlowTreeNodeExpander class >> upTo: aLevelIndex [
	^ GtPhlowTreeNodeUpToExpander new level: aLevelIndex
]

{ #category : #'api - actions' }
GtPhlowTreeNodeExpander >> expandTree: aBrTree [
	self subclassResponsibility
]
