Class {
	#name : 'GtPhlowDropdownAction',
	#superclass : 'GtPhlowAction',
	#instVars : [
		'icon',
		'label',
		'action',
		'name',
		'contentStencilBuilder'
	],
	#category : 'GToolkit-Phlow-! Actions'
}

{ #category : 'accessing' }
GtPhlowDropdownAction >> action: aValuable [
	action := aValuable
]

{ #category : 'converting' }
GtPhlowDropdownAction >> asElement: aBlock withHostElement: aTargetElement [
	<return: #BrButton>
	| aDropdown |
	aDropdown := self newButton.
	aDropdown phlow
		beAction;
		entity: self.
	aDropdown aptitude: self newButtonLook
		+ (self newDropdownLookFor: aDropdown targetElement: aTargetElement).
	name ifNotNil: [ :aName | aDropdown id: aName ].
	self attachShowDefinitionEventHandler: aDropdown.
	self attachTooltipFor: aDropdown hostElement: aTargetElement.
	^ aBlock value: aDropdown
]

{ #category : 'accessing' }
GtPhlowDropdownAction >> content: aStencilBuilder [
	contentStencilBuilder := aStencilBuilder asStencilBuilder: GtPhlowActionStencilBuilder
]

{ #category : 'accessing' }
GtPhlowDropdownAction >> help: aString [
	"Ignored for now. Suppose to be a tooltip explaining a button action"
]

{ #category : 'accessing' }
GtPhlowDropdownAction >> icon: anIcon [
	icon := anIcon
]

{ #category : 'initialization' }
GtPhlowDropdownAction >> initialize [
	super initialize.
	action := [ :aBrButton |  ].
	icon := nil.
	label := nil.
]

{ #category : 'accessing' }
GtPhlowDropdownAction >> label: aString [
	label := aString
]

{ #category : 'accessing' }
GtPhlowDropdownAction >> name [
	^ name
]

{ #category : 'accessing' }
GtPhlowDropdownAction >> name: anObject [
	name := anObject
]

{ #category : 'instance creation' }
GtPhlowDropdownAction >> newButton [
	<return: #BrButton>
	| aButton |
	aButton := BrButton new.
	label ifNotNil: [ aButton label: label asRopedText ].
	icon ifNotNil: [ aButton icon: icon asElement ].
	action ifNotNil: [ aButton action: action ].
	^ aButton
]

{ #category : 'instance creation' }
GtPhlowDropdownAction >> newButtonLook [
	(label isNotNil and: [ icon isNotNil ]) ifTrue: [ ^ BrGlamorousButtonWithIconAndLabelAptitude ].
	(label notNil and: [ icon isNil ]) ifTrue: [ ^ BrGlamorousButtonWithLabelAptitude ].
	^ BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
]

{ #category : 'instance creation' }
GtPhlowDropdownAction >> newContentForDropdown: aDropdown targetElement: aTargetElement [
	contentStencilBuilder 
		actionElement: aDropdown;
		targetElement: aTargetElement.
	^ contentStencilBuilder asElement
]

{ #category : 'converting' }
GtPhlowDropdownAction >> newDropdownLookFor: aDropdown targetElement: aTargetElement [
	^ BrGlamorousWithDropdownAptitude
		handle: [ self newButton
				aptitude:
					self newButtonLook - BrGlamorousButtonWithLabelTooltipAptitude
						- BrGlamorousButtonExteriorAptitude;
				yourself ]
		content:
			[ self newContentForDropdown: aDropdown targetElement: aTargetElement ]
]
