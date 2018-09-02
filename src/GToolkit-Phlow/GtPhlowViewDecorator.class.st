"
I am a decorator of an ==originalView== of which I keep track.

My subclasses typically offer fluent APIs for constructing a view based on external engines.
"
Class {
	#name : #GtPhlowViewDecorator,
	#superclass : #GtPhlowView,
	#instVars : [
		'originalView'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #testing }
GtPhlowViewDecorator class >> isAbstract [
	^ self name = #GtPhlowViewDecorator 
]

{ #category : #accessing }
GtPhlowViewDecorator >> originalView [
	^ originalView
]

{ #category : #accessing }
GtPhlowViewDecorator >> originalView: aView [
	originalView := aView
]
