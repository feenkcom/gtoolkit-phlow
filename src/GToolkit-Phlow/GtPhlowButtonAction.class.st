Class {
	#name : 'GtPhlowButtonAction',
	#superclass : 'GtPhlowAction',
	#instVars : [
		'icon',
		'label',
		'action',
		'name'
	],
	#category : 'GToolkit-Phlow-! Actions'
}

{ #category : 'accessing' }
GtPhlowButtonAction >> action: aValuable [
	action := aValuable
]

{ #category : 'converting' }
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
	action ifNotNil: [ aButton action: [ :theButton :aButtonModel :anEvent | 
			(self isDefinitionRequested: anEvent) ifFalse: [ 
				action glamourValueWithArgs: { theButton. aTargetElement. aButtonModel. anEvent } ] ] ].
	name ifNotNil: [ :aName | aButton id: aName ].
	self attachTooltipFor: aButton hostElement: aTargetElement.
	self attachShowDefinitionEventHandler: aButton.
	^ aBlock value: aButton
]

{ #category : 'accessing' }
GtPhlowButtonAction >> icon: anIcon [
	icon := anIcon
]

{ #category : 'initialization' }
GtPhlowButtonAction >> initialize [
	super initialize.

	action := [ :aButton ":aTargetElement :aButtonModel :anEvent " | "do nothing" ].
]

{ #category : 'api - action' }
GtPhlowButtonAction >> label [
	^ label ifNil: [ 'Action' ]
]

{ #category : 'accessing' }
GtPhlowButtonAction >> label: aString [
	label := aString
]

{ #category : 'accessing' }
GtPhlowButtonAction >> name: aSymbol [
	"Set a child name of the corresponding element"
	name := aSymbol
]

{ #category : 'instance creation' }
GtPhlowButtonAction >> newButtonLook [
	(label isNotNil and: [ icon isNotNil ]) ifTrue: [ ^ BrGlamorousButtonWithIconAndLabelAptitude ].
	(label notNil and: [ icon isNil ]) ifTrue: [ ^ BrGlamorousButtonWithLabelAptitude ].
	^ BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
]

{ #category : 'api - action' }
GtPhlowButtonAction >> performActionOn: anActionElement [
	action cull: anActionElement
]
