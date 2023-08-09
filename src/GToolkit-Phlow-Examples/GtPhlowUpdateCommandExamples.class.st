"
I am an abstract class.
I provide basic support to exemplify {{gtClass:GtPhlowUpdateCommand}} subclasses.


"
Class {
	#name : #GtPhlowUpdateCommandExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Core'
}

{ #category : #'examples - view' }
GtPhlowUpdateCommandExamples >> compositeElement [
	<gtExample>
	^ GtPhlowCompositeViewExamples new element
]

{ #category : #'examples - view' }
GtPhlowUpdateCommandExamples >> compositeView [
	<gtExample>
	^ GtPhlowCompositeViewExamples new phlowView 
]

{ #category : #'examples - view' }
GtPhlowUpdateCommandExamples >> explicitElement [
	<gtExample>
	^ GtPhlowExplicitViewExamples new element 
]

{ #category : #'examples - view' }
GtPhlowUpdateCommandExamples >> explicitView [
	<gtExample>
	^ GtPhlowExplicitViewExamples new phlowView 
]
