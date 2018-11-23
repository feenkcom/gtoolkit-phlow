Class {
	#name : #GtPhlowActionExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #button }
GtPhlowActionExamples >> buttonWithIcon [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtButtonWithIconAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #buttonWithIconActionFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton icon background image equals: BrGlamorousIcons refresh.
	^ aButton 
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithIconActionFor: anAction [
	<gtButtonWithIconAction>
	^ anAction button
		icon: BrGlamorousIcons refresh;
		action: [ :aBrButton | self inform: 'Click!' ]
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithIconAndLabel [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtButtonWithIconAndLabelAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #buttonWithIconAndLabelActionFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Edit'.
	self assert: aButton icon background image equals: BrGlamorousIcons edit.
	^ aButton
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithIconAndLabelActionFor: anAction [
	<gtButtonWithIconAndLabelAction>
	^ anAction button
		icon: BrGlamorousIcons edit;
		label: 'Edit';
		action: [ :aBrButton | self inform: 'Click!' ]
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithLabel [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtButtonWithLabelAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #buttonWithLabelActionFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Refresh'.
	^ aButton
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithLabelActionFor: anAction [
	<gtButtonWithLabelAction>
	^ anAction button
		label: 'Refresh';
		action: [ :aBrButton | self inform: 'Click!' ]
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithNoConfiguration [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtButtonWithNoConfigurationAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #buttonWithNoConfigurationFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrButton).
	^ aButton 
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithNoConfigurationFor: anAction [
	<gtButtonWithNoConfigurationAction>
	^ anAction button
]

{ #category : #utility }
GtPhlowActionExamples >> collectActions: aSymbol [
	^ GtPhlowActionsCollector new
		pragmaName: aSymbol;
		fromObject: self;
		collect
]

{ #category : #error }
GtPhlowActionExamples >> errorActionFor: anAction [
	<gtAction>
	<gtErrorAction>
	1 / 0
]

{ #category : #error }
GtPhlowActionExamples >> errorExample [
	<gtExample>
	| anActions aDebugButton |
	anActions := self collectActions: #gtErrorAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #errorActionFor:.
	aDebugButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aDebugButton isKindOf: BrButton).
	self assert: aDebugButton label asString equals: 'Error'.
	^ aDebugButton
]
