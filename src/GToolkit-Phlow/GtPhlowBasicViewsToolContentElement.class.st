Class {
	#name : #GtPhlowBasicViewsToolContentElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'headerElement',
		'mainContainer',
		'toolbarElement',
		'titleNotifier',
		'toolbarUpdater',
		'detailsUpdater',
		'toolModel',
		'contentUpdater'
	],
	#category : #'GToolkit-Phlow-Tool - Element'
}

{ #category : #callbacks }
GtPhlowBasicViewsToolContentElement >> actOnToolModelChanged [
	self initializeTitleNotifier.
	
	self requestToolbarUpdate.
	self requestDetailsUpdate.
]

{ #category : #'building widgets' }
GtPhlowBasicViewsToolContentElement >> buildHeaderElement [
	^ BrHorizontalPane new 
		alignCenter;
		clipChildren: false;
		margin: (BlInsets top: 5 left: 8 bottom: 0 right: 0);
		vFitContent;
		hMatchParent
]

{ #category : #'building widgets' }
GtPhlowBasicViewsToolContentElement >> buildToolLabel [
	^(BrLabel new)
		aptitude: ((BrGlamorousLabelAptitude new)
					foreground: Color lightGray;
					labelDo: 
							[:aLabel |
							aLabel
								editorMeasurement;
								padding: BlInsets empty]);
		preventMeAndChildrenMouseEvents;
		text: self toolName;
		margin: (BlInsets
					top: 8
					left: 0
					bottom: 8
					right: 0);
		padding: (BlInsets all: 5);
		hMatchParent;
		vFitContent;
		background: Color white
]

{ #category : #'building widgets' }
GtPhlowBasicViewsToolContentElement >> buildToolbar [
	^ BrToolbar new
		aptitude: BrGlamorousToolbarAptitude new;
		alignCenterLeft;
		fitContent.
]

{ #category : #initialization }
GtPhlowBasicViewsToolContentElement >> collectToolActions [ 
	^ self toolModel collectToolActions
]

{ #category : #initialization }
GtPhlowBasicViewsToolContentElement >> createTitleNotifier [
	self assert: [ self toolModel notNil ].
	
	^ self toolModel createTitleNotifier
]

{ #category : #initialization }
GtPhlowBasicViewsToolContentElement >> initialize [
	super initialize.
	
	self matchParent.
	self padding: (BlInsets all: 5).
	
	self initializeHeaderElement.
	self initializeMainContainerElement.
	
	self addChild: headerElement as: #header.
	self addChild: mainContainer as: #mainContainer.
	
	self initializeUpdaters.
]

{ #category : #initialization }
GtPhlowBasicViewsToolContentElement >> initializeHeaderElement [
	headerElement := self buildHeaderElement.

	toolbarElement := self buildToolbar.

	headerElement addChild: self buildToolLabel as: #toolLabel.
	headerElement addChild: toolbarElement as: #toolbar.
]

{ #category : #initialization }
GtPhlowBasicViewsToolContentElement >> initializeMainContainerElement [
	mainContainer := BrFrame new
		matchParent. 
		
	self 
		addChild: mainContainer
		as: #mainContainer.
]

{ #category : #initialization }
GtPhlowBasicViewsToolContentElement >> initializeTitleNotifier [
	"For now we only allow a singlew title notifier"
	self assert: [titleNotifier isNil ].
	
	titleNotifier := self createTitleNotifier.
	self addEventHandler: titleNotifier
]

{ #category : #initialization }
GtPhlowBasicViewsToolContentElement >> initializeUpdaters [
	toolbarUpdater := BrElementUpdater new 
		element: self
		selector: #updateToolbarActions.
		
	contentUpdater := BrElementUpdater new 
		element: self
		selector: #updateContentElement
]

{ #category : #updating }
GtPhlowBasicViewsToolContentElement >> requestContentUpdate [
	contentUpdater ifNil: [ ^ self ].
	
	contentUpdater requestUpdate
]

{ #category : #updating }
GtPhlowBasicViewsToolContentElement >> requestDetailsUpdate [
	detailsUpdater requestUpdate
]

{ #category : #updating }
GtPhlowBasicViewsToolContentElement >> requestMainContainerAndToolbarUpdate [
	self requestContentUpdate.
	self requestToolbarUpdate
]

{ #category : #updating }
GtPhlowBasicViewsToolContentElement >> requestToolbarUpdate [
	toolbarUpdater requestUpdate
]

{ #category : #subscriptions }
GtPhlowBasicViewsToolContentElement >> subscribeToToolModel [
	
]

{ #category : #accessing }
GtPhlowBasicViewsToolContentElement >> toolModel [
	^ toolModel 
]

{ #category : #accessing }
GtPhlowBasicViewsToolContentElement >> toolModel: aToolModel [
	self
		assert: [ aToolModel notNil ]
		description: [ 'Analyzer palette must not be nil' ].

	toolModel == aToolModel 
		ifTrue: [ ^ self ].

	toolModel ifNotNil: [ self unsubscribeFromToolModel ].
	toolModel := aToolModel.

	self actOnToolModelChanged.
	self subscribeToToolModel .
]

{ #category : #accessing }
GtPhlowBasicViewsToolContentElement >> toolName [
	^ self subclassResponsibility
]

{ #category : #subscriptions }
GtPhlowBasicViewsToolContentElement >> unsubscribeFromToolModel [
	
]

{ #category : #updating }
GtPhlowBasicViewsToolContentElement >> updateContentElement [
]

{ #category : #updating }
GtPhlowBasicViewsToolContentElement >> updateToolbarActions [
	toolbarElement removeAllItems.
	
	self collectToolActions do: [ :aPhlowAction | 
		aPhlowAction asElement: [ :actionElement | 
			toolbarElement 
				addItem: actionElement ]
				withHostElement: self ] 
]
