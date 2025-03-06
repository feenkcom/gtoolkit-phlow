Class {
	#name : #GtPhlowDropdownAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'icon',
		'label',
		'action',
		'name',
		'contentStencilBuilder',
		'preferredExtent',
		'whenResizedHandler'
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
	self attachShowContextMenuEventHandler: aButton.
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

{ #category : #'api - action' }
GtPhlowDropdownAction >> label [
	^ label
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
	anAptitude := BrGlamorousWithExplicitDropdownAptitude
			handle: [ self newButton
					aptitude: self newButtonLook - BrGlamorousButtonWithLabelTooltipAptitude
							- BrGlamorousButtonExteriorAptitude;
					yourself ]
			content: [ 
				| anElement |
				anElement := self
					newContentForDropdown: aDropdown
					targetElement: aTargetElement.
					
				whenResizedHandler ifNotNil: [ :aHandler |
					anElement addAptitude: (BrGlamorousMenuResizableAptitude new
						whenResizedDo: [ :anEvent |
							aHandler cull: anEvent cull: anAptitude ]) ].
					
				anElement ].
	
	^ anAptitude
]

{ #category : #accessing }
GtPhlowDropdownAction >> preferredExtent [
	<return: #Point or: nil>
	^ preferredExtent
]

{ #category : #accessing }
GtPhlowDropdownAction >> preferredExtent: aPoint [
	"This is an obsolete method that used to be used for set  
	{{gtMethod: BrWithAnchoredAptitude >> #preferredExtent:}}.
	The new menu (dropdown) implementation does not require it."

	preferredExtent := aPoint
]

{ #category : #accessing }
GtPhlowDropdownAction >> preferredExtentFrom: anObject [
	self
		preferredExtentFrom: anObject
		read: #preferredExtent
		write: #preferredExtent:
]

{ #category : #accessing }
GtPhlowDropdownAction >> preferredExtentFrom: aConfiguration read: aReadSelector write: aWriteSelector [
	"Read and store a dropdown extent from aConfiguration object, using aReadSelector and aWriteSelector."

	self preferredExtent: [ aConfiguration perform: aReadSelector ].
	self whenResizedDo: [ :anEvent :anAptitude | 
		aConfiguration perform: aWriteSelector with: anEvent extent ]
]

{ #category : #accessing }
GtPhlowDropdownAction >> whenResizedDo: aHandler [
	"Handler receives a resized event {{gtClass: BlResizerResizedEvent }} 
	and a dropdown aptitude {{gtClass: BrGlamorousWithExplicitDropdownAptitude }}"

	whenResizedHandler := aHandler
]
