"
I exemplify {{gtClass:GtPhlowTitleIconAndLabelNotifier}}.


"
Class {
	#name : 'GtPhlowTitleIconAndLabelNotifierExamples',
	#superclass : 'GtPhlowTitleNotifierExamples',
	#category : 'GToolkit-Phlow-Tool - Title Examples'
}

{ #category : 'examples - notifier' }
GtPhlowTitleIconAndLabelNotifierExamples >> basicNotifier [
	<gtExample>
	| aNotifier |
	aNotifier := GtPhlowTitleIconAndLabelNotifier new.
	self assert: aNotifier labelBuilder equals: GtPhlowTitleLabelBuilder null.
	self assert: aNotifier icon isNil.
	^ aNotifier
]

{ #category : 'examples - notifier' }
GtPhlowTitleIconAndLabelNotifierExamples >> notifier [
	<gtExample>
	| aNotifier |
	aNotifier := self basicNotifier.
	aNotifier icon: BrGlamorousIcons file.
	aNotifier shortLabel: 'Title'.
	^ aNotifier
]

{ #category : 'examples - notifier' }
GtPhlowTitleIconAndLabelNotifierExamples >> notifierWithLongLabel [
	<gtExample>
	| aNotifier aLabel |
	aNotifier := self basicNotifier.
	aNotifier longLabel: 'Very loooooooooooooooooooooooooooooooooooooooong title'.

	aLabel := self element.
	aLabel addEventHandler: aNotifier.

	aNotifier notify.
	
	self assert: aLabel label asString equals: 'Very loooooo...ooooong title'.
	
	^ aNotifier
]

{ #category : 'examples - notifier' }
GtPhlowTitleIconAndLabelNotifierExamples >> notifierWithLongLabelAndIcon [
	<gtExample>
	| aNotifier aLabel |
	aNotifier := self basicNotifier.
	aNotifier longLabel: 'Very loooooooooooooooooooooooooooooooooooooooong title'.
	aNotifier icon: BrGlamorousVectorIcons inspect.

	aLabel := self element.
	aLabel addEventHandler: aNotifier.

	aNotifier notify.
	
	self assert: aLabel label asString equals: 'Very loooooo...ooooong title'.
	
	^ aNotifier
]

{ #category : 'examples - notifier' }
GtPhlowTitleIconAndLabelNotifierExamples >> notifierWithShortLabel [
	<gtExample>
	| aNotifier aLabel |
	aNotifier := self basicNotifier.
	aNotifier shortLabel: 'Short title'.

	aLabel := self element.
	aLabel addEventHandler: aNotifier.

	aNotifier notify.
	
	self assert: aLabel label asString equals: 'Short title'.
	
	^ aNotifier
]

{ #category : 'examples - notifier' }
GtPhlowTitleIconAndLabelNotifierExamples >> notifierWithShortLabelAndIcon [
	<gtExample>
	| aNotifier aLabel |
	aNotifier := self basicNotifier.
	aNotifier shortLabel: 'Short title'.
	aNotifier icon: BrGlamorousVectorIcons inspect.

	aLabel := self element.
	aLabel addEventHandler: aNotifier.

	aNotifier notify.
	
	self assert: aLabel label asString equals: 'Short title'.
	
	^ aNotifier
]
