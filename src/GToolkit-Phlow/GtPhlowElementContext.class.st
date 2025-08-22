"
I offer the Phlow navigation API over the Bloc element tree starting with the specific element I am tied with.


"
Class {
	#name : #GtPhlowElementContext,
	#superclass : #Object,
	#instVars : [
		'entity',
		'element',
		'isAction',
		'isViewContent',
		'isPopupContainer',
		'isException',
		'isTool',
		'isToolLabel',
		'toolViewModel',
		'isViewTitle',
		'updateElementFuture'
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
	#viewTitle -> self isViewTitle.
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
	self
		deprecated: 'Use #allChildrenWithViewTitle'
		transformWith: '`@receiver allChildrenWithView' -> '`@receiver allChildrenWithViewTitle'.
	
	^ self allChildrenWithViewTitle
]

{ #category : #'api - search' }
GtPhlowElementContext >> allChildrenWithViewTitle [
	<return: #Array of: #BrTab>
	| aTab |
	aTab := self firstChildWithViewTitle.
	aTab ifNil: [ ^ #() ].
	^ aTab parent children select: [ :child | child phlow isViewTitle ]
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
	self
		deprecated: 'Use #beViewTitle'
		transformWith: '`@receiver beView' -> '`@receiver beViewTitle'.

	self beViewTitle
]

{ #category : #'api - initialization' }
GtPhlowElementContext >> beViewContent [
	isViewContent := true
]

{ #category : #'api - initialization' }
GtPhlowElementContext >> beViewTitle [
	isViewTitle := true
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

{ #category : #'api - search' }
GtPhlowElementContext >> contextMenuAnchorElement [
	"Return element to which a context menu (or dropdown) is attached."

	<return: #BlElement or: nil>
	| anEvent |
	anEvent := BrPopoverAnchorElementWish new.
	self element fireEvent: anEvent.
	anEvent anchorElementDo: [ :anItemElement | ^ anItemElement ].
	^ nil
]

{ #category : #'api - search' }
GtPhlowElementContext >> contextMenuAnchorElementFirstParentWithViewContent [
	"Return view content element to which a context menu (or dropdown) is attached."

	<return: #BlElement or: nil>
	^ self contextMenuAnchorElement
		ifNotNil: [ :anAnchorElement | anAnchorElement phlow firstParentWithViewContent ]
]

{ #category : #'api - updating' }
GtPhlowElementContext >> contextMenuFireToolUpdateWish [
	"I fire an update wish to inform a whole tool, e.g., Inspector, that it should update its widgets"

	^ self contextMenuAnchorElementFirstParentWithViewContent
		ifNotNil: [ :anElement | 
			BlTaskAction
				enqueueElement: anElement
				action: [ self element fireEvent: GtPhlowToolUpdateWish new ] ]
]

{ #category : #'api - updating' }
GtPhlowElementContext >> contextMenuUpdateViewContent [
	"Updated a view content element to which a context menu (or dropdown) is attached."

	^ self contextMenuAnchorElementFirstParentWithViewContent
		ifNotNil: [ :anElement | anElement phlow update ]
]

{ #category : #'api - convenience' }
GtPhlowElementContext >> definingMethod [
	<return: #RGMethodDefinition>
	^ self entity ifNotNil: #definingMethod
]

{ #category : #'api - events' }
GtPhlowElementContext >> deselectPreviousEvent: aPreviousDeselectEvent [
	| aNewEvent |
	aNewEvent := GtPhlowObjectToDeselect new
			tool: aPreviousDeselectEvent tool;
			sourceElement: aPreviousDeselectEvent sourceElement.
	aPreviousDeselectEvent properties keysAndValuesDo: [ :aKey :aValue | 
		aNewEvent propertyAt: aKey put: aValue ].
	
	self element fireEvent: aNewEvent.
	aPreviousDeselectEvent consumed: aNewEvent isConsumed.
	
	^ aNewEvent
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> element [
	^ element
]

{ #category : #'api - accessing' }
GtPhlowElementContext >> element: anElement [
	self assert: [ anElement isNotNil ] description: [ 'Element must be non-nil' ].
	self
		assert: [ element isNil ]
		description: [ 'Context element can be initialized only once' ].
	element := anElement.
	updateElementFuture := (BrAsyncElementFuture on: anElement)
			executionConfiguration: GtPhlowUtility defaultFutureExecutionConfiguration;
			whenSuccess: [ :theElement :aData | "do nothing" ]
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

	self element fireEvent: GtPhlowToolUpdateWish new
]

{ #category : #'api - updating' }
GtPhlowElementContext >> fireUpdateWish [
	self
		deprecated: 'Use #fireToolUpdateWish instead'
		transformWith: '`@receiver fireUpdateWish' -> '`@receiver fireToolUpdateWish'
]

{ #category : #'api - updating' }
GtPhlowElementContext >> fireViewUpdateWish [
	"I fire an update wish to inform a Phlow view, that it should update its widgets"

	self element fireEvent: GtPhlowViewUpdateWish new
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithAction [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | child phlow isAction ] 
		ifFound: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithCompositeView [
	self
		deprecated: 'Use #firstChildWithCompositeViewContent'
		transformWith: '`@receiver firstChildWithCompositeView' 
			-> '`@receiver firstChildWithCompositeViewContent'.
	
	^ self firstChildWithCompositeViewContent
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithCompositeViewContent [
	^ self firstChildWithCompositeViewContentDo: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithCompositeViewContentDo: aBlock [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | 
			child phlow isViewContent and: [ child phlow entity isKindOf: GtPhlowCompositeView ] ] 
		ifFound: aBlock
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithCompositeViewDo: aBlock [
	self
		deprecated: 'Use #firstChildWithCompositeViewContentDo:'
		transformWith: '`@receiver firstChildWithCompositeViewDo: `@args' 
			-> '`@receiver firstChildWithCompositeViewContentDo: `@args'.
	
	^ self firstChildWithCompositeViewContentDo: aBlock
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithView [
	self
		deprecated: 'Use #firstChildWithViewContent'
		transformWith: '`@receiver firstChildWithView' -> '`@receiver firstChildWithViewContent'.
	
	^ self firstChildWithViewContent
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithViewContent [
	<return: #BlElement or: nil>
	^ self element
		allChildrenBreadthFirstDetect: [ :child | child phlow isViewContent ]
		ifFound: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstChildWithViewTitle [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | child phlow isViewTitle ] 
		ifFound: [ :child | child ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstParentWithView [
	self
		deprecated: 'Use #firstParentWithViewContent'
		transformWith: '`@receiver firstParentWithView' -> '`@receiver firstParentWithViewContent'.
	
	^ self firstParentWithViewContent
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstParentWithViewContent [
	^ self element 
		allParentsDetect: [ :parent | parent phlow isViewContent ] 
		ifFound: [ :parent | parent ]
		ifNone: [ self error: 'Couldn''t find a view content parent' ]
]

{ #category : #'api - search' }
GtPhlowElementContext >> firstPopupContainerParentDo: aBlock ifNone: aNoneBlock [
	self element withAllParentsDo: [ :aParentElement |
			aParentElement phlow isPopupContainer ifTrue: [ ^ aBlock value: aParentElement ] ].
		
	^ aNoneBlock value
]

{ #category : #accessing }
GtPhlowElementContext >> forwardViewObjectFromViewAction [
	^ self firstParentWithViewContent content phlow firstChildWithViewTitle phlow entity viewObject wait object
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
	self isViewTitle
		ifFalse: [ ^ aView empty ].
		
	self isViewContent
		ifFalse: [ ^ aView empty ].

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
	isViewTitle := false.
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
	self
		deprecated: 'Use #beViewTitle'
		transformWith: '`@receiver isView' -> '`@receiver isViewTitle'.

	^ self isViewTitle
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isViewContent [
	^ isViewContent
]

{ #category : #'api - testing' }
GtPhlowElementContext >> isViewTitle [
	^ isViewTitle
]

{ #category : #'api - convenience' }
GtPhlowElementContext >> methodSelector [
	<return: #Symbol>
	^ self entity methodSelector
]

{ #category : #updating }
GtPhlowElementContext >> postponeUpdate [
	| aFuture |
	aFuture := [ self syncUpdate ] asAsyncFuture delayed: 300 milliSeconds.
	updateElementFuture future: aFuture
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
GtPhlowElementContext >> selectPreviousEvent: aPreviousSelectEvent [
	| aNewEvent |
	aNewEvent := GtPhlowObjectToSelect new
			tool: aPreviousSelectEvent tool;
			sourceElement: aPreviousSelectEvent sourceElement.
	aPreviousSelectEvent properties keysAndValuesDo: [ :aKey :aValue | 
		aNewEvent propertyAt: aKey put: aValue ].
	
	self element fireEvent: aNewEvent.
	aPreviousSelectEvent consumed: aNewEvent isConsumed.
	
	^ aNewEvent
]

{ #category : #'api - events' }
GtPhlowElementContext >> selectTool: aTool [
	self element fireEvent: (GtPhlowObjectToSelect new
		tool: aTool;
		sourceElement: self element) 
]

{ #category : #'api - space' }
GtPhlowElementContext >> showObject: anObject [
	^ BlSpace new
		objectInPager: anObject;
		withSceneDriller;
		showFrom: self element.
]

{ #category : #'api - space' }
GtPhlowElementContext >> spaceBuilder [
	^ GtPhlowSpaceBuilder new 
		fromElement: self element
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnDefiningMethod [
	self entity
		ifNotNil: [ :anEntity | anEntity definingMethod ifNotNil: [ :aMethod | self spawnObject: aMethod ] ]
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnFuture: anAsyncFuture [
	self spawnFuture: anAsyncFuture result: #yourself
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnFuture: anAsyncFuture result: aSuccessBlock [
	"Spawn a result of future computation. 
	aSuccessBlock must have one argument, computing an object to spawn."

	BrAsyncElementFuture new
		executionConfiguration: GtPhlowUtility defaultFutureExecutionConfiguration;
		element: self element;
		future: anAsyncFuture;
		whenSuccess: [ :anElement :aResult | 
			| anObject |
			anObject := aSuccessBlock cull: aResult.
			self spawnObject: anObject gtDefaultInspectorTool ].
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnObject: anObject [
	^ self spawnTool: anObject gtDefaultInspectorTool
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnObject: anObject withDestination: aPhlowDestination [
	self 
		spawnTool: anObject gtDefaultInspectorTool
		withDestination: aPhlowDestination
]

{ #category : #'api - space' }
GtPhlowElementContext >> spawnOrShowObject: anObject [
	<return: #BlSpace or: nil>
	| anEvent |
	anEvent := self spawnObject: anObject.
	anEvent isConsumed ifTrue: [ ^ nil ].
	^ self showObject: anObject
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnPreviousEvent: aPreviousSpawnEvent [
	| aNewEvent |
	aNewEvent := GtPhlowObjectToSpawn new
			fromPreviousSpawnEvent: aPreviousSpawnEvent.
	self element fireEvent: aNewEvent.
	^ aNewEvent
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnTool: aTool [
	^ self
		spawnTool: aTool
		withDestination: GtPhlowSpawnDesiredDestination defaultDestination
]

{ #category : #'api - events' }
GtPhlowElementContext >> spawnTool: aTool withDestination: aPhlowDestination [
	| anEvent |
	anEvent := GtPhlowObjectToSpawn new
			tool: aTool;
			spawnDestination: aPhlowDestination;
			sourceElement: self element.
	self element fireEvent: anEvent.
	^ anEvent
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
	^ self firstParentWithViewContent phlow firstChildWithViewTitle parentTabGroup content
]
