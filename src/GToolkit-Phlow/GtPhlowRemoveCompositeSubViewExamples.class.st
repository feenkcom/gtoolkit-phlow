"
I exemplify {{gtClass:GtPhlowRemoveCompositeSubView}}.


"
Class {
	#name : #GtPhlowRemoveCompositeSubViewExamples,
	#superclass : #GtPhlowUpdateCommandExamples,
	#category : 'GToolkit-Phlow-Examples'
}

{ #category : #'examples - commands' }
GtPhlowRemoveCompositeSubViewExamples >> basicCommand [
	<gtExample>
	| aCommand anElement |
	aCommand := self emptyCommand.
	anElement := self explicitElement.
	aCommand elementContext: anElement phlow.
	aCommand compiledMethod: anElement phlow definingMethod compiledMethod.
	self assert: aCommand elementContext equals: anElement phlow.
	self assert: aCommand compiledMethod equals: anElement phlow definingMethod compiledMethod.
	self assert: aCommand ringDefinition compiledMethod equals: aCommand compiledMethod.
	^ aCommand
]

{ #category : #'examples - comparison' }
GtPhlowRemoveCompositeSubViewExamples >> differentEntryIdentifiers [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self basicCommand.
	self assert: aCommandOne entryIdentifier ~= aCommandTwo entryIdentifier.
	^ aCommandOne
]

{ #category : #'examples - comparison' }
GtPhlowRemoveCompositeSubViewExamples >> differentEntryIdentifiers_SameContext_DifferentMethods [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self basicCommand.
	aCommandTwo elementContext: aCommandOne elementContext.
	aCommandTwo compiledMethod: self compositeView definingMethod compiledMethod.
	self assert: aCommandOne entryIdentifier ~= aCommandTwo entryIdentifier.
	^ aCommandOne
]

{ #category : #'examples - commands' }
GtPhlowRemoveCompositeSubViewExamples >> emptyCommand [
	<gtExample>
	| aCommand |
	aCommand := GtPhlowRemoveCompositeSubView new.
	self assert: aCommand elementContext isNil.
	self assert: aCommand compiledMethod isNil.
	self assert: aCommand ringDefinition isNil.
	^ aCommand
]

{ #category : #'examples - comparison' }
GtPhlowRemoveCompositeSubViewExamples >> sameEntryIdentifiers [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self basicCommand.
	aCommandTwo elementContext: aCommandOne elementContext.
	self assert: aCommandOne entryIdentifier equals: aCommandTwo entryIdentifier.
	^ aCommandOne
]
