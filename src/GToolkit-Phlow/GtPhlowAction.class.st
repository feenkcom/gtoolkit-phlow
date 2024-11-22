Class {
	#name : #GtPhlowAction,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtPhlowActionTooltipBuilder',
	#classTraits : 'TBlDebug classTrait + TGtPhlowActionTooltipBuilder classTrait',
	#instVars : [
		'definingMethod',
		'priority',
		'target',
		'id'
	],
	#category : #'GToolkit-Phlow-! Actions'
}

{ #category : #defaults }
GtPhlowAction class >> defaultPriority [
	^ 50
]

{ #category : #accessing }
GtPhlowAction class >> noAction [
	^ GtPhlowNoAction new
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #converting }
GtPhlowAction >> asElement: aBlock withHostElement: aTargetElement [
	"Return an element that represents the action in Bloc space, e.g., a button"
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #converting }
GtPhlowAction >> attachShowDefinitionEventHandler: element [
	element addAptitude: (GtPhlowBrowseDefinitionAptitude new
		definition: [ self definingMethod ]).
]

{ #category : #'message performing' }
GtPhlowAction >> basicOn: anObject perform: aMessageSymbol withArguments: aCollectionOfArguments [
	<return: #GtPhlowAction>
	<gtCollector>
	| phlowAction |
	
	phlowAction := thisContext
		object: anObject
		perform: aMessageSymbol
		withArguments: aCollectionOfArguments
		inClass: anObject class.
		
	phlowAction = self ifTrue: [
		Error signal: 'Cannot return the same action'.
		"GtPhlowViewsCollectorSameViewError 
			signalForViewSelector: aMessageSymbol
			fromObject: anObject" ].
			
	"phlowAction object: anObject arguments: aCollectionOfArguments."
	^ phlowAction
]

{ #category : #decorating }
GtPhlowAction >> button [
	^ GtPhlowButtonAction new
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #initialization }
GtPhlowAction >> defaultPriority [
	^ self class defaultPriority
]

{ #category : #initialization }
GtPhlowAction >> defaultTarget [
	^ GtPhlowObjectActionTarget uniqueInstance
]

{ #category : #accessing }
GtPhlowAction >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtPhlowAction >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #'error handling' }
GtPhlowAction >> definingMethodForObject: anObject andSelector: aMessageSymbol [
	| aNilOrClassName |
	aNilOrClassName := anObject class 
		whichClassIncludesSelector: aMessageSymbol.
	^ aNilOrClassName 
		ifNil: [ RGMethodDefinition new 
			name: aMessageSymbol;
			parentName: anObject class name;
			isMetaSide: anObject class isMeta;
			asActive ] 
		ifNotNil: [ (aNilOrClassName >> aMessageSymbol) asRingDefinition ]
]

{ #category : #accessing }
GtPhlowAction >> definingSelector [
	^ self definingMethod selector
]

{ #category : #decorating }
GtPhlowAction >> dropdown [
	^ GtPhlowDropdownAction new
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #decorating }
GtPhlowAction >> empty [
	"Convenience --by analogy with views"

	^ self noAction
]

{ #category : #'private - message performing' }
GtPhlowAction >> ensureContext [
	^ GtPhlowContext new
]

{ #category : #decorating }
GtPhlowAction >> explicit [
	^ GtPhlowExplicitAction new
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #accessing }
GtPhlowAction >> forViewDefinedIn: aSymbol [
	"Symbol is a method name where a view is defined.
	Such Phlow action will be displayed in a given view."
	self 
		assert: [ aSymbol notNil ]
		description: [ 'Phlow view action target must be non-nil' ].
	self target: (GtPhlowViewActionTarget new definingMethodSelector: aSymbol)
]

{ #category : #'gt-extension' }
GtPhlowAction >> gtDefiningMethodFor: aView [
	<gtView>
	self definingMethod ifNil: [ ^ aView empty ].
	^ (self definingMethod gtSourceFor: aView)
			priority: 2
]

{ #category : #'gt-extension' }
GtPhlowAction >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ self asElement: [ :x | x ] withHostElement: nil ];
		actionButtonIcon: BrGlamorousVectorIcons play
			action: [ :aButton | aButton phlow 
				spawnObject: (self asElement: [ :x | x ] withHostElement: nil) ]
]

{ #category : #accessing }
GtPhlowAction >> help: aString [
	"Ignored for now. Suppose to be a tooltip explaining a button action"
]

{ #category : #accessing }
GtPhlowAction >> id [

	^ id
]

{ #category : #accessing }
GtPhlowAction >> id: anElementId [

	id := anElementId
]

{ #category : #initialization }
GtPhlowAction >> initialize [
	super initialize.
	
	target := self defaultTarget.
	priority := self defaultPriority.
	self initializeTooltipBuilder
]

{ #category : #testing }
GtPhlowAction >> isDefaultTarget [

	self target targetsDo: [ :eachTarget | 
		eachTarget = self defaultTarget ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #testing }
GtPhlowAction >> isDefinitionRequested: anEvent [
	"Return true, if a user wants to see an action definition"

	<return: #Boolean>
	^ GtPhlowUtility isDefinitionRequested: anEvent
]

{ #category : #'api - action' }
GtPhlowAction >> label [
	^ self subclassResponsibility
]

{ #category : #decorating }
GtPhlowAction >> noAction [
	^ GtPhlowNoAction new
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #'message performing' }
GtPhlowAction >> on: anObject perform: aMessageSymbol [
	<return: #GtPhlowAction>
	<gtCollector>
	
	^ self 
		on: anObject 
		perform: aMessageSymbol 
		withSomeArguments: { 
			  self.
			  self ensureContext }
]

{ #category : #'message performing' }
GtPhlowAction >> on: anObject perform: aMessageSymbol withArguments: aCollectionOfArguments [
	<return: #GtPhlowAction>
	<gtCollector>
	
	^ [ 
			self 
				basicOn: anObject 
				perform: aMessageSymbol 
				withArguments: aCollectionOfArguments
	
	] on: Error do: [ :anException |
		
			NonInteractiveTranscript stdout
				nextPut: $[;
				nextPutAll: self class name;
				nextPut: $];
				space;
				print: anException;
				cr.
			
			self 
				phlowErrorActionWithException: anException 
				forBuildContext: (GtPhlowBuildContext new 
					object: anObject; 
					arguments: aCollectionOfArguments) 
				andSelector: aMessageSymbol ]
]

{ #category : #'message performing' }
GtPhlowAction >> on: anObject perform: aMessageSymbol withContext: aContext [
	<return: #GtPhlowAction>
	<gtCollector>
	
	^ self 
		on: anObject 
		perform: aMessageSymbol 
		withSomeArguments: { self. aContext }
]

{ #category : #'message performing' }
GtPhlowAction >> on: anObject perform: aMessageSymbol withSomeArguments: aCollectionOfArguments [
	<return: #GtPhlowAction>
	<gtCollector>
	| aNewCollectionOfArguments |
	
	aCollectionOfArguments size = aMessageSymbol numArgs ifTrue: [ 
		^ self 
			on: anObject 
			perform: aMessageSymbol 
			withArguments: aCollectionOfArguments ].
			
	aNewCollectionOfArguments := aCollectionOfArguments 
		copyFrom: 1 
		to: aMessageSymbol numArgs.
		
	^ self 
		on: anObject 
		perform: aMessageSymbol 
		withArguments: aNewCollectionOfArguments
]

{ #category : #'api - action' }
GtPhlowAction >> performActionOn: anActionElement [
	self subclassResponsibility
]

{ #category : #'message performing' }
GtPhlowAction >> phlowErrorActionWithException: anException [
	
	anException freeze.
	
	^ GtPhlowActionWithError new
		error: anException
]

{ #category : #'message performing' }
GtPhlowAction >> phlowErrorActionWithException: anException  forBuildContext: aContext andSelector: aMessageSymbol [
	| aDefiningMethod phlowErrorAction | 
	
	aDefiningMethod := self 
		definingMethodForObject: aContext object andSelector: aMessageSymbol. 
	phlowErrorAction := self phlowErrorActionWithException: anException.
	phlowErrorAction definingMethod: aDefiningMethod.
	"phlowErrorAction buildContext: aContext."
	
	^ phlowErrorAction
]

{ #category : #accessing }
GtPhlowAction >> priority [
	^ priority
]

{ #category : #accessing }
GtPhlowAction >> priority: aNumber [
	priority := aNumber
]

{ #category : #accessing }
GtPhlowAction >> target [
	<return: #GtPhlowActionTarget>
	^ target
]

{ #category : #accessing }
GtPhlowAction >> target: aGtPhlowActionTarget [
	self 
		assert: [ aGtPhlowActionTarget notNil ]
		description: [ 'Phlow action target must be non-nil' ].
	target := aGtPhlowActionTarget
]

{ #category : #decorating }
GtPhlowAction >> toggle [
	^ GtPhlowToggleAction new
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]
