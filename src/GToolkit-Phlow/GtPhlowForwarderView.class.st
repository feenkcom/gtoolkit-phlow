"
I forward a view definition to another object.
I am useful in situations when the object that has the view definition is expensive to create.
I am also useful in situtions, when the object is created only for the purpose of the view.

I create the object only if someone clicks on my tab (view).

1. # Important


{{gtMethod:GtPhlowView>>#title}} and {{gtMethod:GtPhlowView>>#priority}} are not taken from the original view. If that were the case, the advantage of the solution would be lost since the title and priority are necessary to build the view tab using the title and priority.

1. # Example


You can define me as follow: {{gtMethod:GtPhlowForwarderViewExamples>>#gtBasicFor:|expanded=true}}


"
Class {
	#name : #GtPhlowForwarderView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowSendTransformable',
	#classTraits : 'TGtPhlowSendTransformable classTrait',
	#instVars : [
		'view',
		'phlowView',
		'viewObject',
		'alreadyIncludesForwardedActions',
		'object'
	],
	#category : 'GToolkit-Phlow-! Views'
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
			self beViewElement: anElement.
			aBlock value: anElement.
		] on: Error do: [ :anException | 
			(self phlowErrorViewWithException: anException)
				asElementDo: [ :anErrorElement | anErrorElement ] ] ]
]

{ #category : #'private - elements' }
GtPhlowForwarderView >> assignMeAsEntityFor: anElement [
	anElement phlow replaceEntity: self.
]

{ #category : #private }
GtPhlowForwarderView >> createPhlowView [
	<return: #GtPhlowView>
	| aView |
	aView := self on: self viewObject perform: self viewSymbol.
	self hasTransformation ifTrue: [ 
		aView copyTransformationFrom: self transformation ].
	^ aView
]

{ #category : #initialization }
GtPhlowForwarderView >> defaultTitle [
	^ 'Forwarded'
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
	<return: #GtPhlowView>
	^ phlowView ifNil: [ phlowView := self createPhlowView ]
]

{ #category : #'private - elements' }
GtPhlowForwarderView >> resubscribeFrom: aCurrentElement to: aNewChild [
	aNewChild = aCurrentElement ifTrue: [ ^ self ].
	aNewChild isAttachedToSceneGraph ifFalse: [ ^ self ].
	self subscribeAutoUpdatesOn: aNewChild phlow
]

{ #category : #private }
GtPhlowForwarderView >> secureObjectExecution [
	^ [ self object value ]
		on: Error do: [ :anException | 
			phlowView := self phlowErrorViewWithException: anException.
			anException ]
]

{ #category : #updating }
GtPhlowForwarderView >> updateContent: aCurrentElement [
	| aParent anIndex aNewChild |
	aParent := aCurrentElement parent.
	aParent ifNil: [ ^ self ].
	anIndex := aParent childIndexOf: aCurrentElement.
	self phlowView updateContent: aCurrentElement.
	self
		enqueueAction: [ 
			aNewChild := aParent childAt: anIndex.
			self beViewElement: aNewChild.
			self resubscribeFrom: aCurrentElement to: aNewChild ]
		in: aParent
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

{ #category : #'api - accessing composite view' }
GtPhlowForwarderView >> views [
	<return: #Array of: #GtPhlowView>
	^ self phlowView views
]
