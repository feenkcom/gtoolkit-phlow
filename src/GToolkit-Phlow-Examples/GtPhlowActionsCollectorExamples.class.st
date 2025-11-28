Class {
	#name : #GtPhlowActionsCollectorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Core'
}

{ #category : #button }
GtPhlowActionsCollectorExamples >> buttonWithIcon [
	<gtExample>
	| anAction aButton |
	anAction := self collectOneActionForPragma: #gtButtonWithIconAction.
	self assert: anAction definingMethod selector equals: #buttonWithIconActionFor:.
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: (aButton icon isKindOf: BlElement).
	self assert: (aButton icon geometry isKindOf: BlSvgPath).
	self
		assert: (aButton icon geometry instVarNamed: #segments) size
		equals: (BrGlamorousVectorIcons refresh asElement geometry instVarNamed: #segments) size.
	^ anAction
]

{ #category : #button }
GtPhlowActionsCollectorExamples >> buttonWithIconActionFor: anAction [
	<gtButtonWithIconAction>
	^ anAction button
		icon: BrGlamorousVectorIcons refresh;
		action: [ :aBrButton | self inform: 'Click!' ]
]

{ #category : #utility }
GtPhlowActionsCollectorExamples >> collectActions: aSymbol [
	^ GtPhlowActionsCollector new
		pragmaName: aSymbol;
		fromObject: self;
		collect
]

{ #category : #utility }
GtPhlowActionsCollectorExamples >> collectOneActionForPragma: aSymbol [
	| actions |
	actions := self collectActions: aSymbol.
	self assert: actions size = 1.
	^ actions anyOne
]

{ #category : #error }
GtPhlowActionsCollectorExamples >> errorActionFor: anAction [
	<gtAction>
	<gtErrorAction>
	1 / 0
]

{ #category : #error }
GtPhlowActionsCollectorExamples >> errorExample [
	<gtExample>
	| anAction aDebugButton |
	anAction := self collectOneActionForPragma: #gtErrorAction.
	self assert: anAction definingMethod selector equals: #errorActionFor:.
	aDebugButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aDebugButton isKindOf: BrButton).
	self assert: aDebugButton label asString equals: 'Error'.
	^ anAction
]

{ #category : #error }
GtPhlowActionsCollectorExamples >> noReturnedActionExample [
	<gtExample>
	| anAction aDebugButton |
	anAction := self collectOneActionForPragma: #noReturnedAction.
	self assert: anAction definingMethod selector equals: #noReturnedActionFor:.
	self assert: anAction exception class equals: GtPhlowActionNotProvidedError.
	aDebugButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aDebugButton isKindOf: BrButton).
	self assert: aDebugButton label asString equals: 'Error'.
	^ anAction
]

{ #category : #error }
GtPhlowActionsCollectorExamples >> noReturnedActionFor: anAction [
	<gtAction>
	<noReturnedAction>
	^ self
]
