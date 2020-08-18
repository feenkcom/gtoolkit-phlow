Class {
	#name : #GtPhlowViewsCollectorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'examples - views' }
GtPhlowViewsCollectorExamples >> collectOverridingViews [
	<gtExample>
	| anObject theViews |
	anObject := GtPhlowObjectWithOverridingViewMethod new.
	theViews := GtPhlowViewsCollector new
		object: anObject;
		from: GtPhlowObjectWithOverridingViewMethod;
		to: GtPhlowObjectWithOverridenViewMethod;
		collect.
	self assert: theViews size equals: 1.
	self assert: theViews first definingMethod methodClass equals: GtPhlowObjectWithOverridingViewMethod.
	^ theViews
]
