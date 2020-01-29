"
!Phlow View

A view is a stencil, a specification of how the concrete view widget will be created. Beside the logic of creating the widget, the view also specifies the ==title==, and the ==phlowActions== (see ${class:GtPhlowAction}$).

See ${class:GtPhlowViewExamples}$.

"
Class {
	#name : #GtPhlowView,
	#superclass : #GtPhlowProtoView,
	#instVars : [
		'title',
		'priority',
		'definingMethod',
		'phlowActions',
		'autoUpdates'
	],
	#category : #'GToolkit-Phlow-Views and Actions'
}

{ #category : #decorating }
GtPhlowView class >> empty [
	^ GtPhlowEmptyView new
		definingMethod: thisContext stack second method asRingDefinition
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
	self addPhlowAction: newPhlowAction.
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonIcon: anIcon action: aValuable [
	self actionButtonIcon: anIcon label: nil action: aValuable
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonIcon: anIcon label: aStringOrRope action: aValuable [
	self action: [ :aPhlowAction | 
		aPhlowAction button 
			icon: anIcon;
			label: aStringOrRope;
			action: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionButtonLabel: aString action: aValuable [
	self actionButtonIcon: nil label: aString action: aValuable
]

{ #category : #'adding - actions' }
GtPhlowView >> actionDropdownButtonIcon: anIcon label: aStringOrRope content: aValuable [
	self action: [ :aPhlowAction | 
		aPhlowAction dropdown 
			icon: anIcon;
			label: aStringOrRope;
			content: aValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionStencil: anActionStencil [
	self action: [ :aPhlowAction | 
		aPhlowAction explicit stencil: anActionStencil ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleIcon: anIcon activated: anActivatedValuable deactivated: aDeactivatedValuable [
	self 
		actionToggleIcon: anIcon 
		label: nil
		activated: anActivatedValuable 
		deactivated: aDeactivatedValuable
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleIcon: anIcon label: aStringOrRope activated: anActivatedValuable deactivated: aDeactivatedValuable [
	self action: [ :aPhlowAction | 
		aPhlowAction toggle 
			icon: anIcon;
			label: aStringOrRope;
			activatedAction: anActivatedValuable;
			deactivatedAction: aDeactivatedValuable ]
]

{ #category : #'adding - actions' }
GtPhlowView >> actionToggleLabel: aStringOrRope activated: anActivatedValuable deactivated: aDeactivatedValuable [
	self 
		actionToggleIcon: nil
		label: aStringOrRope
		activated: anActivatedValuable 
		deactivated: aDeactivatedValuable
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
	aToolbar look: BrGlamorousToolbarLook.

	self allActions do: [ :phlowAction |
		phlowAction 
			asElement: [ :actionElement | 
				aToolbar addItem: actionElement ] 
			withHostElement: anElement ].

	 ^ aToolbar
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

{ #category : #'accessing - computed' }
GtPhlowView >> allActions [
	"I return all actions that belong to a view.
	It may include actions of a other views in some cases"
	<return: #OrderedCollection>
	^ self actions
]

{ #category : #'accessing - computed' }
GtPhlowView >> allDefiningMethods [
	"I return an object that understands #gtSourceFor:.
	I return all methods that are involved in a view definition."
	<return: #RGMethodDefinition or: #GtPhlowDefiningMethods>
	^ self definingMethod
]

{ #category : #'adding - auto-updates' }
GtPhlowView >> autoUpdates [
	<return: #GtPhlowUpdateDefinitions>
	^ autoUpdates
]

{ #category : #initialization }
GtPhlowView >> defaultAutoUpdates [
	^ GtPhlowUpdateDefinitions new
]

{ #category : #initialization }
GtPhlowView >> defaultTitle [
	^ 'View'
]

{ #category : #accessing }
GtPhlowView >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtPhlowView >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #'error handling' }
GtPhlowView >> definingMethodForObject: anObject andSelector: aMessageSymbol [
	| aNilOrClassName |
	aNilOrClassName := anObject class whichClassIncludesSelector: aMessageSymbol.
	^ aNilOrClassName 
		ifNil: [	RGMethodDefinition new 
			name: aMessageSymbol;
			parentName: anObject className;
			isMetaSide: anObject class isMeta;
			asActive ] 
		ifNotNil: [ (aNilOrClassName >> aMessageSymbol) asRingDefinition ]
]

{ #category : #'gt-extension' }
GtPhlowView >> gtActionsFor: aView [
	<gtView>
	self actions ifEmpty: [ ^ self ].
	^ aView columnedList
			title: 'Actions';
			priority: 5;
			items: [ self actions ];
			column: 'Action' 
				format: [ :aPhlowAction | aPhlowAction className ];
			column: 'Defining Method'
				item: [ :aPhlowAction | aPhlowAction definingMethod ]
				format: [ :aMethodDefinition | aMethodDefinition selector ]
]

{ #category : #initialization }
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
]

{ #category : #'adding - auto-updates' }
GtPhlowView >> newSceneInformingElement [
	| anElement |
	anElement := BlSceneInformingElement new
		layout: BlLinearLayout vertical;
		onAddedToSceneDo: [ :anEvent | self subscribeAutoUpdatesOn: anEvent element phlow ];
		onRemovedFromSceneDo: [ :anEvent | self unsubscribeAutoUpdatesOn: anEvent element phlow ];
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	anElement phlow beView; entity: self.
	^ anElement
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol [
	<return: #GtPhlowView>
	<gtCollector>
	^ self on: anObject perform: aMessageSymbol withArguments: { self }
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol withArguments: aCollectionOfArguments [
	<return: #GtPhlowView>
	<gtCollector>
	^ [ thisContext
			object: anObject
			perform: aMessageSymbol
			withArguments: aCollectionOfArguments
			inClass: anObject class ] 
		on: Error 
		do: [ :anException |
			self 
				phlowErrorViewWithException: anException 
				forObject: anObject 
				andSelector: aMessageSymbol ]
]

{ #category : #'message performing' }
GtPhlowView >> on: anObject perform: aMessageSymbol withContext: aContext [
	<return: #GtPhlowView>
	<gtCollector>
	^ self on: anObject perform: aMessageSymbol withArguments: { self. aContext }
]

{ #category : #'accessing - computed' }
GtPhlowView >> originMethodsInto: aStream [
	self definingMethod gtOriginMethodsInto: aStream
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
			anElement phlow beView; entity: self.
			anExceptionBlock value: anElement ]
]

{ #category : #'error handling' }
GtPhlowView >> phlowErrorViewWithException: anException [
	| aTitle |
	anException freeze.
	aTitle := self hasExplicitTitle
		ifTrue: [ self title asString, ' (Error)' ] 
		ifFalse: [ 'Error' ].
	^ GtPhlowViewWithError new
		definingMethod: self definingMethod;
		title: aTitle;
		error: anException
]

{ #category : #'error handling' }
GtPhlowView >> phlowErrorViewWithException: anException forObject: anObject andSelector: aMessageSymbol [
	| aDefiningMethod aPhlow | 
	aDefiningMethod := self definingMethodForObject: anObject andSelector: aMessageSymbol. 
	aPhlow := self phlowErrorViewWithException: anException.
	aPhlow definingMethod: aDefiningMethod.
	^ aPhlow
]

{ #category : #accessing }
GtPhlowView >> priority [
	^ priority
]

{ #category : #accessing }
GtPhlowView >> priority: anObject [
	priority := anObject
]

{ #category : #'adding - auto-updates' }
GtPhlowView >> subscribeAutoUpdatesOn: aGtPhlowElementContext [
	self autoUpdates subscribeAutoUpdatesOn: aGtPhlowElementContext.
]

{ #category : #accessing }
GtPhlowView >> title [
	^ title
]

{ #category : #accessing }
GtPhlowView >> title: aString [ 
	title := aString
]

{ #category : #'adding - auto-updates' }
GtPhlowView >> unsubscribeAutoUpdatesOn: aGtPhlowElementContext [
	self autoUpdates unsubscribeAutoUpdatesOn: aGtPhlowElementContext.
]

{ #category : #updating }
GtPhlowView >> updateContent: anOldElement [
	"anElement is previously computed content from asElementDo:"
	
	| aParent |
	aParent := anOldElement parent.
	aParent ifNotNil: [ 
		self asElementDo: [ :aNewElement |
			anOldElement phlow isViewContent ifTrue: [ 
				aNewElement phlow beViewContent ].
			aParent replaceChild: anOldElement with: aNewElement ] ].
]

{ #category : #initialization }
GtPhlowView >> updateWhen: anAnnouncement in: anAnnouncer [
	self autoUpdates asyncWhen: anAnnouncement in: anAnnouncer
]
