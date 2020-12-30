"
I am ${class:BrWish}$.
I am ${class:GtPhlowChangeTitleWish}$¡
I notify ${class:BlElement}$ that title icon and label should be changed.
!! Collaborators
${class:GtPhlowTitleIconAndLabelNotifier}$ fires my instances.
!! Examples
Browse ${class:GtPhlowTitleIconAndLabelNotifier}$ for examples.
"
Class {
	#name : #GtPhlowChangeTitleIconAndLabelWish,
	#superclass : #GtPhlowChangeTitleWish,
	#instVars : [
		'icon',
		'label'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
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
