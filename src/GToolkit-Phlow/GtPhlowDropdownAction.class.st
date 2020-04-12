Class {
	#name : #GtPhlowDropdownAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'icon',
		'label',
		'action',
		'contentStencilBuilder'
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
	aDropdown := self newButton.
	aDropdown phlow
		beAction;
		entity: self.
	aDropdown
		look:
			self newButtonLook
				+
					(BrGlamorousWithDropdownLook
						handle: [ self newButton
								look:
									self newButtonLook - BrGlamorousWithLabelTooltipLook
										- BrGlamorousButtonExteriorLook;
								yourself ]
						content: [ self 
								newContentForDropdown: aDropdown 
								targetElement: aTargetElement ]).
	self attachShowDefinitionEventHandler: aDropdown.
	^ aBlock value: aDropdown
]

{ #category : #accessing }
GtPhlowDropdownAction >> content: aStencilBuilder [
	contentStencilBuilder := aStencilBuilder asStencilBuilder: GtPhlowActionStencilBuilder
]

{ #category : #accessing }
GtPhlowDropdownAction >> help: aString [
	"Ignored for now. Suppose to be a tooltip explaining a button action"
]

{ #category : #accessing }
GtPhlowDropdownAction >> icon: anIcon [
	icon := anIcon
]

{ #category : #initialization }
GtPhlowDropdownAction >> initialize [
	super initialize.
	action := [ :aBrButton |  ].
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
	label ifNotNil: [ aButton label: label asRopedText ].
	icon ifNotNil: [ aButton icon: icon asElement ].
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
GtPhlowDropdownAction >> newContentForDropdown: aDropdown targetElement: aTargetElement [
	contentStencilBuilder 
		actionElement: aDropdown;
		targetElement: aTargetElement.
	^ contentStencilBuilder asElement
]
