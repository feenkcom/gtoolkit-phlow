"
I am a ${class:GtPhlowTitleNotifier}$.
I notify ${class:BlElement}$ parents that a label should be updated.
!! Collaborators
I use ${class:GtPhlowChangeTitleLabelWish}$ to notify parents.
I use ${class:GtPhlowTitleLabelBuilder}$ to create labels.
!! Examples
!!! Long title
${example:GtPhlowTitleLabelNotifierExamples>>#notifierWithLongLabel|codeExpanded=false|previewExpanded=true|previewHeight=180}$
!!! Short title
${example:GtPhlowTitleLabelNotifierExamples>>#notifierWithShortLabel|codeExpanded=false|previewExpanded=true|previewHeight=180}$

"
Class {
	#name : #GtPhlowTitleLabelNotifier,
	#superclass : #GtPhlowTitleNotifier,
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - notifying' }
GtPhlowTitleLabelNotifier >> notify [
	| aLabel |
	aLabel := self label ifEmpty: [ ^ self ].
	self element fireEvent: (GtPhlowChangeTitleLabelWish new label: aLabel)
]
