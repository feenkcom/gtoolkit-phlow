"
I am {{gtClass:BrWish}}.
I am {{gtClass:GtPhlowChangeTitleWish}}¡
I notify {{gtClass:BlElement}} that title label should be changed (and a title icon removed).
1. # Collaborators

{{gtClass:GtPhlowTitleLabelNotifier}} fires my instances.
1. # Examples

Browse {{gtClass:GtPhlowTitleLabelNotifier}} for examples.


"
Class {
	#name : 'GtPhlowChangeTitleLabelWish',
	#superclass : 'GtPhlowChangeTitleWish',
	#instVars : [
		'label'
	],
	#category : 'GToolkit-Phlow-Tool - Title'
}

{ #category : 'api - accessing' }
GtPhlowChangeTitleLabelWish >> label [
	^ label
]

{ #category : 'api - accessing' }
GtPhlowChangeTitleLabelWish >> label: anObject [
	label := anObject
]
