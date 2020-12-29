Class {
	#name : #GtPhlowTitleIconAndLabelNotifier,
	#superclass : #GtPhlowTitleNotifier,
	#instVars : [
		'icon'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowTitleIconAndLabelNotifier >> icon [
	^ icon
]

{ #category : #'api - accessing' }
GtPhlowTitleIconAndLabelNotifier >> icon: anObject [
	icon := anObject
]

{ #category : #'api - notifying' }
GtPhlowTitleIconAndLabelNotifier >> notify [
	| aLabel anIcon |
	aLabel := self label ifEmpty: [ nil ].
	anIcon := self icon value.
	(aLabel isNil and: [ anIcon isNil ]) ifTrue: [ ^ self ].
	self element fireEvent: (GtPhlowChangeTitleIconAndLabelWish new 
		label: aLabel;
		icon: anIcon)
]
