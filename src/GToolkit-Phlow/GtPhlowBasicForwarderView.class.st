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

{ #category : #testing }
GtPhlowBasicForwarderView class >> isAbstract [
	^ self name = #GtPhlowBasicForwarderView 
]

{ #category : #converting }
GtPhlowBasicForwarderView >> asElementDo: aBlock [
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
									asElementDo: [ :anErrorElement | 
										aContainer addChild: anErrorElement ] ] ] ]
				ifError: [ :anError | 
					(self phlowErrorViewWithException: anError) 
						asElementDo: [ :anErrorElement | 
							aContainer 
								addChild: anErrorElement 
								as: self class contentId ] ]
				ifPending: [
					| aPendingLabel |
					
					aPendingLabel := BrLabel new
						aptitude: (BrGlamorousLabelAptitude new italic 
							foreground: BrGlamorousColors disabledHeaderTextColor);
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

{ #category : #accessing }
GtPhlowBasicForwarderView >> computeTargetViewForObject: aForwardedObject [
	self subclassResponsibility
]

{ #category : #private }
GtPhlowBasicForwarderView >> createPhlowView [
	<return: #TAsyncPromise of: #GtPhlowView>
	^ self viewObject
		then: [ :aForwardedObject | 
			self computeTargetViewForObject: aForwardedObject ]
		otherwise: [ :anException | 
			phlowView := (self phlowErrorViewWithException: anException) asAsyncPromise.
			phlowView ]
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
	<return: #TAsyncPromise of: #GtPhlowView>

	^ phlowView ifNil: [ phlowView := self createPhlowView ]
]

{ #category : #private }
GtPhlowBasicForwarderView >> secureObjectExecution [
	<return: #TAsyncPromise>

	^ (self object asAsyncFuture map: [ :anObject | GtPhlowForwardedObject new object: anObject ])
		asAsyncPromise
			then: [ :anObject | anObject ]
			otherwise: [ :anException |
				phlowView := (self phlowErrorViewWithException: anException) asAsyncPromise.
				anException asAsyncPromise ]
]

{ #category : #accessing }
GtPhlowBasicForwarderView >> view: anObject [
	viewSymbol := anObject
]

{ #category : #'accessing - computed' }
GtPhlowBasicForwarderView >> viewObject [
	<return: #AsyncPromise of: #Object>

	^ viewObject ifNil: [ viewObject := self secureObjectExecution ]
]

{ #category : #'accessing - computed' }
GtPhlowBasicForwarderView >> viewSymbol [
	^ viewSymbol ifNil: [ #gtLiveFor: ]
]
