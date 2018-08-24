Class {
	#name : #GtPhlowNoAction,
	#superclass : #GtPhlowAction,
	#instVars : [
		'stencilBuilder'
	],
	#category : 'GToolkit-Phlow'
}

{ #category : #converting }
GtPhlowNoAction >> asElementDo: aBlock withElement: aTargetElement [
	"do nothing"
]
