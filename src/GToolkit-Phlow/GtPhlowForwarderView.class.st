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
	#superclass : #GtPhlowBasicForwarderView,
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

{ #category : #private }
GtPhlowForwarderView >> computeTargetViewForObject: aForwardedObject [
	| aView |
	aView := self on: aForwardedObject object perform: self viewSymbol.
	self hasTransformation
		ifTrue: [ aView copyTransformationFrom: self transformation ].
	^ aView
]

{ #category : #initialization }
GtPhlowForwarderView >> defaultTitle [
	^ 'Forwarded'
]

{ #category : #accessing }
GtPhlowForwarderView >> definingMethod: aMethod [
	definingMethodProvider := GtPhlowForwardViewDefiningMethodProvider new
		phlowForwardView: self;
		definingMethod: aMethod
]

{ #category : #initialization }
GtPhlowForwarderView >> initialize [
	super initialize.

	asyncEnabled := false
]

{ #category : #'accessing - computed' }
GtPhlowForwarderView >> originMethodsInto: aStream [
	super originMethodsInto: aStream.
	
	self phlowView wait 
		originMethodsInto: aStream
]

{ #category : #'private - elements' }
GtPhlowForwarderView >> resubscribeFrom: aCurrentElement to: aNewChild [
	aNewChild = aCurrentElement ifTrue: [ ^ self ].
	aNewChild isAttachedToSceneGraph ifFalse: [ ^ self ].
	self subscribeAutoUpdatesOn: aNewChild phlow
]

{ #category : #updating }
GtPhlowForwarderView >> updateContent: aCurrentElement [
	self phlowView wait updateContent: aCurrentElement
]

{ #category : #'api - accessing composite view' }
GtPhlowForwarderView >> views [
	<return: #Array of: #GtPhlowView>

	^ (self phlowView then: [ :aView | aView views ]) wait
]
