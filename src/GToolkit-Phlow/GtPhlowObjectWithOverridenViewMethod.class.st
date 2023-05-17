Class {
	#name : #GtPhlowObjectWithOverridenViewMethod,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples - Support'
}

{ #category : #'gt-extensions' }
GtPhlowObjectWithOverridenViewMethod >> methodOneFor: aView [
	<gtView>
	^ aView list
		title: 'Method one';
		items: [ 1 to: 9 ]
]
