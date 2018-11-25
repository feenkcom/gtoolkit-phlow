Class {
	#name : #GtPhlowButtonAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'icon',
		'label',
		'action'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowButtonAction >> action: aValuable [
	action := aValuable
]

{ #category : #converting }
GtPhlowButtonAction >> asElementDo: aBlock withElement: aTargetElement [
	<return: #BrButton>
	| aButton |
	aButton := BrButton new.
	aButton look: self newButtonLook.
	label ifNotNil: [ aButton label: label asRopedText ].
	icon ifNotNil: [ aButton icon: icon asElement ].
	action ifNotNil: [ aButton action: action ].
	self attachShowDefinitionEventHandler: aButton.
	^ aBlock value: aButton
]

{ #category : #accessing }
GtPhlowButtonAction >> icon: anIcon [
	icon := anIcon
]

{ #category : #initialization }
GtPhlowButtonAction >> initialize [
	super initialize.
	action := [ :aBrButton | self inform: 'Click!' ].
	icon := nil.
	label := nil.
]

{ #category : #accessing }
GtPhlowButtonAction >> label: aString [
	label := aString
]

{ #category : #'instance creation' }
GtPhlowButtonAction >> newButtonLook [
	(label isNil and: [ icon isNil ]) ifTrue: [ ^ BrGlamorousButtonWithLabelAndIconLook ].
	(label notNil and: [ icon isNil ]) ifTrue: [ ^ BrGlamorousButtonWithLabelLook ].
	(label isNil and: [ icon notNil ]) ifTrue: [ ^ BrGlamorousButtonWithIconLook ].
	^ BrGlamorousButtonWithIconAndLabelLook
]
