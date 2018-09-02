Class {
	#name : #GtPhlowActionWithError,
	#superclass : #GtPhlowAction,
	#instVars : [
		'error'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #accessing }
GtPhlowActionWithError >> asElementDo: aBlock withElement: aTargetElement [
	| debugButton |
	debugButton := BrButton new.
	debugButton look: (BrGlamorousButtonExteriorRectangularLook new backgroundPaint: BrGlamorousColors errorBackgroundColor) + BrGlamorousButtonLabelLook.
	debugButton label: 'Error'.
	debugButton action: [ [error defaultAction] fork ].
	^ aBlock value: debugButton
]

{ #category : #accessing }
GtPhlowActionWithError >> error [
	^ error
]

{ #category : #accessing }
GtPhlowActionWithError >> error: anObject [
	error := anObject
]
