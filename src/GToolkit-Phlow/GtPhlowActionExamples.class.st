"
!Phlow actions

Any ${class:GtPhlowView}$ can be associated a set of ${class:GtPhlowAction}$ that are applicable. 

Often these actions are defined as an extension method discovered through a pragma. See ${class:GtPhlowActionsCollectorExamples}$.

!!Explicit widgets

The most basic action is the one that can be explicitly specified. For example, below we see the explict creation of a button widget.

${example:GtPhlowActionExamples>>#explicitAction|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}$


!!Buttons

Buttons are the most used actions. Thus, there is a higher level action that allows you to do just that without creating explicit button widgets.

${example:GtPhlowActionExamples>>#buttonWithIcon|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}$

A button can have both an icon and a label.

${example:GtPhlowActionExamples>>#buttonWithIconAndLabel|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}$


!!Toggles

Another form of buttons are toggles.

${example:GtPhlowActionExamples>>#toggleWithIconAndLabelDeactivated|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}$


!!Dropdowns 

Dropdowns can also be defined.

${example:GtPhlowActionExamples>>#dropdownWithIconAndLabel|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}$


"
Class {
	#name : #GtPhlowActionExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #button }
GtPhlowActionExamples >> buttonWithIcon [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction button
		icon: BrGlamorousIcons edit;
		action: [ :aBrButton | self inform: 'Click!' ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton icon background image equals: BrGlamorousIcons edit.
	^ anAction
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithIconAndLabel [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction button
		icon: BrGlamorousIcons edit;
		label: 'Edit';
		action: [ :aBrButton | self inform: 'Click!' ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Edit'.
	self assert: aButton icon background image equals: BrGlamorousIcons edit.
	^ anAction
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithLabel [
	<gtExample>
	| aButton anAction |
	anAction := GtPhlowAction noAction button
		label: 'Refresh';
		action: [ :aBrButton | self inform: 'Click!' ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Refresh'.
	^ anAction
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithNoConfiguration [
	<gtExample>
	| aButton anAction |
	anAction := GtPhlowAction noAction button.
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrButton).
	^ anAction 
]

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIcon [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction dropdown
		icon: BrGlamorousIcons menu;
		popup: [ BlElement new background: Color lightBrown; size: 200@300 ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrDropdown).
	"self assert: aButton label asString equals: 'Edit'.
	self assert: aButton icon background image equals: BrGlamorousIcons edit."
	^ anAction
]

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIconAndLabel [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction dropdown
		icon: BrGlamorousIcons menu;
		label: 'Check me :-)';
		popup: [ BlElement new background: Color lightBrown; size: 200@300 ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrDropdown).
	"self assert: aButton label asString equals: 'Edit'.
	self assert: aButton icon background image equals: BrGlamorousIcons edit."
	^ aButton
]

{ #category : #explicit }
GtPhlowActionExamples >> explicitAction [
	<gtExample>
	| anAction |
	anAction := GtPhlowAction noAction explicit stencil: [
		BrButton new
			look: BrGlamorousButtonWithIconLook; 
			action:  [ self inform: 'Explicit' ];
			icon: BrGlamorousIcons edit asElement;
			label: 'Edit' translated ].
	^ anAction
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithIcon [
	<gtExample>
	| aButton anAction |
	anAction := GtPhlowAction noAction toggle
		icon: BrGlamorousIcons refresh;
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated not.
	self assert: aButton icon background image equals: BrGlamorousIcons refresh.
	^ anAction
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithIconAndLabelActivated [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction  toggle
		isActivated: [ true ];
		icon: BrGlamorousIcons graycircle;
		label: 'Circle';
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated.
	self assert: aButton label asString equals: 'Circle'.
	self assert: aButton icon background image equals: BrGlamorousIcons graycircle.
	^ anAction
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithIconAndLabelDeactivated [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction toggle
		isActivated: [ false ];
		icon: BrGlamorousIcons graycircle;
		label: 'Circle';
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated not.
	self assert: aButton label asString equals: 'Circle'.
	self assert: aButton icon background image equals: BrGlamorousIcons graycircle.
	^ anAction
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithLabel [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction toggle
		label: 'Click here';
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated not.
	self assert: aButton label asString equals: 'Click here'.
	^ anAction
]

{ #category : #toggle }
GtPhlowActionExamples >> toggleWithNoConfiguration [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction toggle
		activatedAction: [ :aBrButton | self inform: 'Switched on!' ];
		deactivatedAction: [ :aBrButton | self inform: 'Switched off!' ].
	aButton := anAction asElementDo: [ :x | x ] withElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated not.
	^ anAction
]
