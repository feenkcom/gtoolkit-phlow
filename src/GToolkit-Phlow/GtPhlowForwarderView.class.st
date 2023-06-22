"
I forward a view definition to another object.
I am useful in situations when the object that has the view definition is expensive to create.
I am also useful in situtions, when the object is created only for the purpose of the view.

I create the object only if someone clicks on my tab (view).

#Important
{{gtMethod:GtPhlowView>>#title}} and {{gtMethod:GtPhlowView>>#priority}} are not taken from the original view. If that were the case, the advantage of the solution would be lost since the title and priority are necessary to build the view tab using the title and priority.

#Example
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
		'object'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowForwarderView class >> contentId [
	^ #'phlow--forwarder-content' asBlocElementId
]

{ #category : #'adding - actions' }
GtPhlowForwarderView >> actionsToolbarForElement: anElement [

	^ BrFromPromise new
		fitContent;
		stencil: [ BrToolbar new aptitude: BrGlamorousToolbarAptitude ];
		dataBinder: [ :aToolbar :aData | 
			aToolbar removeAllItems.
			aData
				ifSuccess: [ :theActions | 
					theActions do: [ :phlowAction | 
						phlowAction
							asElement: [ :actionElement | aToolbar addItem: actionElement ]
							withHostElement: anElement ] ]
				ifError: [ :anError | 
					aToolbar addItem: (BrDebuggableElementStencil new freeze: anError) createDebugButton ]
				ifPending: [  ] ];
		promise: self allActionsPromise
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> allActionsPromise [
	"I return all actions that belong to a view.
	It may include actions of a other views in some cases"

	^ self phlowView then: [ :aPhlowView | aPhlowView allActionsPromise then: [ :allActions | allActions, self actions ] ]
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
	| aPromiseElement |
	
	aPromiseElement := BrFromPromise new.
	self beViewElement: aPromiseElement.

	aPromiseElement
		matchParent;
		stencil: [ 
			BrFrame new
				matchParent ];
		dataBinder: [ :aContainer :aData |
			aContainer removeChildren.
			aData
				ifSuccess: [ :aPhlowView |
					aPhlowView asElementDo: [ :anElement |
						[ aContainer addChild: anElement as: self class contentId ]
							on: Error
							do: [ :anException |
								(self phlowErrorViewWithException: anException)
									asElementDo: [ :anErrorElement | aContainer addChild: anErrorElement ] ] ] ]
				ifError: [ :anError | (self phlowErrorViewWithException: anError) asElementDo: [ :anErrorElement | aContainer addChild: anErrorElement as: self class contentId ] ]
				ifPending: [
					| aPendingLabel |
					
					aPendingLabel := BrLabel new
						aptitude: (BrGlamorousLabelAptitude new italic foreground: BrGlamorousColors disabledHeaderTextColor);
						constraintsDo: [ :c | 
							c ignoreByLayout.
							c ignored horizontal alignCenter.
							c ignored vertical alignCenter ];
						text: ''.

					aPendingLabel enqueueTask: (BlDelayedTaskAction new
						delay: 1 second;
						action: [ aPendingLabel text: 'Rendering...' ]). 

					aContainer addChild: aPendingLabel ] ].
	
	aPromiseElement promise: self phlowView.
	
	^ aBlock value: aPromiseElement
]

{ #category : #private }
GtPhlowForwarderView >> createPhlowView [

	<return: #TAsyncPromise of: #GtPhlowView>
	^ self viewObject
		then: [ :aForwardedObject | 
		  | aView |
		  aView := self on: aForwardedObject object perform: self viewSymbol.
		  self hasTransformation ifTrue: [ 
			  aView copyTransformationFrom: self transformation ].
		  aView ] 
		otherwise: [ :anException |
			phlowView := (self phlowErrorViewWithException: anException) asAsyncPromise.
			phlowView ]
]

{ #category : #initialization }
GtPhlowForwarderView >> defaultTitle [
	^ 'Forwarded'
]

{ #category : #initialization }
GtPhlowForwarderView >> initialize [
	super initialize.

	asyncEnabled := false
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
	self phlowView wait originMethodsInto: aStream
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> phlowView [
	<return: #TAsyncPromise of: #GtPhlowView>

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
	<return: #TAsyncPromise>

	^ (self object asAsyncFuture map: [ :anObject | GtPhlowForwardedObject new object: anObject ])
		asAsyncPromise
			then: [ :anObject | anObject ]
			otherwise: [ :anException |
				phlowView := (self phlowErrorViewWithException: anException) asAsyncPromise.
				anException asAsyncPromise ]
]

{ #category : #updating }
GtPhlowForwarderView >> updateContent: aCurrentElement [
	self phlowView wait updateContent: aCurrentElement
]

{ #category : #accessing }
GtPhlowForwarderView >> view: anObject [
	view := anObject
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> viewObject [
	<return: #AsyncPromise of: #Object>

	^ viewObject ifNil: [ viewObject := self secureObjectExecution ]
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> viewSymbol [
	^ view ifNil: [ #gtLiveFor: ]
]

{ #category : #'api - accessing composite view' }
GtPhlowForwarderView >> views [
	<return: #Array of: #GtPhlowView>

	^ (self phlowView then: [ :aView | aView views ]) wait
]
