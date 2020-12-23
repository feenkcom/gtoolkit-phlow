Class {
	#name : #GtPhlowTitleLabelNotifier,
	#superclass : #Object,
	#instVars : [
		'element',
		'builder'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowTitleLabelNotifier >> block: aBlock [
	builder := GtPhlowTitleLabelBuilder block: aBlock
]

{ #category : #'private - accessing' }
GtPhlowTitleLabelNotifier >> builder [
	<return: #GtPhlowTitleLabelBuilder>
	^ builder
]

{ #category : #'api - accessing' }
GtPhlowTitleLabelNotifier >> element [
	^ element
]

{ #category : #'api - accessing' }
GtPhlowTitleLabelNotifier >> element: anObject [
	element := anObject
]

{ #category : #initialization }
GtPhlowTitleLabelNotifier >> initialize [
	super initialize.
	builder := GtPhlowTitleLabelBuilder null.
]

{ #category : #'api - notifying' }
GtPhlowTitleLabelNotifier >> notify [
	| aLabel |
	self builder hasLabel ifFalse: [ ^ self ].
	aLabel := self titleLabel.
	self element fireEvent: (GtPhlowChangeTitleLabelWish new label: aLabel)
]

{ #category : #'api - notifying' }
GtPhlowTitleLabelNotifier >> notifyIfFocused [
	self element focused ifFalse: [ ^ self ].
	self notify.
]

{ #category : #'private - building' }
GtPhlowTitleLabelNotifier >> titleLabel [
	<return: #BlText>
	^ self builder build
]

{ #category : #'api - accessing' }
GtPhlowTitleLabelNotifier >> toolName: aToolName subjectName: aSubjectName [
	builder := GtPhlowTitleLabelBuilder
		toolName: aToolName
		subjectName: aSubjectName
]
