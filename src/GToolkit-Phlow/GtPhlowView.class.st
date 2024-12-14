"
1. Phlow View

A view is a stencil, a specification of how the concrete view widget will be created. Beside the logic of creating the widget, the view also specifies the `title`, and the `phlowActions` (see {{gtClass:GtPhlowAction}}).

See {{gtClass:GtPhlowViewExamples}}.


"
Class {
	#name : #GtPhlowView,
	#superclass : #GtPhlowProtoView,
	#traits : 'TGtPhlowViewTooltipBuilder',
	#classTraits : 'TGtPhlowViewTooltipBuilder classTrait',
	#instVars : [
		'title',
		'priority',
		'definingMethod',
		'phlowActions',
		'autoUpdates',
		'asyncEnabled',
		'buildContext',
		'definingMethodProvider'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #decorating }
GtPhlowView class >> empty [
	^ GtPhlowEmptyView new
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #testing }
GtPhlowView class >> isAbstract [
	^ self name = #GtPhlowView 
]

{ #category : #'adding - actions' }
GtPhlowView >> action: anOneArgBlock [
	| newPhlowAction |
	newPhlowAction := anOneArgBlock value: GtPhlowAction noAction.
	newPhlowAction definingMethod: self definingMethod.
	newPhlowAction priority: GtPhlowAction defaultPriority + self actions size + 1.
	self addPhlowAction: newPhlowAction.
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonDo: aBlock [
	self action: [ :aPhlowAction | 
		aBlock cull: aPhlowAction button ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonIcon: anIcon action: aValuable [
	self actionButtonDo: [ :aButtonAction | 
		aButtonAction
			icon: anIcon;
			action: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonIcon: anIcon label: aStringOrRope action: aValuable [
	self actionButtonDo: [ :aButtonAction | 
		aButtonAction
			icon: anIcon;
			label: aStringOrRope;
			action: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonIcon: anIcon label: aStringOrRope tooltip: aTooltipText action: aValuable [
	self actionButtonDo: [ :aButtonAction | 
		aButtonAction
			icon: anIcon;
			label: aStringOrRope;
			tooltip: aTooltipText;
			action: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonIcon: anIcon tooltip: aTooltipText action: aValuable [
	self actionButtonDo: [ :aButtonAction | 
		aButtonAction
			icon: anIcon;
			tooltip: aTooltipText;
			action: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonLabel: aString action: aValuable [
	self actionButtonDo: [ :aButtonAction | 
		aButtonAction
			label: aString;
			action: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonLabel: aString tooltip: aTooltipText action: aValuable [
	self actionButtonDo: [ :aButtonAction | 
		aButtonAction
			label: aString;
			tooltip: aTooltipText;
			action: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionDropdownButtonDo: aBlock [
	self action: [ :aPhlowAction | 
		aBlock cull: aPhlowAction dropdown ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionDropdownButtonIcon: anIcon content: aValuable [
	self actionDropdownButtonDo: [ :aDrodownAction | 
		aDrodownAction dropdown 
			icon: anIcon;
			content: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionDropdownButtonIcon: anIcon label: aStringOrRope content: aValuable [
	self actionDropdownButtonDo: [ :aDrodownAction | 
		aDrodownAction dropdown 
			icon: anIcon;
			label: aStringOrRope;
			content: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionDropdownButtonIcon: anIcon label: aStringOrRope tooltip: aTooltipText content: aValuable [
	self actionDropdownButtonDo: [ :aDrodownAction | 
		aDrodownAction dropdown 
			icon: anIcon;
			label: aStringOrRope;
			tooltip: aTooltipText;
			content: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionDropdownButtonIcon: anIcon tooltip: aTooltipText content: aValuable [
	self actionDropdownButtonDo: [ :aDrodownAction | 
		aDrodownAction dropdown 
			icon: anIcon;
			tooltip: aTooltipText;
			content: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionDropdownButtonIcon: anIcon tooltip: aTooltipText content: aValuable id: anId [
	self actionDropdownButtonDo: [ :aDrodownAction | 
		aDrodownAction dropdown 
			icon: anIcon;
			tooltip: aTooltipText;
			content: aValuable;
			id: anId ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionDropdownButtonLabel: aStringOrRope content: aValuable [
	self actionDropdownButtonDo: [ :aDrodownAction | 
		aDrodownAction dropdown 
			label: aStringOrRope;
			content: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionDropdownButtonLabel: aStringOrRope tooltip: aTooltipText content: aValuable [
	self actionDropdownButtonDo: [ :aDrodownAction | 
		aDrodownAction dropdown 
			label: aStringOrRope;
			tooltip: aTooltipText;
			content: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionStencil: anActionStencil [
	self actionStencilDo: [ :anExplicit | 
		anExplicit stencil: anActionStencil ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionStencil: anActionStencil tooltip: aTooltipText [
	self actionStencilDo: [ :anExplicit | 
		anExplicit 
			stencil: anActionStencil;
			tooltip: aTooltipText ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionStencilDo: aBlock [
	self action: [ :aPhlowAction | 
		aBlock cull: aPhlowAction explicit ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleDo: aBlock [
	self action: [ :aPhlowAction | 
		aBlock cull: aPhlowAction toggle ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleIcon: anIcon activated: anActivatedValuable deactivated: aDeactivatedValuable [
	self actionToggleDo: [ :aToggleAction |
		aToggleAction 
			icon: anIcon;
			activatedAction: anActivatedValuable;
			deactivatedAction: aDeactivatedValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleIcon: anIcon label: aStringOrRope activated: anActivatedValuable deactivated: aDeactivatedValuable [
	self actionToggleDo: [ :aToggleAction |
		aToggleAction 
			icon: anIcon;
			label: aStringOrRope;
			activatedAction: anActivatedValuable;
			deactivatedAction: aDeactivatedValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleIcon: anIcon label: aStringOrRope tooltip: aTooltipText activated: anActivatedValuable deactivated: aDeactivatedValuable [
	self actionToggleDo: [ :aToggleAction |
		aToggleAction 
			icon: anIcon;
			label: aStringOrRope;
			tooltip: aTooltipText;
			activatedAction: anActivatedValuable;
			deactivatedAction: aDeactivatedValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleIcon: anIcon tooltip: aTooltipText activated: anActivatedValuable deactivated: aDeactivatedValuable [
	self actionToggleDo: [ :aToggleAction |
		aToggleAction 
			icon: anIcon;
			tooltip: aTooltipText;
			activatedAction: anActivatedValuable;
			deactivatedAction: aDeactivatedValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleLabel: aStringOrRope activated: anActivatedValuable deactivated: aDeactivatedValuable [
	self actionToggleDo: [ :aToggleAction |
		aToggleAction 
			label: aStringOrRope;
			activatedAction: anActivatedValuable;
			deactivatedAction: aDeactivatedValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleLabel: aStringOrRope tooltip: aTooltipText activated: anActivatedValuable deactivated: aDeactivatedValuable [
	self actionToggleDo: [ :aToggleAction |
		aToggleAction 
			label: aStringOrRope;
			tooltip: aTooltipText;
			activatedAction: anActivatedValuable;
			deactivatedAction: aDeactivatedValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionUpdateButton [
	self actionUpdateButtonTooltip: 'Update'
]

{ #category : #'adding - actions' }
GtPhlowView >> actionUpdateButtonIcon: anIcon tooltip: aTooltip [
	self 
		actionButtonIcon: anIcon
		tooltip: aTooltip
		action: [ :aButton :aTab | aTab viewContentElement phlow update ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionUpdateButtonTooltip: aTooltip [
	self 
		actionUpdateButtonIcon: BrGlamorousVectorIcons refresh 
		tooltip: aTooltip
]

{ #category : #accessing }
GtPhlowView >> actions [
	<return: #OrderedCollection of: #GtPhlowAction>
	^ phlowActions
]

{ #category : #'adding - actions' }
GtPhlowView >> actionsToolbarForElement: anElement [
	| aToolbar |
	aToolbar := BrToolbar new.
	aToolbar aptitude: BrGlamorousToolbarAptitude.

	aToolbar
		withAsyncPromiseDo: [ :anElementPromise | 
			anElementPromise
				whenSuccess: [ :aToolbarElement :theActions | 
					theActions
						do: [ :phlowAction | 
							phlowAction
								asElement: [ :actionElement | aToolbar addItem: actionElement ]
								withHostElement: anElement ] ].
			anElementPromise promise: self allActionsFuture ].

	^ aToolbar
]

{ #category : #'adding - update definitions' }
GtPhlowView >> addAutoUpdate: aGtPhlowUpdateDefinition [
	self autoUpdates add: (aGtPhlowUpdateDefinition on: self)
]

{ #category : #'adding - update definitions' }
GtPhlowView >> addAutoUpdates: aCollectionOfGtPhlowUpdateDefinition [
	aCollectionOfGtPhlowUpdateDefinition do: [ :eachDefinition | 
		self addAutoUpdate: eachDefinition ]
]

{ #category : #'adding - actions' }
GtPhlowView >> addPhlowAction: aPhlowAction [
	phlowActions add: aPhlowAction.
	phlowActions sort: [ :a :b | 
		[ a priority < b priority ]
			on: Error
			do: [ :error | true ] ].
]

{ #category : #'adding - actions' }
GtPhlowView >> addPhlowActions: aCollectionOfPhlowActions [
	aCollectionOfPhlowActions do: [ :eachPhlowAction | 
		self addPhlowAction: eachPhlowAction ]
]

{ #category : #'adding - actions' }
GtPhlowView >> addUpdateButton [
	self
		deprecated: 'Please use actionUpdateButton method instead.'
		transformWith:
			'`@receiver addUpdateButton'
				-> '`@receiver actionUpdateButton'.	
	^ self actionUpdateButton
]

{ #category : #'adding - actions' }
GtPhlowView >> addUpdateButtonIcon: anIcon tooltip: aTooltip [
	self
		deprecated: 'Please use actionUpdateButtonIcon:tooltip: method instead.'
		transformWith:
			'`@receiver addUpdateButtonIcon: `@statements1 tooltip: `@statements2'
				-> '`@receiver actionUpdateButtonIcon: `@statements1 tooltip: `@statements2'.	
	^ self actionUpdateButtonIcon: anIcon tooltip: aTooltip
]

{ #category : #'adding - actions' }
GtPhlowView >> addUpdateButtonTooltip: aTooltip [
	self
		deprecated: 'Please use actionUpdateButtonTooltip: method instead.'
		transformWith:
			'`@receiver addUpdateButtonTooltip: `@statements1'
				-> '`@receiver actionUpdateButtonTooltip: `@statements1'.	
	^ self actionUpdateButtonTooltip: aTooltip
]

{ #category : #'accessing - computed' }
GtPhlowView >> allActionsFuture [
	"I return all actions that belong to a view.
	It may include actions of a other views in some cases"
	<return: #AsyncFuture of: #OrderedCollection>

	^ [ self actions ] asAsyncFuture
]

{ #category : #'accessing - computed' }
GtPhlowView >> allDefiningMethods [
	"I return an object that understands #gtSourceFor:.
	I return all methods that are involved in a view definition."
	<return: #RGMethodDefinition or: #GtPhlowDefiningMethods>
	
	^ self definingMethodProvider 
		ifNil: [ definingMethod ]
		ifNotNil: [ :aMethodProvider | 
			aMethodProvider allDefiningMethods  ].
]

{ #category : #converting }
GtPhlowView >> asTaskItView [
	^ asyncEnabled
		ifTrue: [ super asTaskItView ]
		ifFalse: [ self ]
]

{ #category : #updating }
GtPhlowView >> autoUpdates [
	<return: #GtPhlowUpdateDefinitions>
	^ autoUpdates
]

{ #category : #'message performing' }
GtPhlowView >> basicOn: anObject perform: aMessageSymbol withArguments: aCollectionOfArguments [
	<return: #GtPhlowView>
	<gtCollector>
	| aPhlowView |
	
	aPhlowView := thisContext
		object: anObject
		perform: aMessageSymbol
		withArguments: aCollectionOfArguments
		inClass: anObject class.
		
	aPhlowView = self ifTrue: [
		GtPhlowViewsCollectorSameViewError 
			signalForViewSelector: aMessageSymbol
			fromObject: anObject ].
			
	aPhlowView object: anObject arguments: aCollectionOfArguments.
	^ aPhlowView
]

{ #category : #'private - updating' }
GtPhlowView >> basicReplaceOldElement: anOldElement by: aNewElement in: aParent [
	anOldElement parent == aParent ifTrue: [
		aParent replaceChild: anOldElement with: aNewElement ]
]

{ #category : #accessing }
GtPhlowView >> buildContext [
	<return: #GtPhlowBuildContext>
	^ buildContext
]

{ #category : #accessing }
GtPhlowView >> buildContext: aGtPhlowBuildContext [
	buildContext := aGtPhlowBuildContext
]

{ #category : #defaults }
GtPhlowView >> defaultAutoUpdates [
	^ GtPhlowUpdateDefinitions new
]

{ #category : #defaults }
GtPhlowView >> defaultBuildContext [
	^ GtPhlowBuildContext null
]

{ #category : #defaults }
GtPhlowView >> defaultTitle [
	^ 'View'
]

{ #category : #defaults }
GtPhlowView >> defaultUpdateDefinitions [
	^ { GtPhlowUpdateSingleViewElementOnDefiningMethodChange }
]

{ #category : #accessing }
GtPhlowView >> definingMethod [
	^ self definingMethodProvider 
		ifNil: [ definingMethod ]
		ifNotNil: [ :aMethodProvider | 
			aMethodProvider definingMethod  ].
]

{ #category : #accessing }
GtPhlowView >> definingMethod: anObject [
	definingMethodProvider := GtPhlowConcreteDefiningMethodProvider new
		definingMethod: anObject
]

{ #category : #'error handling' }
GtPhlowView >> definingMethodForObject: anObject andSelector: aMessageSymbol [
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
GtPhlowView >> definingMethodProvider [
	^ definingMethodProvider
]

{ #category : #accessing }
GtPhlowView >> definingMethodProvider: aMethodProvider [
	definingMethodProvider := aMethodProvider
]

{ #category : #'api - async ui building' }
GtPhlowView >> disableAsync [
	"Disable element creation in background (while calling ${method:GtPhlowProtoView>>#asElementDo:}$)"
	asyncEnabled := false.
]

{ #category : #'api - async ui building' }
GtPhlowView >> enableAsync [
	"Enable element creation in background (while calling ${method:GtPhlowProtoView>>#asElementDo:}$)"
	asyncEnabled := true.
]

{ #category : #'private - updating' }
GtPhlowView >> enqueueAction: aBlock in: anElement [
	BlUseAsyncFeatures 
		ifEnabledDo: [ anElement enqueueTask: (BlTaskAction new action: aBlock) ] 
		otherwise: aBlock
]

{ #category : #'private - message performing' }
GtPhlowView >> ensureContext [

	(self buildContext isBuildContext and: [ 
		 self buildContext hasContext ]) ifTrue: [ 
		^ self buildContext context ].

	^ GtPhlowContext new
]

{ #category : #'gt-extension' }
GtPhlowView >> gtActionsFor: aView [
	<gtView>
	self actions ifEmpty: [ ^ self ].
	^ aView columnedList
		title: 'Actions';
		priority: 5;
		items: [ self actions ];
		column: 'Action' text: [ :aPhlowAction | aPhlowAction class name ];
		column: 'Defining Method' text: [ :aPhlowAction | aPhlowAction definingMethod selector ]
]

{ #category : #testing }
GtPhlowView >> hasExplicitTitle [
	<return: #Boolean>
	^ self title isNotNil and: [ self title ~= self defaultTitle ]
]

{ #category : #converting }
GtPhlowView >> ifItHasContent: aBlock [
	^ aBlock value
]

{ #category : #initialization }
GtPhlowView >> initialize [
	super initialize.
	phlowActions := OrderedCollection new.
	priority := 50. "the lower the value, the closer to the left the tab appears"
	title := self defaultTitle.
	autoUpdates := self defaultAutoUpdates.
	asyncEnabled := true.
	buildContext := self defaultBuildContext.
	self initializeTooltipBuilder.
	self initializeDefaultUpdateDefinitions.
]

{ #category : #initialization }
GtPhlowView >> initializeDefaultUpdateDefinitions [
	self addAutoUpdates: self defaultUpdateDefinitions
]

{ #category : #'private - elements' }
GtPhlowView >> installAutoUpdatesOn: anElement [
	self autoUpdates installAutoUpdatesOn: anElement
]

{ #category : #testing }
GtPhlowView >> isAsyncEnabled [
	^ asyncEnabled
]

{ #category : #accessing }
GtPhlowView >> methodSelector [
	^ self definingMethod selector
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol [
	<return: #GtPhlowView>
	<gtCollector>
	
	^ self 
		on: anObject 
		perform: aMessageSymbol 
		withSomeArguments: { 
			  self.
			  self ensureContext }
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol withArguments: aCollectionOfArguments [
	<return: #GtPhlowView>
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
				phlowErrorViewWithException: anException 
				forBuildContext: (GtPhlowBuildContext new 
					object: anObject; 
					arguments: aCollectionOfArguments) 
				andSelector: aMessageSymbol ]
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol withContext: aContext [
	<return: #GtPhlowView>
	<gtCollector>
	
	^ self 
		on: anObject 
		perform: aMessageSymbol 
		withSomeArguments: { self. aContext }
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol withSomeArguments: aCollectionOfArguments [
	<return: #GtPhlowView>
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

{ #category : #'accessing - computed' }
GtPhlowView >> originMethodsInto: aStream [
	self definingMethod ifNotNil: [ :aMethod | 
		aMethod gtOriginMethodsInto: aStream ]
]

{ #category : #'error handling' }
GtPhlowView >> performBlock: aBlock [
	<return: #BlElement>
	^ self 
		performBlock: aBlock 
		onException: [ :anException | anException asDebuggableElement ].
]

{ #category : #'error handling' }
GtPhlowView >> performBlock: aBlock onException: anExceptionBlock [
	^ aBlock on: Error do: anExceptionBlock.
]

{ #category : #'error handling' }
GtPhlowView >> performBlock: aPerformBlock onExceptionErrorElement: anExceptionBlock [
	^ self 
		performBlock: aPerformBlock 
		onException: [ :anException |
			| anElement | 
			anElement := anException asDebuggableElement. 
			anElement id: GtPhlowExceptionId.
			anElement phlow beViewContent; entity: self.
			anExceptionBlock value: anElement ]
]

{ #category : #'error handling' }
GtPhlowView >> phlowErrorViewWithException: anException [
	^ self phlowErrorViewWithException: anException isFrozen: false
]

{ #category : #'error handling' }
GtPhlowView >> phlowErrorViewWithException: anException forBuildContext: aContext andSelector: aMessageSymbol [
	| aDefiningMethod phlowErrorAction | 
	aDefiningMethod := self definingMethodForObject: aContext object andSelector: aMessageSymbol. 
	phlowErrorAction := self phlowErrorViewWithException: anException.
	phlowErrorAction definingMethod: aDefiningMethod.
	phlowErrorAction buildContext: aContext.
	^ phlowErrorAction
]

{ #category : #'error handling' }
GtPhlowView >> phlowErrorViewWithException: anException isFrozen: aBoolean [
	| aTitle aFrozenException |
	aFrozenException := aBoolean 
		ifTrue: [ anException ]
		ifFalse: [ GtSystemUtility freeze: anException ].
	aTitle := self hasExplicitTitle
		ifTrue: [ self title asString, ' (Error)' ] 
		ifFalse: [ 'Error' ].
	^ GtPhlowViewWithError new
		buildContext: self buildContext;
		definingMethod: self definingMethod;
		title: aTitle;
		exception: aFrozenException
]

{ #category : #accessing }
GtPhlowView >> printOn: aStream [

	super printOn: aStream.

	self title ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self title asString;
		nextPut: $)
]

{ #category : #accessing }
GtPhlowView >> priority [
	^ priority
]

{ #category : #'api - scripting' }
GtPhlowView >> priority: anObject [
	priority := anObject
]

{ #category : #'private - updating' }
GtPhlowView >> replaceOldElement: anOldElement by: aNewElement in: aParent [
	anOldElement phlow isViewContent ifTrue: [ 
		aNewElement phlow beViewContent ].
	self 
		enqueueAction: [ self basicReplaceOldElement: anOldElement by: aNewElement in: aParent ] 
		in: aParent.
]

{ #category : #'private - updating' }
GtPhlowView >> subscribeAutoUpdatesOn: aGtPhlowElementContext [
	self autoUpdates subscribeAutoUpdatesOn: aGtPhlowElementContext.
]

{ #category : #'private - elements' }
GtPhlowView >> subscribeToElement: anElement [
	super subscribeToElement: anElement.
	
	self installAutoUpdatesOn: anElement.
	
	anElement
		when: BlElementAddedToSceneGraphEvent 
			do: [ :anEvent | self subscribeAutoUpdatesOn: anEvent currentTarget phlow ];
		when: BlElementRemovedFromSceneGraphEvent 
			do: [ :anEvent | self unsubscribeAutoUpdatesOn: anEvent currentTarget phlow ]
]

{ #category : #'accessing - computed' }
GtPhlowView >> tabElementContextMenu [
	"I return a menu object that displays phlow view details, e.g., defining method."
	<return: #BrMenu or: nil>
	
	^ BrMenuItems new
		addItemLabel: 'Defining method' 
			submenu: (self allDefiningMethods asBrMenu);
		addItemLabel: 'Inspect defining method' 
			shortcut: 'Alt+Click' 
			action: [ :anElement :aButtonModel :anEvent |
				anElement phlow spawnObject: self allDefiningMethods ];
		addItemLabel: 'Inspect view' 
			preview: self title
			action: [ :anElement :aButtonModel :anEvent |
				anElement phlow spawnObject: self ];
		addItemLabel: 'Update view' 
			preview: self title
			action: [ :anElement :aButtonModel :anEvent |
				| aRequest |
				aRequest := BrMenuSourceElementRequest new.
				anElement fireEvent: aRequest.
				aRequest sourceElementDo: [ :aTab | 
					aTab viewContentElement phlow update ] ]
]

{ #category : #accessing }
GtPhlowView >> title [
	^ title
]

{ #category : #'api - scripting' }
GtPhlowView >> title: aString [ 
	title := aString
]

{ #category : #'private - updating' }
GtPhlowView >> unsubscribeAutoUpdatesOn: aGtPhlowElementContext [
	self autoUpdates unsubscribeAutoUpdatesOn: aGtPhlowElementContext.
]

{ #category : #updating }
GtPhlowView >> updateContent: aCurrentElement [
	"anElement is previously computed content from asElementDo:"
	
	| aParent |
	aParent := aCurrentElement parent.
	aParent ifNotNil: [ 
		self asElementDo: [ :aNewElement |
			self replaceOldElement: aCurrentElement by: aNewElement in: aParent. ] ].
]

{ #category : #'adding - update definitions' }
GtPhlowView >> updateWhen: anAnnouncement if: anIfCondition in: anAnnouncer [
	"anIfCondition is an object (block) that understands the #cull:cull: message.
	It is called as anIfCondition cull: aReceivedAnnouncement cull: aGtPhlowElementContext"
	self autoUpdates asyncWhen: anAnnouncement if: anIfCondition in: anAnnouncer
]

{ #category : #'adding - update definitions' }
GtPhlowView >> updateWhen: anAnnouncement in: anAnnouncer [
	self autoUpdates asyncWhen: anAnnouncement in: anAnnouncer
]
