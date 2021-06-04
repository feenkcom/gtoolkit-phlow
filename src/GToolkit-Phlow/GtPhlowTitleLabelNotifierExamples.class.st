"
I examplify {{gtClass:GtPhlowTitleLabelNotifier}}.


"
Class {
	#name : #GtPhlowTitleLabelNotifierExamples,
	#superclass : #GtPhlowTitleNotifierExamples,
	#category : #'GToolkit-Phlow-Tool - Title Examples'
}

{ #category : #'examples - notifier' }
GtPhlowTitleLabelNotifierExamples >> basicNotifier [
	<gtExample>
	| aNotifier |
	aNotifier := GtPhlowTitleLabelNotifier new.
	self assert: aNotifier labelBuilder equals: GtPhlowTitleLabelBuilder null.
	^ aNotifier
]

{ #category : #'examples - notifier' }
GtPhlowTitleLabelNotifierExamples >> notifierWithLongLabel [
	<gtExample>
	| aNotifier aLabel |
	aNotifier := self basicNotifier.
	aNotifier longLabel: 'Very loooooooooooooooooooooooooooooooooooooooong title'.

	aLabel := self element.
	aLabel addEventHandler: aNotifier.

	aNotifier notify.
	
	self assert: aLabel label asString equals: 'Very loooooo...ooooong title'.
	self assert: aLabel icon asElement size equals: 0@0.
	
	^ aNotifier
]

{ #category : #'examples - notifier' }
GtPhlowTitleLabelNotifierExamples >> notifierWithShortLabel [
	<gtExample>
	| aNotifier aLabel |
	aNotifier := self basicNotifier.
	aNotifier shortLabel: 'Short title'.

	aLabel := self element.
	aLabel addEventHandler: aNotifier.

	aNotifier notify.
	
	self assert: aLabel label asString equals: 'Short title'.
	self assert: aLabel icon asElement size equals: 0@0.
	
	^ aNotifier
]
