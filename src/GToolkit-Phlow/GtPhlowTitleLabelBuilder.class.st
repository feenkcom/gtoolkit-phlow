Class {
	#name : #GtPhlowTitleLabelBuilder,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - instance creation' }
GtPhlowTitleLabelBuilder class >> block: aBlock [
	self 
		deprecated: 'Use #shortLabel: instead.' 
		transformWith: '`@receiver block: `@arg' -> '`@receiver shortLabel: `@arg'.
	^ self shortLabel: aBlock
]

{ #category : #'api - instance creation' }
GtPhlowTitleLabelBuilder class >> longLabel: aBlock [
	^ GtPhlowLongTitleLabelBuilder new block: aBlock
]

{ #category : #'api - instance creation' }
GtPhlowTitleLabelBuilder class >> null [
	^ GtPhlowNoTitleLabelBuilder default
]

{ #category : #'api - instance creation' }
GtPhlowTitleLabelBuilder class >> shortLabel: aBlock [
	^ GtPhlowShortTitleLabelBuilder new block: aBlock
]

{ #category : #'api - instance creation' }
GtPhlowTitleLabelBuilder class >> toolName: aToolName subjectName: aSubjectName [
	^ GtPhlowToolTitleLabelBuilder new 
		toolName: aToolName;
		subjectName: aSubjectName
]

{ #category : #building }
GtPhlowTitleLabelBuilder >> build [
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
GtPhlowTitleLabelBuilder >> hasLabel [
	^ true
]
