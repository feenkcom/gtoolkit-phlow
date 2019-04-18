Class {
	#name : #GtPhlowDropdownAction,
	#superclass : #GtPhlowAction,
	#traits : 'TGtPhlowWithIcon',
	#classTraits : 'TGtPhlowWithIcon classTrait',
	#instVars : [
		'icon',
		'label',
		'action',
		'popupStencilBuilder'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowDropdownAction >> action: aValuable [
	action := aValuable
]

{ #category : #converting }
GtPhlowDropdownAction >> asElement: aBlock withHostElement: aTargetElement [
	<return: #BrButton>
	| aDropdown |
	aDropdown := BrDropdown new.
	aDropdown 
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
	 	look: (BrDropdownLook new 
			outskirtsEmbellisher: [ :e | e look: GtDropdownOutskirtsLook new ]);
		toggle: [ self newButton action: [ aDropdown toggle ] ];
		popup: [ self newPopupWithTargetElement: aTargetElement ].
	self attachShowDefinitionEventHandler: aDropdown.
	^ aBlock value: aDropdown
]

{ #category : #accessing }
GtPhlowDropdownAction >> help: aString [
	"Ignored for now. Suppose to be a tooltip explaining a button action"
]

{ #category : #accessing }
GtPhlowDropdownAction >> icon [
	"Icon can be a String, Symbol, Form or another object understanding #asElement message"
	^ icon
]

{ #category : #accessing }
GtPhlowDropdownAction >> icon: anIcon [
	icon := anIcon
]

{ #category : #initialization }
GtPhlowDropdownAction >> initialize [
	super initialize.
	action := [ :aBrButton | self inform: 'Click!' ].
	icon := nil.
	label := nil.
]

{ #category : #accessing }
GtPhlowDropdownAction >> label: aString [
	label := aString
]

{ #category : #'instance creation' }
GtPhlowDropdownAction >> newButton [
	<return: #BrButton>
	| aButton |
	aButton := BrButton new.
	aButton look: self newButtonLook.
	label ifNotNil: [ aButton label: label asRopedText ].
	icon ifNotNil: [ aButton icon: self newIconElement ].
	action ifNotNil: [ aButton action: action ].
	^ aButton
]

{ #category : #'instance creation' }
GtPhlowDropdownAction >> newButtonLook [
	(label isNil and: [ icon isNil ]) ifTrue: [ ^ BrGlamorousButtonWithLabelAndIconLook ].
	(label notNil and: [ icon isNil ]) ifTrue: [ ^ BrGlamorousButtonWithLabelLook ].
	(label isNil and: [ icon notNil ]) ifTrue: [ ^ BrGlamorousButtonWithIconLook ].
	^ BrGlamorousButtonWithIconAndLabelLook
]

{ #category : #'instance creation' }
GtPhlowDropdownAction >> newPopupWithTargetElement: aTargetElement [
	popupStencilBuilder targetElement: aTargetElement.
	^ popupStencilBuilder asElement
]

{ #category : #accessing }
GtPhlowDropdownAction >> popup: aStencilBuilder [
	popupStencilBuilder := aStencilBuilder asStencilBuilder: GtPhlowActionStencilBuilder
]
