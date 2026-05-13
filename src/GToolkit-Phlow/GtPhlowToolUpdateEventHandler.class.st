"
I listen to {{gtClass:GtPhlowToolUpdateWish}} and call {{gtMethod:GtPhlowToolUpdateEventHandler >> #action}} as a callback.
I can be disabled by receiving {{gtClass:GtPhlowToolDisableUpdatesWish}}. 
Element tools should use me to handle me properly update wish events.

"
Class {
	#name : #GtPhlowToolUpdateEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'action',
		'isEnabled'
	],
	#category : #'GToolkit-Phlow-Updating New'
}

{ #category : #'private - accessing' }
GtPhlowToolUpdateEventHandler >> action [
	<return: #MessageSend>
	^ action
]

{ #category : #'api - accessing' }
GtPhlowToolUpdateEventHandler >> eventsToHandle [
	^ {GtPhlowToolUpdateWish.
		GtPhlowToolDisableUpdatesWish}
]

{ #category : #initialization }
GtPhlowToolUpdateEventHandler >> initialize [
	super initialize.
	isEnabled := true.
	action := [ :aWish | "do nothing" ]
]

{ #category : #'private - accessing' }
GtPhlowToolUpdateEventHandler >> isDisabled [
	^ self isEnabled not
]

{ #category : #'private - accessing' }
GtPhlowToolUpdateEventHandler >> isEnabled [
	^ isEnabled
]

{ #category : #'api - accessing' }
GtPhlowToolUpdateEventHandler >> onUpdateSend: aSymbol to: aReceiver [
	"Set the ${class:MessageSend}$ which may receive wish events."

	action := MessageSend receiver: aReceiver selector: aSymbol
]

{ #category : #'api - event managing' }
GtPhlowToolUpdateEventHandler >> phlowToolDisableUpdatesWish: aWish [
	aWish consumed: true.

	isEnabled := false.
]

{ #category : #'api - event managing' }
GtPhlowToolUpdateEventHandler >> phlowToolUpdateWish: aWish [
	(self isEnabled or: [ aWish isCurrentToolOnly ]) ifTrue: [
		aWish consumed: true.
		self action cull: aWish ]
]
