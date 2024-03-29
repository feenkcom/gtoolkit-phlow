"
I am {{gtClass:BlCustomEventHandler}}.
I am an abstract class.
I notify {{gtClass:BlElement}} parents that a label should be updated.
1. # Collaborators

I use {{gtClass:GtPhlowChangeTitleWish}} to notify parents.
I use {{gtClass:GtPhlowTitleLabelBuilder}} to create labels.
1. # Examples

See my {{gtClass:GtPhlowTitleNotifier|show=#gtSubclassesFor:|label=subclasses|expanded=true|height=130}} for specific examples:


"
Class {
	#name : #GtPhlowTitleNotifier,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'hasFocus',
		'element',
		'labelBuilder'
	],
	#category : 'GToolkit-Phlow-Tool - Title'
}

{ #category : #testing }
GtPhlowTitleNotifier class >> isAbstract [
	^ self name = #GtPhlowTitleNotifier 
]

{ #category : #'private - accessing' }
GtPhlowTitleNotifier >> element [
	<return: #BlElement>
	^ element
]

{ #category : #'api - accessing' }
GtPhlowTitleNotifier >> eventsToHandle [
	^ { BlFocusInEvent. BlFocusOutEvent }
]

{ #category : #'focus handlers' }
GtPhlowTitleNotifier >> focusInEvent: anEvent [
	hasFocus := true.
	self notify.
]

{ #category : #'focus handlers' }
GtPhlowTitleNotifier >> focusOutEvent: anEvent [
	hasFocus := false
]

{ #category : #'gt-extension' }
GtPhlowTitleNotifier >> gtLiveFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		object: [ self element ];
		view: #gtLiveFor:
]

{ #category : #'private - testing' }
GtPhlowTitleNotifier >> hasFocus [
	<return: #Boolean>
	^ hasFocus
]

{ #category : #initialization }
GtPhlowTitleNotifier >> initialize [
	super initialize.
	labelBuilder := GtPhlowTitleLabelBuilder null.
	hasFocus := false.
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
	self hasFocus ifFalse: [ ^ self ].
	self notify.
]

{ #category : #'api - hooks' }
GtPhlowTitleNotifier >> onInstalledIn: anObject [
	super onInstalledIn: anObject.
	element := anObject
]

{ #category : #'api - hooks' }
GtPhlowTitleNotifier >> onUninstalledIn: anObject [
	super onUninstalledIn: anObject.
	element := nil
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
