"
I forward a view definition to another object.
I am useful in situations when the object that has the view definition is expensive to create.
I am also useful in situtions, when the object is created only for the purpose of the view.

I create the object only if someone clicks on my tab (view).

!! Example

You can define me as follow: ${method:GtPhlowViewExamples>>#gtForwardedViewFor:|expanded=true}$

"
Class {
	#name : #GtPhlowForwarderView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'object',
		'view',
		'phlowView',
		'viewObject'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #converting }
GtPhlowForwarderView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"
	^ self phlowView asElementDo: aBlock
]

{ #category : #private }
GtPhlowForwarderView >> createPhlowView [
	phlowView := self on: self viewObject perform: self viewSymbol.
	self addPhlowActions: phlowView actions.
	^ phlowView
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> forwardedActions [
	<return: #OrderedCollection of: #GtPhlowAction>
	^ self phlowView actions
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> forwardedPriority [
	^ self phlowView priority
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> forwardedTitle [
	^ self phlowView title
]

{ #category : #initialization }
GtPhlowForwarderView >> initialize [
	super initialize.
	priority := nil.
]

{ #category : #accessing }
GtPhlowForwarderView >> object [
	^ object
]

{ #category : #accessing }
GtPhlowForwarderView >> object: anObject [
	object := anObject
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> phlowView [
	phlowView ifNil: [ self createPhlowView ].
	^ phlowView
]

{ #category : #accessing }
GtPhlowForwarderView >> priority [
	^ priority ifNil: [ priority := self forwardedPriority ]
]

{ #category : #accessing }
GtPhlowForwarderView >> title [
	^ super title ifNil: [ self forwardedTitle ]
]

{ #category : #updating }
GtPhlowForwarderView >> updateContent: aBlElement [ 
	"anElement is previously computed content from asElementDo:"
	self phlowView updateContent: aBlElement
]

{ #category : #accessing }
GtPhlowForwarderView >> view: anObject [
	view := anObject
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> viewObject [
	^ viewObject ifNil: [ viewObject := self object value ]
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> viewSymbol [
	^ view ifNil: [ #gtLiveFor: ]
]
