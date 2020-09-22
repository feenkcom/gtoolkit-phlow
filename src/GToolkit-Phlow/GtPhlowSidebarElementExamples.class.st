"
I exemplify ${class:GtPhlowSidebarElement}$.

"
Class {
	#name : #GtPhlowSidebarElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Tool - Examples'
}

{ #category : #'examples - element' }
GtPhlowSidebarElementExamples >> basicSidebarElement [
	<gtExample>
	| anElement |
	anElement := GtPhlowSidebarElement new.

	self assert: anElement contentStencil isNotNil.
	"An empty content and resizer"
	self assert: anElement childrenCount equals: 2.

	^ anElement
]

{ #category : #'examples - element' }
GtPhlowSidebarElementExamples >> contentStencil [
	<gtExample>
	^ [ BrFrame new
			matchParent;
			background: (Color blue alpha: 0.1);
			addChild: (BrLabel new
				look: (BrGlamorousLabelLook new
					foreground: Color white);
				text: 'Content';
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ]) ] asStencil
]

{ #category : #'examples - element' }
GtPhlowSidebarElementExamples >> sidebarElement [
	<gtExample>
	| anElement aStencil aContentElement aResizerElement |
	anElement := GtPhlowSidebarElement new.
	aContentElement := anElement childAt: 1.
	aResizerElement := anElement childAt: 2.

	aStencil := self contentStencil.
	anElement contentStencil: aStencil.

	self assert: anElement contentStencil equals: aStencil.
	"A content and resizer"
	self assert: anElement childrenCount equals: 2.
	self assert: (anElement childAt: 1) ~= aContentElement.
	self assert: (anElement childAt: 2) equals: aResizerElement.

	^ anElement
]
