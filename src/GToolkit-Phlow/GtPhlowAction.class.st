Class {
	#name : #GtPhlowAction,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtPhlowActionTooltipBuilder + TGtOptions',
	#classTraits : 'TBlDebug classTrait + TGtPhlowActionTooltipBuilder classTrait + TGtOptions classTrait',
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
GtPhlowAction class >> handledExceptions [
	"Explicitly catch here Halt and Warning as in case an action raising 
	those exceptions is embedded in the debugger it will trigger an
	infinite chain of debuggers.
	https://github.com/feenkcom/gtoolkit/issues/4383"
	
	^ Error, Halt, Warning
]

{ #category : #accessing }
GtPhlowAction class >> noAction [
	^ GtPhlowNoAction new
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]

{ #category : #converting }
GtPhlowAction >> actionContextMenuPreviewLabel [
	<return: #String>
	^ self label
		ifNil: [ self tooltipBuilder actionContextMenuPreviewLabel 
			ifNil: [ self className ] ]
]

{ #category : #converting }
GtPhlowAction >> actionElementContextMenu [
	"I return a menu object that displays phlow action details, e.g., defining method."
	<return: #BrMenu or: nil>
	
	^ BrMenuItems new
		addItem: (BrMenuSubmenuItem new
			id: #'menu--defining-method';
			label: 'Defining method' ;
			submenu: (self definingMethod asBrMenu);
			bePinSubmenuAction;
			hideOnClick: true);
		addItemId: #'menu--inspect-defining-method'
			label: 'Inspect defining method' 
			shortcut: 'Alt+Click' 
			action: [ :anElement :aButtonModel :anEvent |
				anElement phlow spawnObject: self definingMethod ];
		addItemId: #'menu--inspect-phlow-action'
			label: 'Inspect action' 
			preview: self actionContextMenuPreviewLabel
			action: [ :anElement :aButtonModel :anEvent |
				anElement phlow spawnObject: self ]
]

{ #category : #'api - target' }
GtPhlowAction >> addTarget: aGtPhlowActionTarget [
	self 
		assert: [ aGtPhlowActionTarget notNil ]
		description: [ 'Phlow action target must be non-nil' ].
	target := target, aGtPhlowActionTarget asPhlowTarget
]

{ #category : #converting }
GtPhlowAction >> asCircularElement: aBlock withHostElement: aTargetElement [
	"Return an element that represents the action in Bloc space, e.g., a button"
	<return: #BlElement>
	^ self asElement: aBlock withHostElement: aTargetElement
]

{ #category : #converting }
GtPhlowAction >> asElement: aBlock withHostElement: aTargetElement [
	"Return an element that represents the action in Bloc space, e.g., a button"
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #converting }
GtPhlowAction >> asMenuItem: aBlock withHostElement: aTargetElement [
	"Return a menu item that represents the action in BrMenuItems, e.g., action"
	<return: #BrMenuItem>
	^ self subclassResponsibility
]

{ #category : #converting }
GtPhlowAction >> attachShowContextMenuEventHandler: anElement [
	anElement
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude 
			menu: [ self actionElementContextMenu ])
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

{ #category : #'api - options' }
GtPhlowAction >> menuDisable: aBlock [
	self optionAt: #menuDisable put: aBlock
]

{ #category : #'api - options' }
GtPhlowAction >> menuDisableIfPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self
		optionAt: #menuDisable
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #'api - options' }
GtPhlowAction >> menuItemGroup: aGroup [
	self assert: [ aGroup isKindOf: BrMenuItemGroupConfiguration ].

	self optionAt: #menuItemGroup put: aGroup
]

{ #category : #'api - options' }
GtPhlowAction >> menuItemGroupIfPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self
		optionAt: #menuItemGroup
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #'api - options' }
GtPhlowAction >> menuItemHideOnClick: aBoolean [
	self assert: [ aBoolean isBoolean ].

	self optionAt: #menuItemHideOnClick put: aBoolean
]

{ #category : #'api - options' }
GtPhlowAction >> menuItemHideOnClickIfPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self
		optionAt: #menuItemHideOnClick
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
]

{ #category : #'api - options' }
GtPhlowAction >> menuShortcut: anObject [
	"Set shortcut that can be displayed next to a context menu item label."

	self optionAt: #menuShortcut put: anObject
]

{ #category : #'api - options' }
GtPhlowAction >> menuShortcutIfPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self
		optionAt: #menuShortcut
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock
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
	
	] 
		on: self class handledExceptions do: [ :anException |
		
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

{ #category : #'api - target' }
GtPhlowAction >> target [
	<return: #GtPhlowActionTarget>
	^ target
]

{ #category : #'api - target' }
GtPhlowAction >> target: aGtPhlowActionTarget [
	self 
		assert: [ aGtPhlowActionTarget notNil ]
		description: [ 'Phlow action target must be non-nil' ].
	target := aGtPhlowActionTarget asPhlowTarget
]

{ #category : #decorating }
GtPhlowAction >> toggle [
	^ GtPhlowToggleAction new
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]
