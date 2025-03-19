"
1. Phlow actions

Any {{gtClass:GtPhlowView}} can be associated a set of {{gtClass:GtPhlowAction}} that are applicable. 

Often these actions are defined as an extension method discovered through a pragma. See {{gtClass:GtPhlowActionsCollectorExamples}}.

1. # Explicit widgets


The most basic action is the one that can be explicitly specified. For example, below we see the explict creation of a button widget.

{{gtExample:GtPhlowActionExamples>>#explicitAction|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}}


1. # Buttons


Buttons are the most used actions. Thus, there is a higher level action that allows you to do just that without creating explicit button widgets.

{{gtExample:GtPhlowActionExamples>>#buttonWithIcon|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}}

A button can have both an icon and a label.

{{gtExample:GtPhlowActionExamples>>#buttonWithIconAndLabel|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}}


1. # Toggles


Another form of buttons are toggles.

{{gtExample:GtPhlowActionExamples>>#toggleWithIconAndLabelDeactivated|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}}


1. # Dropdowns 


Dropdowns can also be defined.

{{gtExample:GtPhlowActionExamples>>#dropdownWithIconAndLabel|previewExpanded|previewShow=#gtLiveFor:|previewHeight=50}}


"
Class {
	#name : #GtPhlowActionExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Core'
}

{ #category : #button }
GtPhlowActionExamples >> buttonWithIcon [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction button
		icon: BrGlamorousIcons edit;
		action: [ :aBrButton | self inform: 'Click!' ].
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton icon background image equals: BrGlamorousIcons edit.
	self assert: aButton aptitude class equals: BrGlamorousButtonWithIconAptitude.
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
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Edit'.
	self assert: aButton icon background image equals: BrGlamorousIcons edit.
	self assert: aButton aptitude class equals: BrGlamorousButtonWithIconAndLabelAptitude.
	^ anAction
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithIconAndLabelAndTooltip [
	<gtExample>
	| anAction aButton |
	anAction := self buttonWithIconAndLabel.
	anAction tooltip: 'I am a tooltip'.
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: (aButton aptitude children anySatisfy: [ :e | e class = GtPhlowLabelTooltipAptitude ]).
	^ anAction
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithIconAndTooltip [
	<gtExample>
	| anAction aButton |
	anAction := self buttonWithIcon.
	anAction tooltip: 'I am tooltip'.
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: (aButton aptitude children anySatisfy: [ :e | e class = GtPhlowLabelTooltipAptitude ]).
	^ anAction
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithLabel [
	<gtExample>
	| aButton anAction |
	anAction := GtPhlowAction noAction button
		label: 'Refresh';
		action: [ :aBrButton | self inform: 'Click!' ].
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Refresh'.
	self assert: aButton aptitude class equals: BrGlamorousButtonWithLabelAptitude.
	^ anAction
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithLabelWithTooltip [
	<gtExample>
	| aButton anAction |
	anAction := self buttonWithLabel.
	anAction tooltip: 'I am tooltip'.
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: (aButton aptitude children anySatisfy: [ :e | e class = GtPhlowLabelTooltipAptitude ]).
	^ anAction
]

{ #category : #button }
GtPhlowActionExamples >> buttonWithNoConfiguration [
	<gtExample>
	| aButton anAction |
	anAction := GtPhlowAction noAction button.
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton aptitude class equals: BrGlamorousButtonWithIconAptitude.
	self assert: (aButton aptitude children allSatisfy: [ :e | e class ~= GtPhlowLabelTooltipAptitude ]).
	^ anAction 
]

{ #category : #priority }
GtPhlowActionExamples >> comparePriority [
	<gtExample>
	| anAction |
	anAction := self setPriority.
	self assert: anAction priority < self defaultPriority priority.
	^ anAction
]

{ #category : #priority }
GtPhlowActionExamples >> defaultPriority [
	<gtExample>
	| anAction |
	anAction := self buttonWithIcon.
	self assert: anAction priority isNumber.
	^ anAction
]

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIcon [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction dropdown
		icon: BrGlamorousIcons menu;
		content: [ :theButton :aHostElemetn |
			 BlElement new
				background: Color lightBrown;
				size: 200 @ 300 ].
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton icon background image equals: BrGlamorousIcons menu.
	self assert: (aButton aptitude hasActor: BrGlamorousButtonWithIconAptitude).
	^ anAction
]

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIconAndLabel [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction dropdown
		icon: BrGlamorousIcons menu;
		label: 'Check me :-)';
		content: [ BlElement new
				background: Color lightBrown;
				size: 200 @ 300 ].
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Check me :-)'.
	self assert: aButton icon background image equals: BrGlamorousIcons menu.
	self
		assert: (aButton aptitude hasActor: BrGlamorousButtonWithIconAndLabelAptitude).
	^ anAction
]

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIconAndLabelAndIndicator [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction dropdown
		icon: BrGlamorousIcons add;
		label: 'Add item';
		withDropdownIndicator;
		content: [ BlElement new
				background: Color lightBrown;
				size: 200 @ 300 ].
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Add item'.
	self assert: aButton icon background image equals: BrGlamorousIcons add.
	self
		assert: (aButton aptitude hasActor: BrGlamorousButtonWithIconAndLabelAptitude).
	self
		assert: (aButton aptitude hasActor: BrGlamorousButtonIconDropdownAptitude).
	self assert: (aButton childWithId: #iconDropdown) isNotNil.
	^ anAction
]

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIconAndLabelAndMenuItems [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction dropdown
		icon: BrGlamorousIcons menu;
		label: 'Check me :-)';
		items: [ :theButton :aHostElement :aMenuItems |
			aMenuItems 
				addItemLabel: 'Spawn dropdown button' 
				action: [ :anotherButton |
					anotherButton phlow spawnObject: theButton ].
			aMenuItems
				addItemLabel: 'Spawn host element' 
				preview: aHostElement gtDisplayString
				action: [ :anotherButton |
					anotherButton phlow spawnObject: aHostElement ].
			aMenuItems
				addItemLabel: 'Spawn menu items model' 
				preview: aMenuItems gtDisplayString
				action: [ :anotherButton |
					anotherButton phlow spawnObject: aMenuItems ].
			aMenuItems 
				addItemLabel: 'Spawn menu item button' 
				preview: theButton gtDisplayString
				action: [ :anotherButton |
					anotherButton phlow spawnObject: anotherButton ].
		 ].
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Check me :-)'.
	self assert: aButton icon background image equals: BrGlamorousIcons menu.
	self
		assert: (aButton aptitude hasActor: BrGlamorousButtonWithIconAndLabelAptitude).
	^ anAction
]

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIconAndLabelAndMenuModel [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction dropdown
		icon: BrGlamorousIcons menu;
		label: 'Check me :-)';
		menu: [ :theButton :aHostElement | BrMenuExamples new menuItems ].
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Check me :-)'.
	self assert: aButton icon background image equals: BrGlamorousIcons menu.
	self
		assert: (aButton aptitude hasActor: BrGlamorousButtonWithIconAndLabelAptitude).
	^ anAction
]

{ #category : #dropdown }
GtPhlowActionExamples >> dropdownWithIconAndLabelAndResizer [
	<gtExample>
	| anAction aButton |
	anAction := GtPhlowAction noAction dropdown
		icon: BrGlamorousIcons menu;
		label: 'Check me :-)';
		withoutDropdownIndicator;
		content: [ BlElement new
				background: Color lightBrown;
				size: 200 @ 300 ];
		whenResizedDo: [ :anEvent | 
			NonInteractiveTranscript stdout show: anEvent resizeTarget.
			anEvent resizeTarget ifNotNil: [ :anElement |
				anElement background: Color random ] ].
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrButton).
	self assert: aButton label asString equals: 'Check me :-)'.
	self assert: aButton icon background image equals: BrGlamorousIcons menu.
	self
		assert: (aButton aptitude hasActor: BrGlamorousButtonWithIconAndLabelAptitude).
	self
		assert: (aButton aptitude hasActor: BrGlamorousButtonIconDropdownAptitude) not.
	self assert: (aButton childWithId: #iconDropdown ifFound: [ :e | false ] ifNone: [ true ] ).
	^ anAction
]

{ #category : #explicit }
GtPhlowActionExamples >> explicitAction [
	<gtExample>
	| anAction |
	anAction := GtPhlowAction noAction explicit stencil: [
		BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude; 
			action:  [ self inform: 'Explicit' ];
			icon: BrGlamorousIcons edit asElement;
			label: 'Edit' translated ].
	^ anAction
]

{ #category : #'reused actions' }
GtPhlowActionExamples >> levelOneAction [
	<gtExample>
	| anActions |
	anActions := GtPhlowActionsCollector new
		pragmaName: #gtLevelOneAction;
		fromObject: self;
		collect.
	self assert: anActions size equals: 1.
	self assert: anActions first definingMethod selector equals: #levelOneActionFor:.
	self assert: anActions first class equals: GtPhlowButtonAction.
	^ anActions first
]

{ #category : #'reused actions' }
GtPhlowActionExamples >> levelOneActionFor: anAction [
	<gtAction>
	<gtLevelOneAction>
	^ anAction button
		label: 'Level One'
]

{ #category : #'reused actions' }
GtPhlowActionExamples >> levelTwoAction [
	<gtExample>
	| anActions |
	anActions := GtPhlowActionsCollector new
		pragmaName: #gtLevelTwoAction;
		fromObject: self;
		collect.
	self assert: anActions size equals: 1.
	self assert: anActions first definingMethod class equals: GtPhlowDefiningMethods.
	self assert: anActions first definingMethod methods size equals: 2.
	self assert: anActions first definingMethod methods first selector equals: #levelTwoActionFor:.
	self assert: anActions first definingMethod methods second selector equals: #levelOneActionFor:.
	^ anActions first
]

{ #category : #'reused actions' }
GtPhlowActionExamples >> levelTwoActionFor: anAction [
	<gtAction>
	<gtLevelTwoAction>
	^ (self levelOneActionFor: anAction)
		label: 'Level Two'
]

{ #category : #'reused actions' }
GtPhlowActionExamples >> myself [
	<gtExample>
	^ self
]

{ #category : #priority }
GtPhlowActionExamples >> setPriority [
	<gtExample>
	| anAction |
	anAction := self defaultPriority.
	anAction priority: 5.
	self assert: anAction priority equals: 5.
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
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
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
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
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
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
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
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
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
	aButton := anAction asElement: [ :x | x ] withHostElement: nil.
	self assert: (aButton isKindOf: BrToggle).
	self assert: aButton isActivated not.
	^ anAction
]
