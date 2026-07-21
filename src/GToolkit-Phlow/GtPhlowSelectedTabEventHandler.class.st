"
I am a {{gtClass:BlCustomEventHandler}}. 
I trigger {{gtClass:GtPhlowExplicitlySelectedTabEvent}} events. 

"
Class {
	#name : #GtPhlowSelectedTabEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #'api - accessing' }
GtPhlowSelectedTabEventHandler >> eventsToHandle [
	^ {BrTabSelectedEvent}
]

{ #category : #'event handling' }
GtPhlowSelectedTabEventHandler >> tabSelected: anEvent [
	"Let's notify about it in the next world loop."

	BlTaskAction
		enqueueElement: anEvent currentTarget
		action: [ anEvent currentTarget
				fireEvent: (GtPhlowExplicitlySelectedTabEvent new selectedTab: anEvent tab) ]
]
