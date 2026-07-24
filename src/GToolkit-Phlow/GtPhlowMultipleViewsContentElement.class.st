Class {
	#name : #GtPhlowMultipleViewsContentElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'viewsContainer',
		'headerElement',
		'mainContainer',
		'toolbarElement',
		'titleNotifier',
		'toolbarUpdater',
		'detailsUpdater',
		'contentUpdater',
		'titleLabel',
		'playgroundElement',
		'toolContentModel'
	],
	#category : #'GToolkit-Phlow-Tool - Element'
}

{ #category : #building }
GtPhlowMultipleViewsContentElement >> buildHeaderElement [
	^ BrVerticalPane new
		padding: (BlInsets left: 5);
		vFitContent;
		hMatchParent
]

{ #category : #building }
GtPhlowMultipleViewsContentElement >> buildPlaygroundPageElement [
	| aPlaygroundElement |
	aPlaygroundElement := (GtInspector environment at: GtInspector embeddedPlaygroundName) new.
	aPlaygroundElement collapse.
	^ aPlaygroundElement
]

{ #category : #building }
GtPhlowMultipleViewsContentElement >> buildTitleContainer [
	^ BrHorizontalPane new
		vFitContent;
		hMatchParent
]

{ #category : #building }
GtPhlowMultipleViewsContentElement >> buildTitleLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
			bold;
			fontSize: 18);
		text: ''
]

{ #category : #building }
GtPhlowMultipleViewsContentElement >> buildToolLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
			foreground: Color gray;
			fontSize: 12);
		text: 'Search Filter'.
]

{ #category : #building }
GtPhlowMultipleViewsContentElement >> buildToolbar [
	^ BrToolbar new
		aptitude: BrGlamorousToolbarAptitude new;
		fitContent;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignTop ]
]

{ #category : #building }
GtPhlowMultipleViewsContentElement >> buildViewsContainerElement [
	^ BrFrame new
		matchParent
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> collectContentViews [ 
	^ self toolContentModel collectContentViews
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> collectToolActions [
	^ self toolContentModel collectToolActions
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> createTitleNotifier [
	self assert: [ self toolContentModel notNil ].
	
	^GtPhlowTitleIconAndLabelNotifier new 
		longLabel: [ self toolContentModel headerTitle ];
		icon: [ self toolContentModel toolIcon ] asStencil
]

{ #category : #'as yet unclassified' }
GtPhlowMultipleViewsContentElement >> extractSelectedTabIdentifier [
	^ (GtPhlowSelectedTabExtractor new 
		inspectorElement: self) extractTabName
]

{ #category : #'as yet unclassified' }
GtPhlowMultipleViewsContentElement >> extractToolSelectionState [
	^ GtPhlowTabbedToolSelectionState new 
		tabIdentifier: self extractSelectedTabIdentifier
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> headerElement [
	^ headerElement
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> initialize [
	super initialize.
	
	self matchParent.
	self padding: (BlInsets top: 5 left: 5 bottom: 0 right: 5).
	
	self initializeContent.
	self initializeListeners.
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> initializeContent [
	self initializeHeaderElement.
	self addChild: (viewsContainer :=self buildViewsContainerElement) as: #viewsContainer.
	self addChild: (playgroundElement := self buildPlaygroundPageElement) as: #playgroundPage
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> initializeHeaderElement [
	| titleContainer |
	
	headerElement := self buildHeaderElement.
	
	titleContainer := self buildTitleContainer.
	titleContainer addChild: self buildTitleLabel as: #titleLabel.
	titleContainer addChild: self buildToolbar as: #toolbar.
	
	headerElement addChild: self buildToolLabel as: #toolLabel.
	headerElement addChild: titleContainer as: #titleContainer.
	
	self addChild: headerElement as: #header
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> initializeListeners [
	self
		addEventHandler: (GtPhlowToolUpdateEventHandler new onUpdateSend: #onUpdateToolWish: to: self).
	self
		when: GtPhlowViewUpdateWish
		do: [ :anEvent | self onUpdateToolWish: anEvent ]
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> initializeTitleNotifier [
	self assert: [ titleNotifier isNil ].
	titleNotifier := self createTitleNotifier.
	self addEventHandler: titleNotifier
]

{ #category : #'private - event handling' }
GtPhlowMultipleViewsContentElement >> onUpdateToolWish: anEvent [
	"For now, we simply update the whole tool.
	Later we could find the Phlow view and request just its update."

	anEvent consumed: true.
	self updateContent
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> playgroundElement [
	^ playgroundElement
]

{ #category : #selection }
GtPhlowMultipleViewsContentElement >> selectTabWithIdentifier: aTabIdentifier [
	"Return true if selection was applied, false otherwise."

	<return: #Boolean>
	^ aTabIdentifier applySelectionTo: self
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> subscribeToToolModel [
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> titleLabel [
	^ self headerElement childNamed: #titleLabel
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> toolContentModel [
	^ toolContentModel
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> toolContentModel: aToolContentModel [
	self
		assert: [ aToolContentModel notNil ]
		description: [ 'Tool model must not be nil' ].
		
	toolContentModel == aToolContentModel ifTrue: [ ^ self ].
	toolContentModel ifNotNil: [ self unsubscribeFromToolModel ].
	toolContentModel := aToolContentModel.
	
	self initializeTitleNotifier.
	self updateContent.
	self subscribeToToolModel
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> toolLabel [
	^ self headerElement childNamed: #toolLabel
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> toolName [
	^ toolContentModel
		ifNil: [ '<unknown tool>' ]
		ifNotNil: [ toolContentModel toolName ]
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> toolbarElement [
	^ self headerElement childNamed: #toolbar
]

{ #category : #initialization }
GtPhlowMultipleViewsContentElement >> unsubscribeFromToolModel [
]

{ #category : #updating }
GtPhlowMultipleViewsContentElement >> updateContainedViews [
	| tabGroup compositeView |
	compositeView := GtPhlowCompositeView new
		views: self collectContentViews views.
	tabGroup := compositeView asElementDo: [ :e | e ].
	self viewsContainerElement
		removeChildren;
		addChild: tabGroup
]

{ #category : #updating }
GtPhlowMultipleViewsContentElement >> updateContent [
	self updateHeader.
	self updateContainedViews.
	self updatePlayground.
]

{ #category : #updating }
GtPhlowMultipleViewsContentElement >> updateContentElement [
	self updateContainedViews
]

{ #category : #updating }
GtPhlowMultipleViewsContentElement >> updateHeader [
	self toolLabel text: self toolName.
	self updateHeaderTitle.
	self updateToolbarActions.
]

{ #category : #updating }
GtPhlowMultipleViewsContentElement >> updateHeaderTitle [
	self titleLabel text: self toolContentModel headerTitle
]

{ #category : #updating }
GtPhlowMultipleViewsContentElement >> updatePlayground [
	self playgroundElement
		objectHolder: (GtInspectorObject new object: self toolContentModel targetObject)
]

{ #category : #updating }
GtPhlowMultipleViewsContentElement >> updateToolbarActions [
	| currentToolbarElement |
	currentToolbarElement := self toolbarElement.
	currentToolbarElement removeAllItems.
	self collectToolActions do: [ :aPhlowAction |
		aPhlowAction 
			asElement: [ :actionElement |
				currentToolbarElement addItem: actionElement ]
			withHostElement: self ]
]

{ #category : #accessing }
GtPhlowMultipleViewsContentElement >> viewsContainerElement [
	^ viewsContainer
]
