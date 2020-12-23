Class {
	#name : #GtPhlowTitleLabelBuilder,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - instance creation' }
GtPhlowTitleLabelBuilder class >> block: aBlock [
	^ GtPhlowBlockTitleLabelBuilder new block: aBlock
]

{ #category : #'api - instance creation' }
GtPhlowTitleLabelBuilder class >> null [
	^ GtPhlowNoTitleLabelBuilder default
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
