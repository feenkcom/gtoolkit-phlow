Class {
	#name : #GtPhlowButtonAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'icon',
		'label',
		'action',
		'name',
		'primaryModifierAction'
	],
	#category : #'GToolkit-Phlow-! Actions'
}

{ #category : #accessing }
GtPhlowButtonAction >> action: aValuable [
	action := aValuable
]

{ #category : #accessing }
GtPhlowButtonAction >> actionBlock [
	^ action
]

{ #category : #converting }
GtPhlowButtonAction >> asElement: aBlock withHostElement: aTargetElement [
	<return: #BrButton>
	| aButton |
	aButton := BrButton new.
	aButton aptitude: self newButtonLook.
	aButton phlow 
		beAction;
		entity: self.
	label ifNotNil: [ aButton label: label asRopedText ].
	icon ifNotNil: [ aButton icon: icon asElement ].
	id ifNotNil: [ aButton id: self id ].
	action ifNotNil: [ aButton action: [ :theButton :aButtonModel :anEvent | 
		action gtValueWithArgs: { theButton. aTargetElement. aButtonModel. anEvent } ] ].
	self attachPrimaryModifierActionFor: aButton hostElement: aTargetElement.
	self attachTooltipFor: aButton hostElement: aTargetElement.
	self attachShowDefinitionEventHandler: aButton.
	self attachShowContextMenuEventHandler: aButton.
	^ aBlock value: aButton
]

{ #category : #converting }
GtPhlowButtonAction >> asMenuItem: aBlock withHostElement: aTargetElement [
	"Return a menu item that represents the action in BrMenuItems, e.g., action"

	<return: #BrMenuItem>
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	(label isNotNil and: [ icon isNotNil ])
		ifTrue: [ aMenuItem icon: icon label: label ]
		ifFalse: [ (label notNil and: [ icon isNil ])
				ifTrue: [ aMenuItem label: label ]
				ifFalse: [ aMenuItem icon: icon label: ''.
					self tooltipBuilder
						applyAsLabelOnMenuLabeledItem: aMenuItem
						hostElement: aTargetElement ] ].
	id ifNotNil: [ aMenuItem id: self id ].
	action
		ifNotNil: [ aMenuItem
				action: [ :theButton :aButtonModel :anEvent | 
					action
						gtValueWithArgs: {theButton.
								aTargetElement.
								aButtonModel.
								anEvent} ] ].

	self
		menuItemHideOnClickIfPresent: [ :aBoolean | aMenuItem hideOnClick: aBoolean ]
		ifAbsent: [  ].
		
	self
		menuItemGroupIfPresent: [ :aGroup | aMenuItem group: aGroup ]
		ifAbsent: [  ].

	^ aBlock value: aMenuItem
]

{ #category : #converting }
GtPhlowButtonAction >> attachPrimaryModifierActionFor: aButton hostElement: aTargetElement [ 
	| anAptitude |
	primaryModifierAction ifNil: [ ^ self ].
	anAptitude := GtPhlowPrimaryModifierClickAptitude new
		action: primaryModifierAction action;
		mouseCursor: primaryModifierAction mouseCursor;
		hostElement: aTargetElement.
	aButton addAptitude: anAptitude
]

{ #category : #'api - action' }
GtPhlowButtonAction >> debugBlock: aBlockClosure [
	"Takes as a parameter a block cloure that should only reference `self` or attributes of the receiver class"
	
	self 
		debugSource: aBlockClosure 
		receiver: aBlockClosure receiver
]

{ #category : #'api - action' }
GtPhlowButtonAction >> debugSource: aBlockClosureOrString receiver: anObject [
	"Takes as a parameter a block cloure or a string with the code to debug.
	The code should only reference `self` or attributes of the receiver class"
	
	self action: 
			[| compiledMethodToDebug targetSourceCode |
			targetSourceCode := aBlockClosureOrString isClosure
						ifTrue: [aBlockClosureOrString compiledBlock ast body formattedCode]
						ifFalse: [aBlockClosureOrString asString].
			compiledMethodToDebug := GtPharoCodeModifier current critical: 
							[(anObject class compiler)
								source: targetSourceCode;
								class: anObject class;
								context: nil;
								requestor: nil;
								isScripting: true;
								failBlock: nil;
								compile ].
			GtPharoSourceCoder
				debug: compiledMethodToDebug
				receiver: anObject
				in: nil
				coderEvaluationContext: nil]
]

{ #category : #accessing }
GtPhlowButtonAction >> icon: anIcon [
	icon := anIcon
]

{ #category : #accessing }
GtPhlowButtonAction >> iconStencil [
	^ icon
]

{ #category : #initialization }
GtPhlowButtonAction >> initialize [
	super initialize.

	action := [ :aButton :aTargetElement :aButtonModel :anEvent | "do nothing" ].
	primaryModifierAction := nil
]

{ #category : #'api - action' }
GtPhlowButtonAction >> label [
	^ label
]

{ #category : #accessing }
GtPhlowButtonAction >> label: aString [
	label := aString
]

{ #category : #accessing }
GtPhlowButtonAction >> name: aSymbol [
	self
		deprecated: 'Please use id: instead.'
		transformWith:
			'`@receiver name: `@statements1'
				-> '`@receiver id: `@statements1'.
				
	self id: aSymbol
]

{ #category : #'instance creation' }
GtPhlowButtonAction >> newButtonLook [
	(label isNotNil and: [ icon isNotNil ])
		ifTrue: [ ^ BrGlamorousButtonWithIconAndLabelAptitude ].
	(label notNil and: [ icon isNil ])
		ifTrue: [ ^ BrGlamorousButtonWithLabelAptitude ].
	^ BrGlamorousButtonWithIconAptitude
		- BrGlamorousButtonWithLabelTooltipAptitude2
]

{ #category : #'api - action' }
GtPhlowButtonAction >> performActionOn: anActionElement [
	action cull: anActionElement
]

{ #category : #accessing }
GtPhlowButtonAction >> primaryModifierAction: aValuable [
	self primaryModifierAction: aValuable mouseCursor: BlCopyCursor new
]

{ #category : #accessing }
GtPhlowButtonAction >> primaryModifierAction: aValuable mouseCursor: aBlCursorOrNil [
	primaryModifierAction := GtPhlowActionAct new
			action: aValuable;
			mouseCursor: aBlCursorOrNil
]
