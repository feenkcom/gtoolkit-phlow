"
I define a common API that should be implemented by all Phlow views.
"
Class {
	#name : #GtPhlowProtoView,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowProtoView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"
	self subclassResponsibility
]

{ #category : #converting }
GtPhlowProtoView >> asTaskItView [
	^ GtPhlowTaskItView new originalView: self
]

{ #category : #decorating }
GtPhlowProtoView >> composite [
	^ GtPhlowCompositeView new
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #accessing }
GtPhlowProtoView >> definingMethod [
	"Get view defining method.
	It is a method where a view is defined."
	<return: #RGMethodDefinition>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowProtoView >> definingMethod: aRGMethodDefinition [
	"Set view defining method.
	It is a method where a view is defined."
	^ self subclassResponsibility
]

{ #category : #decorating }
GtPhlowProtoView >> empty [
	^ GtPhlowEmptyView new
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #decorating }
GtPhlowProtoView >> explicit [
	^ self sequentialExplicit
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #converting }
GtPhlowProtoView >> ifItHasContent: aBlock [
	^ self subclassResponsibility
]

{ #category : #decorating }
GtPhlowProtoView >> labelled [
	^ GtPhlowLabelledView new 
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #decorating }
GtPhlowProtoView >> labelled: aStringOrText [
	^ self labelled 
		label: aStringOrText;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #accessing }
GtPhlowProtoView >> priority [
	"Get view priority defining a view order.
	Lower priority is supposed to be displayed to the left."
	<return: #Number>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowProtoView >> priority: aNumber [
	"Set view priority defining a view order.
	Lower priority is supposed to be displayed to the left."
	^ self subclassResponsibility
]

{ #category : #decorating }
GtPhlowProtoView >> sequentialExplicit [
	^ GtPhlowSequentialExplicitView new 
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #decorating }
GtPhlowProtoView >> taskItExplicit [
	^ GtPhlowTaskItExplicitView new 
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]

{ #category : #accessing }
GtPhlowProtoView >> title [
	"Return view title, a user friendly view name.
	It is supposed to be a short name"
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPhlowProtoView >> title: aString [
	"Set view title, a user friendly view name.
	It is supposed to be a short name"
	^ self subclassResponsibility
]
