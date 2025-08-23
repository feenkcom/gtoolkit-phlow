"
I am used by {{gtClass:GtPhlowTool}}. 
I am responsible for changing objects (domain models) in {{gtClass:GtPhlowCompositeTool}} sub-tools.
I should be installed in tool widgets only if the tools are part of a {{gtClass:GtPhlowCompositeTool}}. I am not  useful if a tool is used alone (not composed). To this aim, we recommend to install the handler in an overriden {{gtMethod:GtPhlowAbstractTool>>#asTabElement}} method. 
# Requesting and Changing Displayed Objects
I ask the {{gtClass:GtPhlowCompositeTool}} widget for a current object (domain model) that should be displayed each time a {{gtClass:GtPhlowTool}} widget is displayed. To this aim, I listen to {{gtClass:BlElementAddedToSceneGraphEvent}}. When the tool is added to a scene graph, I {{gtMethod:BlElement>>#fireEvent:|label=fire}} {{gtClass:GtPhlowToolChangedObjectWish}} and if the wish {{gtMethod:GtPhlowToolChangedObjectWish>>#hasObject|label=has an object}}, I set the new tool object according to {{gtMethod:GtPhlowToolChangedObjectHandler>>#onChangeSend:to:|label=#selector}}. 
# Example
See a complete example in the {{gtClass:GtPhlowCompositeTool}} class comment.


"
Class {
	#name : #GtPhlowToolChangedObjectHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'action'
	],
	#category : #'GToolkit-Phlow-Tool - Object Changer'
}

{ #category : #'private - accessing' }
GtPhlowToolChangedObjectHandler >> action [
	<return: #MessageSend>
	^ action
]

{ #category : #'api - event managing' }
GtPhlowToolChangedObjectHandler >> elementAddedToSceneGraphEvent: anEvent [
	| aWish |
	aWish := GtPhlowToolChangedObjectWish new.
	anEvent currentTarget fireEvent: aWish.
	aWish hasObject ifFalse: [ ^ self ].
	self action value: aWish object.
	
	"Let's update phlow tool too.
	Note: phlow tools ignore the #object: calls by default."
	anEvent currentTarget phlow isTool ifFalse: [ ^ self ].
	anEvent currentTarget phlow entity object: aWish object.
]

{ #category : #'api - accessing' }
GtPhlowToolChangedObjectHandler >> eventsToHandle [
	^ {BlElementAddedToSceneGraphEvent}
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
