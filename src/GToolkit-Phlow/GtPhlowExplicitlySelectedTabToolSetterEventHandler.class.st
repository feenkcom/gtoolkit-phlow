"
I am {{gtClass:GtPhlowExplicitlySelectedTabEvent}}.
I set a tool element to fired {{gtClass:GtPhlowExplicitlySelectedTabEvent}} events. 

"
Class {
	#name : #GtPhlowExplicitlySelectedTabToolSetterEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'selectionStateHandler'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #'api - accessing' }
GtPhlowExplicitlySelectedTabToolSetterEventHandler >> eventsToHandle [
	^ {GtPhlowExplicitlySelectedTabEvent}
]

{ #category : #'event handling' }
GtPhlowExplicitlySelectedTabToolSetterEventHandler >> phlowExplicitlySelectedTabEvent: anEvent [
	"Set tool element in case it is still nil."

	anEvent toolElement: anEvent currentTarget
]

{ #category : #accessing }
GtPhlowExplicitlySelectedTabToolSetterEventHandler >> selectionStateHandler [
	<return: #TGtPhlowToolSelectionStateHandler>
	^ selectionStateHandler
]

{ #category : #accessing }
GtPhlowExplicitlySelectedTabToolSetterEventHandler >> selectionStateHandler: aHandler [
	self assert: [ aHandler isNotNil ].

	selectionStateHandler := aHandler
]
