Class {
	#name : #GtPhlowTaskItView,
	#superclass : #GtPhlowProtoView,
	#instVars : [
		'originalView'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #converting }
GtPhlowTaskItView >> asElementDo: aBlock [
	| aFutureElement |
	aFutureElement := BrAsyncWidget new
			withAsyncFutureDo: [ :anElementFuture | 
				| anExecutionConfiguration |
				anExecutionConfiguration := nil.
				self originalView
					ifNotNil: [ :aPhlowView | anExecutionConfiguration := aPhlowView futureExecutionConfiguration ].

				anElementFuture
					executionConfiguration: (anExecutionConfiguration
							ifNil: [ GtPhlowUtility defaultFutureExecutionConfiguration ]) ];
			matchParent;
			stencil: [ self originalElementDo: [ :anElement | anElement ] ].

	self assignMeAsEntityFor: aFutureElement.

	^ aBlock value: aFutureElement
]

{ #category : #converting }
GtPhlowTaskItView >> asTaskItView [
	^ self
]

{ #category : #accessing }
GtPhlowTaskItView >> buildContext [
	<return: #GtPhlowBuildContext>
	^ self originalView buildContext
]

{ #category : #accessing }
GtPhlowTaskItView >> buildContext: aGtPhlowBuildContext [
	self originalView buildContext: aGtPhlowBuildContext
]

{ #category : #accessing }
GtPhlowTaskItView >> definingMethod [
	"Get view defining method.
	It is a method where a view is defined."
	<return: #RGMethodDefinition>
	^ self originalView definingMethod
]

{ #category : #accessing }
GtPhlowTaskItView >> definingMethod: aRGMethodDefinition [
	"Set view defining method.
	It is a method where a view is defined."
	^ self originalView definingMethod: aRGMethodDefinition
]

{ #category : #accessing }
GtPhlowTaskItView >> definingMethodProvider [
	"Get a provider that knows how to return the method defining the view"
	<return: #RGMethodDefinition>
	^ self originalView definingMethodProvider
]

{ #category : #converting }
GtPhlowTaskItView >> ifItHasContent: aBlock [
	self originalView ifItHasContent: aBlock
]

{ #category : #initialization }
GtPhlowTaskItView >> initialize [
	super initialize.
	self originalView: self empty.
]

{ #category : #private }
GtPhlowTaskItView >> originalElementDo: anAsElementBlock [
	^ GtProcessStackOverflowChecker currentCheckerClass
		checkDuring: [ self originalView asElementDo: anAsElementBlock ]
]

{ #category : #accessing }
GtPhlowTaskItView >> originalView [
	<return: #GtPhlowView>
	^ originalView
]

{ #category : #accessing }
GtPhlowTaskItView >> originalView: aView [
	self 
		assert: [ aView notNil ]
		description: [ 'Original view must be non-nil' ].
	originalView := aView
]

{ #category : #accessing }
GtPhlowTaskItView >> priority [
	"Get view priority defining a view order.
	Lower priority is supposed to be displayed to the left."
	<return: #Number>
	^ self originalView priority
]

{ #category : #accessing }
GtPhlowTaskItView >> priority: aNumber [
	"Set view priority defining a view order.
	Lower priority is supposed to be displayed to the left."
	^ self originalView priority: aNumber
]

{ #category : #accessing }
GtPhlowTaskItView >> title [
	"Return view title, a user friendly view name.
	It is supposed to be a short name"
	^ self originalView title
]

{ #category : #accessing }
GtPhlowTaskItView >> title: aString [
	"Set view title, a user friendly view name.
	It is supposed to be a short name"
	^ self originalView title: aString
]

{ #category : #updating }
GtPhlowTaskItView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"

	aCurrentElement phlow firstChildWithViewTitle ifNotNil: [ :anElementWithView |
		anElementWithView phlow entity == self originalView
			ifTrue: [ self originalView updateContent: anElementWithView ] ]
]
