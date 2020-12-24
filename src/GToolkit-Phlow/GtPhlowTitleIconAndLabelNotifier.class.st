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
	| aLabel |
	aLabel := self label ifEmpty: [ nil ].
	self element fireEvent: (GtPhlowChangeTitleIconAndLabelWish new 
		label: aLabel;
		icon: self icon value)
]
