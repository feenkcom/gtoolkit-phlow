"
I am used by {{gtClass:GtPhlowTool}}. 
I am responsible for changing objects (domain models) in {{gtClass:GtPhlowCompositeTool}} sub-tools.
I should be installed in tool widgets only if the tools are part of a {{gtClass:GtPhlowCompositeTool}}. I am not  useful if a tool is used alone (not composed). To this aim, we recommend to install the handler in an overriden {{gtMethod:GtPhlowAbstractTool>>#asTabElement}} method. 
1. # Requesting and Changing Displayed Objects

I ask the {{gtClass:GtPhlowCompositeTool}} widget for a current object (domain model) that should be displayed each time a {{gtClass:GtPhlowTool}} widget is displayed. To this aim, I listen to {{gtClass:BlElementAddedToSceneGraphEvent}}. When the tool is added to a scene graph, I {{gtMethod:BlElement>>#fireEvent:|label=fire}} {{gtClass:GtPhlowToolChangedObjectWish}} and if the wish {{gtMethod:GtPhlowToolChangedObjectWish>>#hasObject|label=has an object}}, I set the new tool object according to {{gtMethod:GtPhlowToolChangedObjectHandler>>#onChangeSend:to:|label=#selector}}. 
1. # Example

See a complete example in the {{gtClass:GtPhlowCompositeTool}} class comment.


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
