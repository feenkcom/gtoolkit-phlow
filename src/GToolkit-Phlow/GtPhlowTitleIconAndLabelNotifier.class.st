"
I am a {{gtClass:GtPhlowTitleNotifier}}.
I notify {{gtClass:BlElement}} parents that a label should be updated.
1. # Collaborators

I use {{gtClass:GtPhlowChangeTitleIconAndLabelWish}} to notify parents.
I use {{gtClass:GtPhlowTitleLabelBuilder}} to create labels.
1. # Examples
## Long title with icon

{{gtExample:GtPhlowTitleIconAndLabelNotifierExamples>>#notifierWithLongLabelAndIcon|codeExpanded=false|previewExpanded=true|previewHeight=180}}
1. ## Long title without icon

{{gtExample:GtPhlowTitleIconAndLabelNotifierExamples>>#notifierWithLongLabel|codeExpanded=false|previewExpanded=true|previewHeight=180}}
1. ## Short title with icon

{{gtExample:GtPhlowTitleIconAndLabelNotifierExamples>>#notifierWithShortLabelAndIcon|codeExpanded=false|previewExpanded=true|previewHeight=180}}
1. ## Short title without icon

{{gtExample:GtPhlowTitleIconAndLabelNotifierExamples>>#notifierWithShortLabel|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : #GtPhlowTitleIconAndLabelNotifier,
	#superclass : #GtPhlowTitleNotifier,
	#instVars : [
		'icon'
	],
	#category : 'GToolkit-Phlow-Tool - Title'
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
