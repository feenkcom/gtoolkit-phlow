Class {
	#name : #GtPhlowTitleToolContentIconsAndLabelNotifier,
	#superclass : #GtPhlowTitleNotifier,
	#instVars : [
		'contentIcon',
		'toolIcon'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowTitleToolContentIconsAndLabelNotifier >> contentIcon [
	^ contentIcon
]

{ #category : #'api - accessing' }
GtPhlowTitleToolContentIconsAndLabelNotifier >> contentIcon: anIconOrStencil [
	contentIcon := anIconOrStencil
]

{ #category : #'api - accessing' }
GtPhlowTitleToolContentIconsAndLabelNotifier >> icon [
	^ self toolIcon
]

{ #category : #'api - accessing' }
GtPhlowTitleToolContentIconsAndLabelNotifier >> icon: anIcon [
	self toolIcon: anIcon
]

{ #category : #'api - notifying' }
GtPhlowTitleToolContentIconsAndLabelNotifier >> notify [
	| currentLabel currentToolIcon currentContentIcon |
	currentLabel := self label ifEmpty: [ nil ].
	currentToolIcon := self toolIcon value.
	(currentLabel isNil and: [ currentToolIcon isNil ]) ifTrue: [ ^ self ].
	currentContentIcon := self contentIcon value.
	
	self element fireEvent: (GtPhlowChangeTitleToolContentIconsAndLabelWish new 
		label: currentLabel;
		toolIcon: currentToolIcon;
		contentIcon: currentContentIcon)
]

{ #category : #'api - accessing' }
GtPhlowTitleToolContentIconsAndLabelNotifier >> toolIcon [
	^ toolIcon
]

{ #category : #'api - accessing' }
GtPhlowTitleToolContentIconsAndLabelNotifier >> toolIcon: anIcon [
	toolIcon := anIcon
]
