Class {
	#name : #GtPhlowDropdownAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'icon',
		'label',
		'action',
		'name',
		'contentStencilBuilder',
		'preferredExtent'
	],
	#category : #'GToolkit-Phlow-! Actions'
}

{ #category : #accessing }
GtPhlowDropdownAction >> action: aValuable [
	action := aValuable
]

{ #category : #converting }
GtPhlowDropdownAction >> asElement: aBlock withHostElement: aTargetElement [
	<return: #BrButton>
	| aButton |
	aButton := self newButton.
	aButton phlow
		beAction;
		entity: self.
	aButton aptitude: self newButtonLook
		+ (self newDropdownLookFor: aButton targetElement: aTargetElement).
	name ifNotNil: [ :aName | aButton id: aName ].
	id ifNotNil: [ aButton id: self id ].
	self attachShowDefinitionEventHandler: aButton.
	self attachTooltipFor: aButton hostElement: aTargetElement.
	^ aBlock value: aButton
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

{ #category : #accessing }
GtPhlowDropdownAction >> name [
	^ name
]

{ #category : #accessing }
GtPhlowDropdownAction >> name: anObject [
	name := anObject
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
	(label isNotNil and: [ icon isNotNil ]) ifTrue: [ 
		^ BrGlamorousButtonWithIconAndLabelAptitude ].
	
	(label notNil and: [ icon isNil ]) ifTrue: [ 
		^ BrGlamorousButtonWithLabelAptitude ].
	
	^ BrGlamorousButtonWithIconAptitude 
		- BrGlamorousButtonWithLabelTooltipAptitude
]

{ #category : #'instance creation' }
GtPhlowDropdownAction >> newContentForDropdown: aDropdown targetElement: aTargetElement [
	contentStencilBuilder 
		actionElement: aDropdown;
		targetElement: aTargetElement.
	^ contentStencilBuilder asElement
]

{ #category : #converting }
GtPhlowDropdownAction >> newDropdownLookFor: aDropdown targetElement: aTargetElement [
	| anAptitude |
	anAptitude := BrGlamorousWithDropdownAptitude
			handle: [ self newButton
					aptitude: self newButtonLook - BrGlamorousButtonWithLabelTooltipAptitude
							- BrGlamorousButtonExteriorAptitude;
					yourself ]
			content: [ self
					newContentForDropdown: aDropdown
					targetElement: aTargetElement ].
					
	preferredExtent ifNotNil: [ :anExtent |
		anAptitude preferredExtent: anExtent ].
					
	^ anAptitude
]

{ #category : #accessing }
GtPhlowDropdownAction >> preferredExtent [
	<return: #Point or: nil>
	^ preferredExtent
]

{ #category : #accessing }
GtPhlowDropdownAction >> preferredExtent: aPoint [
	"Currently the dropdown position is determined by 
	{{gtMethod: BrWithAnchoredAptitude >> #preferredExtent:}}.
	For that reason users can set explicitly the preferred extent
	to place the dropdown contents inside of the space bounds."

	preferredExtent := aPoint
]
