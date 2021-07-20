"
I exemplify {{gtClass:GtPhlowUpdateCompositeSubViewTitleAndPosition}}.


"
Class {
	#name : 'GtPhlowUpdateCompositeSubViewTitleAndPositionExamples',
	#superclass : 'GtPhlowUpdateCommandExamples',
	#category : 'GToolkit-Phlow-Examples'
}

{ #category : 'examples - commands' }
GtPhlowUpdateCompositeSubViewTitleAndPositionExamples >> basicCommand [
	<gtExample>
	| aCommand anElement |
	aCommand := self emptyCommand.
	anElement := self compositeElement.
	aCommand elementContext: anElement phlow.
	aCommand subView: anElement phlow entity views first.
	self assert: aCommand elementContext equals: anElement phlow.
	self assert: aCommand subView equals: anElement phlow entity views first.
	^ aCommand
]

{ #category : 'examples - comparison' }
GtPhlowUpdateCompositeSubViewTitleAndPositionExamples >> differentEntryIdentifiers [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self basicCommand.
	self assert: aCommandOne entryIdentifier ~= aCommandTwo entryIdentifier.
	^ aCommandOne
]

{ #category : 'examples - comparison' }
GtPhlowUpdateCompositeSubViewTitleAndPositionExamples >> differentEntryIdentifiers_SameContext_DifferentSubView [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self emptyCommand.
	aCommandTwo elementContext: aCommandOne elementContext.
	aCommandTwo subView: self compositeView views second.
	self assert: aCommandOne entryIdentifier ~= aCommandTwo entryIdentifier.
	^ aCommandOne
]

{ #category : 'examples - commands' }
GtPhlowUpdateCompositeSubViewTitleAndPositionExamples >> emptyCommand [
	<gtExample>
	| aCommand |
	aCommand := GtPhlowUpdateCompositeSubViewTitleAndPosition new.
	self assert: aCommand elementContext isNil.
	self assert: aCommand subView isNil.
	^ aCommand
]

{ #category : 'examples - comparison' }
GtPhlowUpdateCompositeSubViewTitleAndPositionExamples >> sameEntryIdentifiers [
	<gtExample>
	| aCommandOne aCommandTwo |
	aCommandOne := self basicCommand.
	aCommandTwo := self emptyCommand.
	aCommandTwo elementContext: aCommandOne elementContext.
	aCommandTwo subView: self compositeView views first.
	self assert: aCommandOne entryIdentifier equals: aCommandTwo entryIdentifier.
	^ aCommandOne
]
