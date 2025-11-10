Class {
	#name : #GtPhlowBasicForwarderView,
	#superclass : #GtPhlowViewDecorator,
	#traits : 'TGtPhlowSendTransformable',
	#classTraits : 'TGtPhlowSendTransformable classTrait',
	#instVars : [
		'phlowView',
		'viewObject',
		'viewSymbol',
		'objectComputation'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowBasicForwarderView class >> contentId [
	<return: #BlElementId>
	^ self subclassResponsibility
]

{ #category : #testing }
GtPhlowBasicForwarderView class >> isAbstract [
	^ self name = #GtPhlowBasicForwarderView 
]

{ #category : #converting }
GtPhlowBasicForwarderView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aFutureElement aFuture |
	aFutureElement := BrFromFuture new.
	aFutureElement layout: BlLinearLayout vertical.
	aFutureElement
		configuration: (self futureExecutionConfiguration
				ifNil: [ GtPhlowUtility defaultFutureExecutionConfiguration ]).
	self beViewElement: aFutureElement.

	aFutureElement
		matchParent;
		stencil: [ BrVerticalPane new
				matchParent;
				id: #'phlow--forwarder-container' asBlocElementId;
				in: [ :thePane | self configureLayoutResizerFor: thePane ];
				yourself ];
		dataBinder: [ :aContainer :aData | 
			aContainer removeChildren.
			aData
				ifSuccess: [ :anElement | 
					[ aContainer addChild: anElement as: self class contentId ]
						on: Error
						do: [ :anError | 
							(self phlowErrorViewWithException: anError)
								asElementDo: [ :anErrorElement | 
									aContainer
										childWithId: self class contentId
										ifFound: [ :aChild | aChild removeFromParent ]
										ifNone: [  ].
									aContainer addChild: anErrorElement as: self class contentId ] ] ]
				ifError: [ :anError | 
					(self phlowErrorViewWithException: anError)
						asElementDo: [ :anErrorElement | aContainer addChild: anErrorElement as: self class contentId ] ]
				ifPending: [ | aPendingLabel |
					aPendingLabel := BrLabel new
							aptitude: (BrGlamorousLabelAptitude new italic
									foreground: BrGlamorousColors disabledHeaderTextColor);
							constraintsDo: [ :c | 
								c ignoreByLayout.
								c ignored horizontal alignCenter.
								c ignored vertical alignCenter ];
							text: 'Rendering...';
							visibility: BlVisibility gone;
							addChild: (BrButton new
									aptitude: BrGlamorousButtonWithIconAptitude;
									beSmallSize;
									icon: BrGlamorousVectorIcons cancel;
									action: [ aFutureElement cancelHard interrupt ]).

					aPendingLabel
						enqueueTask: (BlDelayedTaskAction new
								delay: 1 second;
								action: [ aPendingLabel visibility: BlVisibility visible ]).

					aContainer addChild: aPendingLabel ] ].

	aFuture := self secureElementPhlowView.
	aFutureElement future: aFuture.
	self configureLayoutResizerFor: aFutureElement.

	GtPhlowForwarderFutureElementSignal new
		futureElement: aFutureElement;
		future: aFuture;
		phlowView: self;
		emit.

	^ aBlock value: aFutureElement
]

{ #category : #accessing }
GtPhlowBasicForwarderView >> computeTargetViewForObject: aForwardedObject [
	self subclassResponsibility
]

{ #category : #converting }
GtPhlowBasicForwarderView >> configureLayoutResizerFor: anElement [
	anElement
		addAptitude: (BrLayoutResizerAptitude new
				matchParentToMatchParent: [ :aResizerBlock | anElement hasChildren ifTrue: [ aResizerBlock cull: (anElement childAt: 1) ] ];
				exactToMatchParent: [ :aResizerBlock | anElement hasChildren ifTrue: [ aResizerBlock cull: (anElement childAt: 1) ] ];
				fitContentToFitContent: [ :aResizerBlock | anElement hasChildren ifTrue: [ aResizerBlock cull: (anElement childAt: 1) ] ];
				fitContentLimitedToFitContentLimited: [ :aResizerBlock | anElement hasChildren ifTrue: [ aResizerBlock cull: (anElement childAt: 1) ] ])
]

{ #category : #private }
GtPhlowBasicForwarderView >> createPhlowView [
	<return: #TAsyncFuture of: #GtPhlowView>
	^ (self viewObject 
		map: [ :aForwardedObject | 
			aForwardedObject isSuccess
				ifTrue: [ self computeTargetViewForObject: aForwardedObject ]
				ifFalse: [ self phlowErrorViewWithException: aForwardedObject exception isFrozen: true ] ])
		on: Error
		do: [ :anException | 
			AsyncPoll ready: (self phlowErrorViewWithException: anException) ]
]

{ #category : #'accessing - computed' }
GtPhlowBasicForwarderView >> elementPhlowView [
	<return: #TAsyncFuture of: #BlElement>
	^ self phlowView
		map: [ :aPhlowView | 
			GtProcessStackOverflowChecker currentCheckerClass
				ensureCheckDuring: [ aPhlowView asElementDo: [ :anElement | anElement ] ] ]
]

{ #category : #initialization }
GtPhlowBasicForwarderView >> initialize [
	super initialize.
	self initializePhlowViewObjectCache.
	self initializePhlowViewFutureCache
]

{ #category : #initialization }
GtPhlowBasicForwarderView >> initializePhlowViewFutureCache [
	phlowView := AsyncFutureCache new
]

{ #category : #initialization }
GtPhlowBasicForwarderView >> initializePhlowViewObjectCache [
	viewObject := AsyncFutureCache new
]

{ #category : #accessing }
GtPhlowBasicForwarderView >> object [
	^ objectComputation
]

{ #category : #accessing }
GtPhlowBasicForwarderView >> object: aComputation [
	objectComputation := aComputation
]

{ #category : #'accessing - computed' }
GtPhlowBasicForwarderView >> phlowView [
	<return: #TAsyncFuture of: #GtPhlowView>

	^ AsyncCachedFuture 
		forFuture: self createPhlowView 
		cache: phlowView
]

{ #category : #'accessing - computed' }
GtPhlowBasicForwarderView >> secureElementPhlowView [
	<return: #TAsyncFuture of: #BlElement>
	^ self elementPhlowView
		on: Error
		do: [ :anError | 
			(self phlowErrorViewWithException: anError)
				asElementDo: [ :anErrorElement | anErrorElement ] ]
]

{ #category : #private }
GtPhlowBasicForwarderView >> secureObjectExecution [
	<return: #TAsyncFuture of: #TGtPhlowForwardedObject>

	^ ((self object asAsyncFuture 
		processStackOverflowChecker)
		map: [ :anObject | 
			GtPhlowForwardedObject new 
				object: anObject ])
		on: Error
		do: [ :anException |
			AsyncPoll ready: (GtPhlowForwardedException new
				freeze: anException) ]
]

{ #category : #accessing }
GtPhlowBasicForwarderView >> view: anObject [
	viewSymbol := anObject
]

{ #category : #'accessing - computed' }
GtPhlowBasicForwarderView >> viewObject [
	<return: #TAsyncFuture of: #TGtPhlowForwardedObject>
	^ AsyncCachedFuture 
		forFuture: self secureObjectExecution 
		cache: viewObject
]

{ #category : #'accessing - computed' }
GtPhlowBasicForwarderView >> viewSymbol [
	^ viewSymbol ifNil: [ #gtLiveFor: ]
]
