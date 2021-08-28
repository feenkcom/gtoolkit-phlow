"
I am a {{gtClass:GtPhlowTitleNotifier}}.
I notify {{gtClass:BlElement}} parents that a label should be updated.
1. # Collaborators

I use {{gtClass:GtPhlowChangeTitleLabelWish}} to notify parents.
I use {{gtClass:GtPhlowTitleLabelBuilder}} to create labels.
1. # Examples
## Long title

{{gtExample:GtPhlowTitleLabelNotifierExamples>>#notifierWithLongLabel|codeExpanded=false|previewExpanded=true|previewHeight=180}}
1. ## Short title

{{gtExample:GtPhlowTitleLabelNotifierExamples>>#notifierWithShortLabel|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : 'GtPhlowTitleLabelNotifier',
	#superclass : 'GtPhlowTitleNotifier',
	#category : 'GToolkit-Phlow-Tool - Title'
}

{ #category : 'api - notifying' }
GtPhlowTitleLabelNotifier >> notify [
	| aLabel |
	aLabel := self label ifEmpty: [ ^ self ].
	self element fireEvent: (GtPhlowChangeTitleLabelWish new label: aLabel)
]
