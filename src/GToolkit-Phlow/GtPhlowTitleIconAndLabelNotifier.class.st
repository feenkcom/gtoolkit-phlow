"
I am a ${class:GtPhlowTitleNotifier}$.
I notify ${class:BlElement}$ parents that a label should be updated.
!! Collaborators
I use ${class:GtPhlowChangeTitleIconAndLabelWish}$ to notify parents.
I use ${class:GtPhlowTitleLabelBuilder}$ to create labels.
!! Examples
!!! Long title with icon
${example:GtPhlowTitleIconAndLabelNotifierExamples>>#notifierWithLongLabelAndIcon|codeExpanded=false|previewExpanded=true|previewHeight=180}$
!!! Long title without icon
${example:GtPhlowTitleIconAndLabelNotifierExamples>>#notifierWithLongLabel|codeExpanded=false|previewExpanded=true|previewHeight=180}$
!!! Short title with icon
${example:GtPhlowTitleIconAndLabelNotifierExamples>>#notifierWithShortLabelAndIcon|codeExpanded=false|previewExpanded=true|previewHeight=180}$
!!! Short title without icon
${example:GtPhlowTitleIconAndLabelNotifierExamples>>#notifierWithShortLabel|codeExpanded=false|previewExpanded=true|previewHeight=180}$

"
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
