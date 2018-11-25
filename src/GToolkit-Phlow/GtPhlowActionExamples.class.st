"
!Phlow actions
"
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

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIconAndLabel [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtDropdownWithIconAndLabelAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #dropdownWithIconAndLabelActionFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrDropdown).
	"self assert: aButton label asString equals: 'Edit'.
	self assert: aButton icon background image equals: BrGlamorousIcons edit."
	^ aButton
]

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIconAndLabelActionFor: anAction [
	<gtDropdownWithIconAndLabelAction>
	^ anAction dropdown
		icon: BrGlamorousIcons menu;
		label: 'Check me :-)';
		popup: [ BlElement new background: Color lightBrown; size: 200@300 ]
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

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithIcon [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtToggleWithIconAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #toggleWithIconActionFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated not.
	self assert: aButton icon background image equals: BrGlamorousIcons refresh.
	^ aButton
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithIconActionFor: anAction [
	<gtToggleWithIconAction>
	^ anAction toggle
		icon: BrGlamorousIcons refresh;
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ]
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithIconAndLabelActivated [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtToggleWithIconAndLabelActivatedAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #toggleWithIconAndLabelActivatedActionFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated.
	self assert: aButton label asString equals: 'Circle'.
	self assert: aButton icon background image equals: BrGlamorousIcons graycircle.
	^ aButton
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithIconAndLabelActivatedActionFor: anAction [
	<gtToggleWithIconAndLabelActivatedAction>
	^ anAction toggle
		isActivated: [ true ];
		icon: BrGlamorousIcons graycircle;
		label: 'Circle';
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ]
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithIconAndLabelDeactivated [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtToggleWithIconAndLabelDeactivatedAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #toggleWithIconAndLabelDeactivatedActionFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated not.
	self assert: aButton label asString equals: 'Circle'.
	self assert: aButton icon background image equals: BrGlamorousIcons graycircle.
	^ aButton
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithIconAndLabelDeactivatedActionFor: anAction [
	<gtToggleWithIconAndLabelDeactivatedAction>
	^ anAction toggle
		isActivated: [ false ];
		icon: BrGlamorousIcons graycircle;
		label: 'Circle';
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ]
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithLabel [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtToggleWithLabelAction.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #toggleWithLabelActionFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated not.
	self assert: aButton label asString equals: 'Click here'.
	^ aButton
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithLabelActionFor: anAction [
	<gtToggleWithLabelAction>
	^ anAction toggle
		label: 'Click here';
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ]
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithNoConfiguration [
	<gtExample>
	| anActions aButton |
	anActions := self collectActions: #gtToggleWithNoConfiguration.
	self assert: anActions size equals: 1.
	self assert: anActions anyOne definingMethod selector equals: #toggleWithNoConfigurationFor:.
	aButton := anActions anyOne asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated not.
	^ aButton
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithNoConfigurationFor: anAction [
	<gtToggleWithNoConfiguration>
	^ anAction toggle
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ]
]
