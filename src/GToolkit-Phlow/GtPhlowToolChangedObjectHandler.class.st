"
I am used by ${class:GtPhlowTool}$. 
I am responsible for changing objects (domain models) in ${class:GtPhlowCompositeTool}$ sub-tools.
I should be installed in tool widgets only if the tools are part of a ${class:GtPhlowCompositeTool}$. I am not  useful if a tool is used alone (not composed). To this aim, we recommend to install the handler in an overriden ${method:GtPhlowAbstractTool>>#asTabElement}$ method. 
!! Requesting and Changing Displayed Objects
I ask the ${class:GtPhlowCompositeTool}$ widget for a current object (domain model) that should be displayed each time a ${class:GtPhlowTool}$ widget is displayed. To this aim, I listen to ${class:BlElementAddedToSceneGraphEvent}$. When the tool is added to a scene graph, I ${method:BlElement>>#fireEvent:|label=fire}$ ${class:GtPhlowToolChangedObjectWish}$ and if the wish ${method:GtPhlowToolChangedObjectWish>>#hasObject|label=has an object}$, I set the new tool object according to ${method:GtPhlowToolChangedObjectHandler>>#onChangeSend:to:|label=#selector}$. 
!! Example
See a complete example in the ${class:GtPhlowCompositeTool}$ class comment.

"
Class {
	#name : #GtPhlowToolChangedObjectHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'element',
		'action'
	],
	#category : #'GToolkit-Phlow-Tool - Object Changer'
}

{ #category : #comparing }
GtPhlowToolChangedObjectHandler >> = anotherObject [
	^ self species == anotherObject species and: [ 
			self element = anotherObject element ]
]

{ #category : #'private - accessing' }
GtPhlowToolChangedObjectHandler >> action [
	<return: #MessageSend>
	^ action
]

{ #category : #'private - accessing' }
GtPhlowToolChangedObjectHandler >> element [
	<return: #BlElement>
	^ element
]

{ #category : #'api - accessing' }
GtPhlowToolChangedObjectHandler >> eventsToHandle [
	^ Array 
		with: BlElementAddedToSceneGraphEvent
]

{ #category : #'api - event managing' }
GtPhlowToolChangedObjectHandler >> handleEvent: anEvent [
	| aWish |
	aWish := GtPhlowToolChangedObjectWish new.
	self element fireEvent: aWish.
	aWish hasObject ifFalse: [ ^ self ].
	self action value: aWish object.
]

{ #category : #comparing }
GtPhlowToolChangedObjectHandler >> hash [
	^ self species hash bitXor: self element hash
]

{ #category : #initialization }
GtPhlowToolChangedObjectHandler >> initialize [
	super initialize.
	action := [ :anObject | "do nothing" ].
]

{ #category : #'api - accessing' }
GtPhlowToolChangedObjectHandler >> onChangeSend: aSymbol to: aReceiver [
	"Set the ${class:MessageSend}$ that is used to update ${class:GtPhlowTool}$ displayed object (domain model)."
	action := MessageSend receiver: aReceiver selector: aSymbol
]

{ #category : #'api - hooks' }
GtPhlowToolChangedObjectHandler >> onInstalledIn: anElement [

	element ifNotNil: [ element removeEventHandler: self ].
	element := anElement.
]

{ #category : #'api - event managing' }
GtPhlowToolChangedObjectHandler >> wantsEvent: anEvent [
	^ anEvent class == BlElementAddedToSceneGraphEvent
]
