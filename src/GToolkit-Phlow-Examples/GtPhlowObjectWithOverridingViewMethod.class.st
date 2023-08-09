Class {
	#name : #GtPhlowObjectWithOverridingViewMethod,
	#superclass : #GtPhlowObjectWithOverridenViewMethod,
	#category : #'GToolkit-Phlow-Examples-Support'
}

{ #category : #'gt-extensions' }
GtPhlowObjectWithOverridingViewMethod >> methodOneFor: aView [
	<gtView>
	^ aView list
		title: 'Method one > two';
		items: [ 1 to: 12 ]
]
