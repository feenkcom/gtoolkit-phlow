"
I exemplify {{gtClass:GtPhlowCellElement}}.   


"
Class {
	#name : #GtPhlowCellElementExamples,
	#superclass : #Object,
	#category : 'GToolkit-Phlow-Examples'
}

{ #category : #'examples - cell element' }
GtPhlowCellElementExamples >> basicCellElement [
	<gtExample>
	| aCell |
	aCell := GtPhlowCellElement new.
	^ aCell
]

{ #category : #accessing }
GtPhlowCellElementExamples >> cellElementWithException [
	<gtExample>
	| aCell anException |
	aCell := self basicCellElement.
	anException := self exceptionElement.
	aCell exception: anException.
	self assert: aCell content equals: nil.
	self assert: aCell exception equals: anException.
	self assert: aCell childrenCount equals: 1.
	self assert: (aCell childAt: 1) visibility isVisible.
	^ aCell
]

{ #category : #accessing }
GtPhlowCellElementExamples >> cellElementWithExceptionAndThenLabel [
	<gtExample>
	| aCell aLabel |
	aCell := self cellElementWithException.
	aLabel := self labelElement.
	aCell content: aLabel.
	self assert: aCell content equals: aLabel.
	self assert: aCell exception equals: nil.
	self assert: aCell childrenCount equals: 1.
	self assert: (aCell childAt: 1) visibility isVisible.
	^ aCell
]

{ #category : #accessing }
GtPhlowCellElementExamples >> cellElementWithExceptionAndThenLabelAndThenException [
	<gtExample>
	| aCell anException |
	aCell := self cellElementWithExceptionAndThenLabel.
	anException := self exceptionElement.
	aCell exception: anException.
	self assert: aCell content isNotNil.
	self assert: aCell exception equals: anException.
	self assert: aCell childrenCount equals: 2.
	self assert: (aCell childAt: 1) visibility isGone.
	self assert: (aCell childAt: 2) visibility isVisible.
	^ aCell
]

{ #category : #'examples - cell element' }
GtPhlowCellElementExamples >> cellElementWithLabel [
	<gtExample>
	| aCell aLabel |
	aCell := self basicCellElement.
	aLabel := self labelElement.
	aCell content: aLabel.
	self assert: aCell content equals: aLabel.
	self assert: aCell childrenCount equals: 1.
	^ aCell
]

{ #category : #accessing }
GtPhlowCellElementExamples >> cellElementWithLabelAndThenException [
	<gtExample>
	| aCell anException |
	aCell := self cellElementWithLabel.
	anException := self exceptionElement.
	aCell exception: anException.
	self assert: aCell content isNotNil.
	self assert: aCell exception equals: anException.
	self assert: aCell childrenCount equals: 2.
	self assert: (aCell childAt: 1) visibility isGone.
	self assert: (aCell childAt: 2) visibility isVisible.
	^ aCell
]

{ #category : #accessing }
GtPhlowCellElementExamples >> cellElementWithLabelAndThenExceptionThenLabel [
	<gtExample>
	| aCell aLabel |
	aCell := self cellElementWithLabelAndThenException.
	aLabel := self labelElement.
	aCell content: aLabel.
	self assert: aCell content equals: aLabel.
	self assert: aCell exception equals: nil.
	self assert: aCell childrenCount equals: 1.
	self assert: (aCell childAt: 1) visibility isVisible.
	^ aCell
]

{ #category : #'examples - content elements' }
GtPhlowCellElementExamples >> exceptionElement [
	<gtExample>
	| anElement |
	anElement := [ ZeroDivide signal: 'Exception example' ] on: ZeroDivide do: [ :anException | anException asDebuggableElement hMatchParent; vFitContent ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement
]

{ #category : #'examples - content elements' }
GtPhlowCellElementExamples >> labelElement [
	<gtExample>
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: 'item one';
		fitContent
]
