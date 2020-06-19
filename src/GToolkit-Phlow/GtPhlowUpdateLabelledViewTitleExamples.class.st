"
I exemplify ${class:GtPhlowUpdateLabelledViewTitle}$.

"
Class {
	#name : #GtPhlowUpdateLabelledViewTitleExamples,
	#superclass : #GtPhlowUpdateCommandExamples,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'examples - commands' }
GtPhlowUpdateLabelledViewTitleExamples >> basicCommand [
	<gtExample>
	| aCommand anElement |
	aCommand := self emptyCommand.
	anElement := self explicitElement.
	aCommand elementContext: anElement phlow.
	self assert: aCommand elementContext equals: anElement phlow.
	^ aCommand
]

{ #category : #'examples - comparison' }
GtPhlowUpdateLabelledViewTitleExamples >> differentEntryIdentifiers [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self basicCommand.
	self assert: aCommandOne entryIdentifier ~= aCommandTwo entryIdentifier.
	^ aCommandOne
]

{ #category : #'examples - commands' }
GtPhlowUpdateLabelledViewTitleExamples >> emptyCommand [
	<gtExample>
	| aCommand |
	aCommand := GtPhlowUpdateLabelledViewTitle new.
	self assert: aCommand elementContext isNil.
	^ aCommand
]

{ #category : #'examples - comparison' }
GtPhlowUpdateLabelledViewTitleExamples >> sameEntryIdentifiers [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self emptyCommand.
	aCommandTwo elementContext: aCommandOne elementContext.
	self assert: aCommandOne entryIdentifier equals: aCommandTwo entryIdentifier.
	^ aCommandOne
]
