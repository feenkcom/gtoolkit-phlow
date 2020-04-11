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
GtPhlowButtonAction >> asElement: aBlock withHostElement: aTargetElement [
	<return: #BrButton>
	| aButton |
	aButton := BrButton new.
	aButton look: self newButtonLook.
	aButton phlow 
		beAction;
		entity: self.
	label ifNotNil: [ aButton label: label asRopedText ].
	icon ifNotNil: [ aButton icon: icon asElement ].
	action ifNotNil: [ aButton action: [ :theButton :aButtonModel :anEvent | 
			(self isDefinitionRequested: anEvent) ifFalse: [ 
				action glamourValueWithArgs: { theButton. aTargetElement. aButtonModel. anEvent } ] ] ].
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
	action := [ :aButton :aTargetElement :aButtonModel :anEvent | 
		"do nothing" ].
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
	^ BrGlamorousButtonWithIconLook new
]
