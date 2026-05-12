Class {
	#name : #GtPhlowTreeNodeUpToExpander,
	#superclass : #GtPhlowTreeNodeExpander,
	#instVars : [
		'level'
	],
	#category : 'GToolkit-Phlow-Support - Tree Expansion'
}

{ #category : #'api - actions' }
GtPhlowTreeNodeUpToExpander >> expandTree: aBrTree [
	aBrTree expandUpTo: self level
]

{ #category : #'api - accessing' }
GtPhlowTreeNodeUpToExpander >> level [
	^ level
]

{ #category : #'api - accessing' }
GtPhlowTreeNodeUpToExpander >> level: aLevelIndex [
	self 
		assert: [ aLevelIndex isInteger and: [ aLevelIndex > 0 ] ] 
		description: [ 'Level index must be a natural number' ].
	level := aLevelIndex
]
