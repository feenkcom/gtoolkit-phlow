"
I exemplify {{gtClass:GtPhlowUpdateView}}.


"
Class {
	#name : #GtPhlowUpdateViewExamples,
	#superclass : #GtPhlowUpdateCommandExamples,
	#category : 'GToolkit-Phlow-Examples'
}

{ #category : #'examples - commands' }
GtPhlowUpdateViewExamples >> basicCommand [
	<gtExample>
	| aCommand anElement |
	aCommand := self emptyCommand.
	anElement := self explicitElement.
	aCommand elementContext: anElement phlow.
	self assert: aCommand elementContext equals: anElement phlow.
	^ aCommand
]

{ #category : #'examples - comparison' }
GtPhlowUpdateViewExamples >> differentEntryIdentifiers [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self basicCommand.
	self assert: aCommandOne entryIdentifier ~= aCommandTwo entryIdentifier.
	^ aCommandOne
]

{ #category : #'examples - commands' }
GtPhlowUpdateViewExamples >> emptyCommand [
	<gtExample>
	| aCommand |
	aCommand := GtPhlowUpdateCommand new.
	self assert: aCommand elementContext isNil.
	^ aCommand
]

{ #category : #'examples - comparison' }
GtPhlowUpdateViewExamples >> sameEntryIdentifiers [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self emptyCommand.
	aCommandTwo elementContext: aCommandOne elementContext.
	self assert: aCommandOne entryIdentifier equals: aCommandTwo entryIdentifier.
	^ aCommandOne
]
