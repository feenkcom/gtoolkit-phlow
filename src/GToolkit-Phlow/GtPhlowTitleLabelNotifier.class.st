Class {
	#name : #GtPhlowTitleLabelNotifier,
	#superclass : #GtPhlowTitleNotifier,
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - notifying' }
GtPhlowTitleLabelNotifier >> notify [
	| aLabel |
	self labelBuilder hasLabel ifFalse: [ ^ self ].
	aLabel := self label ifEmpty: [ ^ self ].
	self element fireEvent: (GtPhlowChangeTitleLabelWish new label: aLabel)
]
