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
	self attachShowContextMenuEventHandler: aDebugButton.
	self attachTooltipFor: aDebugButton hostElement: aTargetElement.
	^ aBlock value: aDebugButton
]

{ #category : #converting }
GtPhlowActionWithError >> asMenuItem: aBlock withHostElement: aTargetElement [
	"Return a menu item that represents the action in BrMenuItems, e.g., action"

	<return: #BrMenuItem>
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem
		icon: BrGlamorousVectorIcons debug
		label: 'Error'
		preview: [ self error messageText ].
	aMenuItem action: [ [ self error defaultAction ] fork ].

	self
		menuItemGroupIfPresent: [ :aGroup | aMenuItem group: aGroup ]
		ifAbsent: [  ].
		
	aMenuItem definition: [ self definingMethod ].

	^ aBlock value: aMenuItem
]

{ #category : #defaults }
GtPhlowActionWithError >> defaultTooltipBuilder [
	^ GtPhlowTooltipBuilder text: 'Display error'
]

{ #category : #'api - action' }
GtPhlowActionWithError >> description [
	"Return an action description.
	I am a convenience method to easily inspect and describe actions.
	I am not supposed to be used in a production code."

	<return: #String or: #BlText>
	^ 'error: {1}' format: { self definingSelector }
]

{ #category : #accessing }
GtPhlowActionWithError >> error [
	^ error
]

{ #category : #accessing }
GtPhlowActionWithError >> error: anObject [
	error := anObject
]

{ #category : #'gt-extension' }
GtPhlowActionWithError >> gtError1For: aView [
	<gtView>
	^ aView forward
		title: 'Error stack';
		object: [ error ];
		view: #gtLiveFor:
]

{ #category : #'gt-extension' }
GtPhlowActionWithError >> gtErrorFor: aView [
	<gtView>
	^ aView forward
		title: 'Error message';
		object: [ error ];
		view: #gtMessageTextFor:
]

{ #category : #'api - action' }
GtPhlowActionWithError >> label [
	^ nil
]
