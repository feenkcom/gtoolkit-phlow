"
I offer the Phlow navigation API over the Bloc element tree starting with the specific element I am tied with.


"
Class {
	#name : #GtPhlowElementContext,
	#superclass : #Object,
	#instVars : [
		'entity',
		'element',
		'isView',
		'isAction',
		'isViewContent',
		'isPopupContainer',
		'isException',
		'isTool',
		'isToolLabel',
		'toolViewModel'
	],
	#category : #'GToolkit-Phlow-Context'
}

{ #category : #'instance creation' }
GtPhlowElementContext class >> on: anElement [
	^ self new element: anElement
]

{ #category : #'api - tool view model' }
GtPhlowElementContext >> accessTool: aType viewModel: aViewModelSelector object: anObjectSelector [
	toolViewModel := GtPhlowToolCommonViewModel new
			context: self;
			type: aType;
			viewModelSelector: aViewModelSelector;
			objectSelector: anObjectSelector
]

{ #category : #accessing }
GtPhlowElementContext >> activePhlowContexts [
	^ {
	#view -> self isView.
	#viewContent -> self isViewContent.
	#action -> self isAction.
	#exception -> self isException.
	#popupContainer -> self isPopupContainer.
	#tool -> self isTool.
	#toolLabel -> self isToolLabel}
		select: [ :assoc | assoc value ]
		thenCollect: [ :assoc | assoc key ]
]

{ #category : #accessing }
GtPhlowElementContext >> activePhlowContextsDescription [
	^ String streamContents: [ :aStream | 
		self activePhlowContexts
			do: [:elem | aStream nextPutAll: elem printString]
			separatedBy: [aStream nextPutAll: ', '] ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> allChildrenWithAction [
	^ self element 
		allChildrenBreadthFirstSelect: [ :child | child phlow isAction ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> allChildrenWithView [
	<return: #Array of: #BrTab>
	| aTab |
	aTab := self firstChildWithView.
	aTab ifNil: [ ^ #() ].
	^ aTab parent children select: [ :child | child phlow isView ]
]

{ #category : #asserting }
GtPhlowElementContext >> assertIncomingView: aGtPhlowView [
	self
		assert: [ aGtPhlowView isNotNil ]
		description: [ 'Phlow view must be non-nil' ]
]

{ #category : #'api - updating' }
GtPhlowElementContext >> asyncUpdate [
	BlUseAsyncFeatures
		ifEnabledDo: [ self postponeUpdate ]
		otherwise: [ self syncUpdate ]
]

{ #category : #'api - initialization' }
GtPhlowElementContext >> beAction [
	isAction := true
]

{ #category : #'api - initialization' }
GtPhlowElementContext >> beException [
	isException := true
]

{ #category : #'api - initialization' }
GtPhlowElementContext >> bePopupContainer [
	isPopupContainer := true
]

{ #category : #'api - initialization' }
GtPhlowElementContext >> beTool [
	isTool := true
]

{ #category : #'api - initialization' }
GtPhlowElementContext >> beToolLabel [
	isToolLabel := true
]

{ #category : #'api - initialization' }
GtPhlowElementContext >> beView [
	isView := true
]

{ #category : #'api - initialization' }
GtPhlowElementContext >> beViewContent [
	isViewContent := true
]

{ #category : #'api - convenience' }
GtPhlowElementContext >> buildContext [
	<return: #GtPhlowBuildContext>
	^ self entity buildContext
]

{ #category : #'api - events' }
GtPhlowElementContext >> composite [
	self
		deprecated: 'Please use compositeTool method instead.'
		transformWith:
			'`@receiver composite'
				-> '`@receiver compositeTool'.
	^ self compositeTool
]

{ #category : #'api - events' }
GtPhlowElementContext >> compositeTool [
	^ GtPhlowCompositeToolBuilder new context: self
]

{ #category : #'api - convenience' }
GtPhlowElementContext >> definingMethod [
	<return: #RGMethodDefinition>
	^ self entity definingMethod
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> element [
	^ element
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> element: anElement [
	self 
		assert: [ anElement isNotNil ] 
		description: [ 'Element must be non-nil' ].
	self 
		assert: [ element isNil ] 
		description: [ 'Context element can be initialized only once' ].
	element := anElement
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> entity [
	^ entity
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> entity: aGtPhlowView [
	self assertIncomingView: aGtPhlowView.
	self
		assert: [ entity isNil ]
		description: [ 'Context entity (Phlow view) can be initialized only once' ].
	entity := aGtPhlowView
]

{ #category : #'api - updating' }
GtPhlowElementContext >> fireToolUpdateWish [
	"I fire an update wish to inform a whole tool, e.g., Inspector, that it should update its widgets"

	self element
		enqueueTask: (BlTaskAction new action: [ self element fireEvent: BrPhlowToolUpdateWish new ])
]

{ #category : #'api - updating' }
GtPhlowElementContext >> fireUpdateWish [
	self
		deprecated: 'Use #fireToolUpdateWish instead'
		transformWith: '`@receiver fireUpdateWish' -> '`@receiver fireToolUpdateWish'
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithAction [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | child phlow isAction ] 
		ifFound: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithCompositeView [
	^ self firstChildWithCompositeViewDo: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithCompositeViewDo: aBlock [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | 
			child phlow isView and: [ child phlow entity isKindOf: GtPhlowCompositeView ] ] 
		ifFound: aBlock
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithView [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | child phlow isView ] 
		ifFound: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstParentWithView [
	^ self element 
		allParentsDetect: [ :parent | parent phlow isView ] 
		ifFound: [ :parent | parent ]
		ifNone: [ "nothing" ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstPopupContainerParentDo: aBlock ifNone: aNoneBlock [
	self element withAllParentsDo: [ :aParentElement |
			aParentElement phlow isPopupContainer ifTrue: [ ^ aBlock value: aParentElement ] ].
		
	^ aNoneBlock value
]

{ #category : #accessing }
GtPhlowElementContext >> forwardViewObjectFromViewAction [
	^ self firstParentWithView content phlow firstChildWithView phlow entity viewObject wait object
]

{ #category : #accessing }
GtPhlowElementContext >> gtActionSourceFor: aView [
	<gtView>
	self isAction ifFalse: [ ^ aView empty ].
	^ aView forward 
		title: 'Source';
		priority: 20;
		object: [ self entity ];
		view: #gtDefiningMethodFor:
]

{ #category : #accessing }
GtPhlowElementContext >> gtViewSourceFor: aView [
	<gtView>
	self isView ifFalse: [ ^ aView empty ].
	^ aView forward 
		title: 'Source';
		priority: 20;
		object: [ self entity ];
		view: #gtDefiningMethodFor:
]

{ #category : #testing }
GtPhlowElementContext >> hasActivePhlowContexts [
	^ self activePhlowContexts size > 0
]

{ #category : #'api - testing' }
GtPhlowElementContext >> hasBuildContext [
	^ self entity hasBuildContext
]

{ #category : #initialization }
GtPhlowElementContext >> initialize [
	super initialize.
	
	isAction := false.
	isView := false.
	isViewContent := false.
	isPopupContainer := false.
	isException := false.
	isTool := false.
	isToolLabel := false.
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isAction [
	^ isAction
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isException [
	^ isException
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isPopupContainer [
	^ isPopupContainer
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isTool [
	^ isTool
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isToolLabel [
	^ isToolLabel
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isView [
	^ isView
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isViewContent [
	^ isViewContent
]

{ #category : #'api - convenience' }
GtPhlowElementContext >> methodSelector [
	<return: #Symbol>
	^ self entity methodSelector
]

{ #category : #updating }
GtPhlowElementContext >> postponeUpdate [
	([ self syncUpdate ] asAsyncFuture 
		delayed: 300 milliSeconds)
			await: GtPhlowUtility defaultFutureExecutionConfiguration
]

{ #category : #accessing }
GtPhlowElementContext >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [ 
		aStream << self activePhlowContextsDescription]
]

{ #category : #'api - updating' }
GtPhlowElementContext >> replaceEntity: aNewPhlow [
	self assertIncomingView: aNewPhlow.
	self 
		assert: [ self entity isNotNil ] 
		description: [ 'I cannot replace entity that is not initialized' ].
	entity := aNewPhlow.
]

{ #category : #'api - events' }
GtPhlowElementContext >> selectObject: anObject [
	self selectTool: anObject gtDefaultInspectorTool
]

{ #category : #'api - events' }
GtPhlowElementContext >> selectTool: aTool [
	self element fireEvent: (GtPhlowObjectToSelect new
		tool: aTool;
		sourceElement: self element) 
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnDefiningMethod [
	self entity
		ifNotNil: [ :anEntity | anEntity definingMethod ifNotNil: [ :aMethod | self spawnObject: aMethod ] ]
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnObject: anObject [
	self spawnTool: anObject gtDefaultInspectorTool
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnObject: anObject withDestination: aPhlowDestination [
	self 
		spawnTool: anObject gtDefaultInspectorTool
		withDestination: aPhlowDestination
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnTool: aTool [
	self 
		spawnTool: aTool 
		withDestination: GtPhlowSpawnDesiredDestination defaultDestination
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnTool: aTool withDestination: aPhlowDestination [
	self element fireEvent: (GtPhlowObjectToSpawn new
		tool: aTool;
		spawnDestination: aPhlowDestination;
		sourceElement: self element)
]

{ #category : #'api - updating' }
GtPhlowElementContext >> syncUpdate [
	self entity updateContent: self element.
]

{ #category : #'api - search' }
GtPhlowElementContext >> textViewContent [
	self assert: [ self isAction ].
	^ self viewContent
		allChildrenBreadthFirstDetect: [ :each | each isKindOf: BrEditorElement ] 
		ifFound: [:editorElement | editorElement editor text ]
]

{ #category : #'api - tool view model' }
GtPhlowElementContext >> toolViewModel [
	"Return a tool view model"

	<return: #TGtPhlowToolViewModel>
	^ toolViewModel
]

{ #category : #'api - tool view model' }
GtPhlowElementContext >> toolViewModel: anObject [
	toolViewModel := anObject
]

{ #category : #'api - updating' }
GtPhlowElementContext >> update [
	self asyncUpdate
]

{ #category : #'api - updating' }
GtPhlowElementContext >> updateEntity: aNewPhlow [
	self assertIncomingView: aNewPhlow.
	self entity 
		ifNil: [ self entity: aNewPhlow ]
		ifNotNil: [ self replaceEntity: aNewPhlow ].
]

{ #category : #'api - search' }
GtPhlowElementContext >> viewContent [
	self assert: [ self isAction ].
	^ self firstParentWithView phlow firstChildWithView parentTabGroup content
]
