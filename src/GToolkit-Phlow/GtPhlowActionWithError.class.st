Class {
	#name : #GtPhlowActionWithError,
	#superclass : #GtPhlowAction,
	#instVars : [
		'error'
	],
	#category : #'GToolkit-Phlow-! Actions'
}

{ #category : #converting }
GtPhlowActionWithError >> asElement: aBlock withHostElement: aTargetElement [
	| aDebugButton |
	aDebugButton := BrButton new.
	aDebugButton 
		aptitude: (
			(BrGlamorousButtonExteriorAptitude new backgroundPaint: BrGlamorousColors errorBackgroundColor)
			+ BrGlamorousButtonRectangularAptitude
			+ BrGlamorousButtonLabelAptitude);
		label: 'Error';
		action: [ [ self error defaultAction ] fork ].
	self attachShowDefinitionEventHandler: aDebugButton.
	self attachTooltipFor: aDebugButton hostElement: aTargetElement.
	^ aBlock value: aDebugButton
]

{ #category : #defaults }
GtPhlowActionWithError >> defaultTooltipBuilder [
	^ GtPhlowTooltipBuilder text: 'Display error'
]

{ #category : #accessing }
GtPhlowActionWithError >> error [
	^ error
]

{ #category : #accessing }
GtPhlowActionWithError >> error: anObject [
	error := anObject
]
