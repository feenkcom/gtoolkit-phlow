Class {
	#name : #GtPhlowTitleTabContentIconsAndLabelNotifierExamples,
	#superclass : #GtPhlowTitleNotifierExamples,
	#category : #'GToolkit-Phlow-Examples-Tool'
}

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> basicNotifier [
	<gtExample>
	| aNotifier |
	aNotifier := GtPhlowTitleToolContentIconsAndLabelNotifier new.
	self assert: aNotifier labelBuilder equals: GtPhlowTitleLabelBuilder null.
	self assert: aNotifier toolIcon isNil.
	self assert: aNotifier contentIcon isNil.
	^ aNotifier
]

{ #category : #'event handling' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> handleChangeTitleWish: aWish [
	aWish iconDo: [ :aStencil |
			aWish currentTarget icon: (aWish 
				buildElementWithToolIcon: aStencil) ].
			
	aWish labelDo: [ :aLabel | 
			aWish currentTarget label: aLabel ]
]

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithLongLabel [
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

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithLongLabelAndToolIcon [
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

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithOnlyContentIcon [
	<gtExample>
	| aNotifier |
	aNotifier := self basicNotifier.
	aNotifier contentIcon: BrGlamorousVectorIcons file.
	aNotifier shortLabel: 'Title'.
	^ aNotifier
]

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithOnlyContentIconUpdatesElement [
	<gtExample>
	| notifier element |
	notifier := self notifierWithOnlyContentIcon.
	
	element := self element.
	element addEventHandler: notifier.

	notifier notify.
	
	self assert: element label asString equals: 'Title'.
	self assert: element icon notNil.
	self assert: (element query // #toolIcon) result size equals: 1.
	self assert: (element query // #contentIcon) result size equals: 1.
	
	^ element
]

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithShortLabel [
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

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithShortLabelAndToolIcon [
	<gtExample>
	| notifier |
	notifier := self basicNotifier.
	notifier shortLabel: 'Short title'.
	notifier toolIcon: BrGlamorousVectorIcons inspect.
	^ notifier
]

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithShortLabelAndToolIconUpdatesElement [
	<gtExample>
	| notifier element |
	notifier := self notifierWithShortLabelAndToolIcon.

	element := self element.
	element addEventHandler: notifier.

	notifier notify.
	
	self assert: element label asString equals: 'Short title'.
	self assert: element icon notNil.
	self assert: (element query // #toolIcon) result size equals: 0.
	self assert: (element query // #contentIcon) result size equals: 0.
	
	^ element
]

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithShortLabelToolAndContentIcon [
	<gtExample>
	| notifier |
	notifier := self basicNotifier.
	notifier shortLabel: 'Short title'.
	notifier toolIcon: BrGlamorousVectorIcons inspect.
	notifier contentIcon: BrGlamorousVectorIcons eg.
	^ notifier
]

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithShortLabelToolAndContentIconUpdatesElement [
	<gtExample>
	| aNotifier element |
	aNotifier := self notifierWithShortLabelToolAndContentIcon.

	element := self element.
	element addEventHandler: aNotifier.

	aNotifier notify.
	
	self assert: element label asString equals: 'Short title'.
	self assert: element icon notNil.
	self assert: (element query // #toolIcon) result size equals: 1.
	self assert: (element query // #contentIcon) result size equals: 1.
	
	^ element
]

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithToolAndContentIcon [
	<gtExample>
	| aNotifier |
	aNotifier := self basicNotifier.
	aNotifier contentIcon: BrGlamorousVectorIcons file.
	aNotifier toolIcon: BrGlamorousVectorIcons eg.
	aNotifier shortLabel: 'Title'.
	^ aNotifier
]

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithToolIcon [
	<gtExample>
	| notifier |
	notifier := self basicNotifier.
	notifier icon: BrGlamorousVectorIcons file.
	notifier shortLabel: 'Title'.
	^ notifier
]

{ #category : #'examples - notifier' }
GtPhlowTitleTabContentIconsAndLabelNotifierExamples >> notifierWithToolIconUpdateElement [
	<gtExample>
	| notifier element |
	notifier := self notifierWithToolIcon.
	
	element := self element.
	element addEventHandler: notifier.

	notifier notify.
	
	self assert: element label asString equals: 'Title'.
	self assert: element icon notNil.
	self assert: (element query // #toolIcon) result size equals: 0.
	self assert: (element query // #contentIcon) result size equals: 0.
	
	^ element
]
