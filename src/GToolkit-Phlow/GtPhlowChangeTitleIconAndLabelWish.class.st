"
I am {{gtClass:BrWish}}.
I am {{gtClass:GtPhlowChangeTitleWish}}¡
I notify {{gtClass:BlElement}} that title icon and label should be changed.
1. # Collaborators

{{gtClass:GtPhlowTitleIconAndLabelNotifier}} fires my instances.
1. # Examples

Browse {{gtClass:GtPhlowTitleIconAndLabelNotifier}} for examples.


"
Class {
	#name : #GtPhlowChangeTitleIconAndLabelWish,
	#superclass : #GtPhlowChangeTitleWish,
	#instVars : [
		'icon',
		'label'
	],
	#category : 'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> icon [
	^ icon
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> icon: anObject [
	icon := anObject
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> label [
	^ label
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleIconAndLabelWish >> label: anObject [
	label := anObject
]
