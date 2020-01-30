"
I forward a view definition to another object.
I am useful in situations when the object that has the view definition is expensive to create.
I am also useful in situtions, when the object is created only for the purpose of the view.

I create the object only if someone clicks on my tab (view).

!! Important

${method:GtPhlowView>>#title}$ and ${method:GtPhlowView>>#priority}$ are not taken from the original view. If that were the case, the advantage of the solution would be lost since the title and priority are necessary to build the view tab using the title and priority.

!! Example

You can define me as follow: ${method:GtPhlowViewMixedExamples>>#gtForwardedViewFor:|expanded=true}$

"
Class {
	#name : #GtPhlowForwarderView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'object',
		'view',
		'phlowView',
		'viewObject',
		'elementTransformation',
		'alreadyIncludesForwardedActions'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #private }
GtPhlowForwarderView >> addForwardedActions [
	self addPhlowActions: self phlowView allActions.
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> allActions [
	"I return all actions that belong to a view.
	It may include actions of a other views in some cases"
	<return: #OrderedCollection>
	alreadyIncludesForwardedActions ifFalse: [ 
		self addForwardedActions.
		alreadyIncludesForwardedActions := true ].
	^ self actions
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> allDefiningMethods [
	^ GtPhlowDefiningMethods new 
		 methods: (Array streamContents: [ :aStream | 
			self originMethodsInto: aStream ])
]

{ #category : #converting }
GtPhlowForwarderView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"
	^ self phlowView asElementDo: [ :anElement |
		[ 
			| aResult |
			aResult := self elementTransformation value: anElement.
			aBlock value: aResult.
		] on: Error do: [ :anException | 
			(self phlowErrorViewWithException: anException)
				asElementDo: [ :anErrorElement | anErrorElement ] ] ]
]

{ #category : #private }
GtPhlowForwarderView >> createPhlowView [
	<return: #GtPhlowView>
	| aView |
	aView := self on: self viewObject perform: self viewSymbol.
	aView copyAutoUpdatesFrom: self autoUpdates.
	^ aView
]

{ #category : #initialization }
GtPhlowForwarderView >> defaultTitle [
	^ 'Forwarded'
]

{ #category : #accessing }
GtPhlowForwarderView >> elementTransformation [
	^ elementTransformation
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> forwardedActions [
	<return: #OrderedCollection of: #GtPhlowAction>
	^ self phlowView actions
]

{ #category : #initialization }
GtPhlowForwarderView >> initialize [
	super initialize.
	alreadyIncludesForwardedActions := false.
	elementTransformation := #yourself.
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
GtPhlowForwarderView >> originMethodsInto: aStream [
	super originMethodsInto: aStream.
	self phlowView originMethodsInto: aStream
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> phlowView [
	^ phlowView ifNil: [ phlowView := self createPhlowView ]
]

{ #category : #private }
GtPhlowForwarderView >> secureObjectExecution [
	^ [ self object value ]
		on: Error do: [ :anException | 
			phlowView := self phlowErrorViewWithException: anException.
			anException ]
]

{ #category : #accessing }
GtPhlowForwarderView >> transformed: aSymbolOrBlock [
	self 
		assert: [ aSymbolOrBlock isNotNil ] 
		description: [ 'Forwarded element transformatin must be non-nil' ].
	elementTransformation := aSymbolOrBlock
]

{ #category : #accessing }
GtPhlowForwarderView >> view: anObject [
	view := anObject
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> viewObject [
	^ viewObject ifNil: [ viewObject := self secureObjectExecution ]
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> viewSymbol [
	^ view ifNil: [ #gtLiveFor: ]
]
