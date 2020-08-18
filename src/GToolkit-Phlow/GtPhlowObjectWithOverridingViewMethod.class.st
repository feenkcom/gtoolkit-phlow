Class {
	#name : #GtPhlowObjectWithOverridingViewMethod,
	#superclass : #GtPhlowObjectWithOverridenViewMethod,
	#category : #'GToolkit-Phlow-Examples - Support'
}

{ #category : #'gt-extensions' }
GtPhlowObjectWithOverridingViewMethod >> methodOneFor: aView [
	<gtView>
	^ aView list
		title: 'Method One > Two';
		items: [ 1 to: 12 ]
]
