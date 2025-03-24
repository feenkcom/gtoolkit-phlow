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
		'whenResizedHandler',
		'isWithDropdownIndicator'
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
	
	self isWithDropdownIndicator ifTrue: [ 
		aButton addAptitude: BrGlamorousButtonIconDropdownAptitude new ].
	
	self attachShowDefinitionEventHandler: aButton.
	self attachShowContextMenuEventHandler: aButton.
	self attachTooltipFor: aButton hostElement: aTargetElement.
	^ aBlock value: aButton
]

{ #category : #accessing }
GtPhlowDropdownAction >> content: aBlock [
	self menu: [ :anActionElement :aTargetElement | 
		BrMenuExplicit new 
			stencil: [ :anExplicitMenu |
				aBlock cull: anActionElement cull: aTargetElement cull: anExplicitMenu ] ]
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
	isWithDropdownIndicator := false
]

{ #category : #testing }
GtPhlowDropdownAction >> isWithDropdownIndicator [
	^ isWithDropdownIndicator ifNil: [ false ]
]

{ #category : #accessing }
GtPhlowDropdownAction >> items: aBlock [
	"Build a menu items (BrMenuItems).
	The stencil builds can be a block with arguments: [ :aButton :aHostElement :aMenuItems | ].
	The block configure the aMenuItems instance."

	self menu: [ :anActionElement :aTargetElement | 
		| aMenuItems |
		aMenuItems := BrMenuItems new.
		aBlock cull: anActionElement cull: aTargetElement cull: aMenuItems.
		aMenuItems ]
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
GtPhlowDropdownAction >> menu: aStencilBuilder [
	contentStencilBuilder := aStencilBuilder asStencilBuilder: GtPhlowActionMenuContentStencilBuilder
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
	(label isNotNil and: [ icon isNotNil ])
		ifTrue: [ ^ BrGlamorousButtonWithIconAndLabelAptitude ].

	(label notNil and: [ icon isNil ])
		ifTrue: [ ^ BrGlamorousButtonWithLabelAptitude ].

	^ BrGlamorousButtonWithIconAptitude
		- BrGlamorousButtonWithLabelTooltipAptitude2
]

{ #category : #'instance creation' }
GtPhlowDropdownAction >> newContentForDropdown: aDropdown targetElement: aTargetElement [
	contentStencilBuilder 
		actionElement: aDropdown;
		targetElement: aTargetElement.
	^ contentStencilBuilder build
]

{ #category : #converting }
GtPhlowDropdownAction >> newDropdownLookFor: aDropdown targetElement: aTargetElement [
	| anAptitude |
	anAptitude := BrGlamorousWithExplicitDropdownAptitude
			handle: [ self newButton
					aptitude: self newButtonLook - BrGlamorousButtonWithLabelTooltipAptitude2
							- BrGlamorousButtonExteriorAptitude;
					in: [ :theHandle | 
						self isWithDropdownIndicator
							ifTrue: [ theHandle addAptitude: BrGlamorousButtonIconDropdownAptitude new ] ];
					yourself ]
			menu: [ | aMenu anOriginalMenu |
				aMenu := anOriginalMenu := self
							newContentForDropdown: aDropdown
							targetElement: aTargetElement.

				anOriginalMenu
					ifNotNil: [ whenResizedHandler
							ifNotNil: [ :aHandler | 
								aMenu := BrMenuDecoratoringModel new
										menuModel: anOriginalMenu;
										decorator: [ :theOriginalMenuElement | 
											theOriginalMenuElement
												addAptitude: (BrGlamorousMenuResizableAptitude new
														whenResizedDo: [ :anEvent | aHandler cull: anEvent cull: anAptitude ]) ] ] ].

				aMenu ].

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

{ #category : #'api - initialization' }
GtPhlowDropdownAction >> withDropdownIndicator [
	isWithDropdownIndicator := true
]

{ #category : #'api - initialization' }
GtPhlowDropdownAction >> withoutDropdownIndicator [
	isWithDropdownIndicator := false
]
