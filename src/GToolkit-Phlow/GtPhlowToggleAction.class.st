Class {
	#name : #GtPhlowToggleAction,
	#superclass : #GtPhlowAction,
	#traits : 'TGtPhlowWithIcon',
	#classTraits : 'TGtPhlowWithIcon classTrait',
	#instVars : [
		'icon',
		'label',
		'isActivated',
		'activatedAction',
		'deactivatedAction'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
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
	aToggle look: self newToggleLook.
	label ifNotNil: [ aToggle label: label asRopedText ].
	icon ifNotNil: [ aToggle icon: self newIconElement ].
	aToggle activated: isActivated value.
	aToggle 
		when: BrToggleActivatedEvent do: [ :anEvent | 
			activatedAction cull: aToggle ];
		when: BrToggleDeactivatedEvent do: [ :anEvent | 
			deactivatedAction cull: aToggle ].
	self attachShowDefinitionEventHandler: aToggle.
	^ aBlock value: aToggle
]

{ #category : #accessing }
GtPhlowToggleAction >> deactivatedAction: aValuable [
	deactivatedAction := aValuable
]

{ #category : #accessing }
GtPhlowToggleAction >> icon [
	"Icon can be a String, Symbol, Form or another object understanding #asElement message"
	^ icon
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
	(label isNil and: [ icon isNil ]) ifTrue: [ 
		^ BrMaterialToggleBackgroundLook + BrGlamorousButtonWithLabelAndIconLook ].
	(label notNil and: [ icon isNil ]) ifTrue: [ 
		^ BrMaterialToggleBackgroundLook + BrGlamorousButtonWithLabelLook ].
	(label isNil and: [ icon notNil ]) ifTrue: [ 
		^ BrMaterialToggleBackgroundLook + BrGlamorousButtonWithIconLook ].
	^ BrMaterialToggleBackgroundLook + BrGlamorousButtonWithIconAndLabelLook
]
