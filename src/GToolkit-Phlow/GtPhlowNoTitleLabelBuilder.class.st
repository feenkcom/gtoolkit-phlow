Class {
	#name : #GtPhlowNoTitleLabelBuilder,
	#superclass : #GtPhlowTitleLabelBuilder,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #building }
GtPhlowNoTitleLabelBuilder >> build [
	^ BlText empty
]

{ #category : #'api - testing' }
GtPhlowNoTitleLabelBuilder >> hasLabel [
	^ false
]
