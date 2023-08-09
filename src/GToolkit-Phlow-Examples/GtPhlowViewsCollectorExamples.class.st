Class {
	#name : #GtPhlowViewsCollectorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Core'
}

{ #category : #'examples - views' }
GtPhlowViewsCollectorExamples >> collectOverridingPragmas [
	<gtExample>
	| anObject thePragmas |
	anObject := GtPhlowObjectWithOverridingViewMethod new.
	thePragmas := GtPhlowViewsCollector new
		object: anObject;
		from: GtPhlowObjectWithOverridingViewMethod;
		to: GtPhlowObjectWithOverridenViewMethod;
		collectPragmas.
	self assert: thePragmas size equals: 1.
	self assert: thePragmas first methodClass equals: GtPhlowObjectWithOverridingViewMethod.
	^ thePragmas
]

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
