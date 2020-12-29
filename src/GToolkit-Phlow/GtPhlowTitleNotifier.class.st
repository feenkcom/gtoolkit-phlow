Class {
	#name : #GtPhlowTitleNotifier,
	#superclass : #Object,
	#instVars : [
		'element',
		'labelBuilder'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowTitleNotifier >> block: aBlock [
	self 
		deprecated: 'Use #shortLabel: instead.' 
		transformWith: '`@receiver block: `@arg' -> '`@receiver shortLabel: `@arg'.
	self shortLabel: aBlock
]

{ #category : #'api - accessing' }
GtPhlowTitleNotifier >> element [
	^ element
]

{ #category : #'api - accessing' }
GtPhlowTitleNotifier >> element: anObject [
	element := anObject
]

{ #category : #initialization }
GtPhlowTitleNotifier >> initialize [
	super initialize.
	labelBuilder := GtPhlowTitleLabelBuilder null.
]

{ #category : #'private - building' }
GtPhlowTitleNotifier >> label [
	<return: #BlText>
	^ self labelBuilder build
]

{ #category : #'private - accessing' }
GtPhlowTitleNotifier >> labelBuilder [
	<return: #GtPhlowTitleLabelBuilder>
	^ labelBuilder
]

{ #category : #'api - accessing' }
GtPhlowTitleNotifier >> longLabel: aBlock [
	labelBuilder := GtPhlowTitleLabelBuilder longLabel: aBlock
]

{ #category : #'api - notifying' }
GtPhlowTitleNotifier >> notify [
	self subclassResponsibility
]

{ #category : #'api - notifying' }
GtPhlowTitleNotifier >> notifyIfFocused [
	self element hasFocus ifFalse: [ ^ self ].
	self notify.
]

{ #category : #'api - accessing' }
GtPhlowTitleNotifier >> shortLabel: aBlock [
	labelBuilder := GtPhlowTitleLabelBuilder shortLabel: aBlock
]

{ #category : #'api - accessing' }
GtPhlowTitleNotifier >> toolName: aToolName subjectName: aSubjectName [
	labelBuilder := GtPhlowTitleLabelBuilder
		toolName: aToolName
		subjectName: aSubjectName
]
