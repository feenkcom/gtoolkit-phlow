Class {
	#name : #GtPhlowToggleAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'icon',
		'label',
		'isActivated',
		'activatedAction',
		'deactivatedAction'
	],
	#category : #'GToolkit-Phlow-! Views and Actions'
}

{ #category : #accessing }
GtPhlowToggleAction >> action: aValuable [
	activatedAction := aValuable
]

{ #category : #accessing }
GtPhlowToggleAction >> activatedAction: aValuable [
	activatedAction := aValuable
]

{ #category : #converting }
GtPhlowToggleAction >> asElement: aBlock withHostElement: aTargetElement [
	<return: #BrButton>
	| aToggle |
	aToggle := BrToggle new.
	aToggle phlow 
		beAction;
		entity: self.
	aToggle look: self newToggleLook.
	label ifNotNil: [ aToggle label: label asRopedText ].
	icon ifNotNil: [ aToggle icon: icon asElement ].
	aToggle activated: isActivated value.
	aToggle 
		when: BrToggleActivatedEvent do: [ :anEvent | 
			(self isDefinitionRequested: anEvent) ifFalse: [ 
				activatedAction cull: aToggle ] ];
		when: BrToggleDeactivatedEvent do: [ :anEvent | 
			(self isDefinitionRequested: anEvent) ifFalse: [ 
				deactivatedAction cull: aToggle ] ].
	self attachShowDefinitionEventHandler: aToggle.
	self attachTooltipFor: aToggle hostElement: aTargetElement.
	^ aBlock value: aToggle
]

{ #category : #accessing }
GtPhlowToggleAction >> deactivatedAction: aValuable [
	deactivatedAction := aValuable
]

{ #category : #accessing }
GtPhlowToggleAction >> icon: anIcon [
	icon := anIcon
]

{ #category : #initialization }
GtPhlowToggleAction >> initialize [
	super initialize.
	isActivated := false.
	activatedAction := [ :aBrButton | "no action" ].
	deactivatedAction := [ :aBrButton | "no action" ].
	icon := nil.
	label := nil.
]

{ #category : #accessing }
GtPhlowToggleAction >> isActivated: anObject [
	isActivated := anObject
]

{ #category : #accessing }
GtPhlowToggleAction >> label: aString [
	label := aString
]

{ #category : #'instance creation' }
GtPhlowToggleAction >> newToggleLook [
	(label isNotNil and: [ icon isNotNil ]) ifTrue: [ 
		^ BrGlamorousButtonWithLabelAndIconLook + BrGlamorousToggleBackgroundLook ].
	(label isNotNil and: [ icon isNil ]) ifTrue: [ 
		^ BrGlamorousButtonWithLabelLook + BrGlamorousToggleBackgroundLook ].
	^ BrGlamorousButtonWithIconLook - BrGlamorousButtonWithLabelTooltipLook 
		+ BrGlamorousToggleBackgroundLook
]
