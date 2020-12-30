"
I am ${class:BrWish}$.
I am ${class:GtPhlowChangeTitleWish}$¡
I notify ${class:BlElement}$ that title label should be changed (and a title icon removed).
!! Collaborators
${class:GtPhlowTitleLabelNotifier}$ fires my instances.
!! Examples
Browse ${class:GtPhlowTitleLabelNotifier}$ for examples.
"
Class {
	#name : #GtPhlowChangeTitleLabelWish,
	#superclass : #GtPhlowChangeTitleWish,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowChangeTitleLabelWish >> label [
	^ label
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleLabelWish >> label: anObject [
	label := anObject
]
