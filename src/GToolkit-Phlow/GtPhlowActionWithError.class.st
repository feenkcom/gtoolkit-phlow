Class {
	#name : #GtPhlowActionWithError,
	#superclass : #GtPhlowAction,
	#instVars : [
		'error'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowActionWithError >> asElementDo: aBlock withElement: aTargetElement [
	| aDebugButton |
	aDebugButton := BrButton new.
	aDebugButton 
		look: (BrGlamorousButtonExteriorRectangularLook new 
					backgroundPaint: BrGlamorousColors errorBackgroundColor) 
			+ BrGlamorousButtonLabelLook;
		label: 'Error';
		action: [ [ self error defaultAction ] fork ].
	self attachShowDefinitionEventHandler: aDebugButton.
	^ aBlock value: aDebugButton
]

{ #category : #accessing }
GtPhlowActionWithError >> error [
	^ error
]

{ #category : #accessing }
GtPhlowActionWithError >> error: anObject [
	error := anObject
]
