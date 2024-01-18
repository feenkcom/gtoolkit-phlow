"
I exemplify {{gtClass:GtPhlowToolDetailState}}.


"
Class {
	#name : #GtPhlowToolDetailModelExamples,
	#superclass : #GtPhlowToolExamples,
	#category : #'GToolkit-Phlow-Examples-Tool'
}

{ #category : #'examples - tools' }
GtPhlowToolDetailModelExamples >> compositeTool [
	<gtExample>
	| aTool anElement |
	aTool := self basicCompositeTool.
	aTool addTool: self toolOne.
	aTool addTool: self toolTwo.

	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).

	^ aTool
]

{ #category : #'examples - events' }
GtPhlowToolDetailModelExamples >> containerContainerToolDetailedLevel [
	<gtExample>
	| aContainerOne aTool aContainerOneLevel aContainerTwo aContainerTwoLevel aToolLevel |
	
	aContainerOne := self containerContainerToolElement.
	self setToolDetailLevel: aContainerOne to: GtPhlowToolDetailState detailed.

	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.

	aContainerOneLevel := self requestToolDetailLevel: aContainerOne.
	aContainerTwoLevel := self requestToolDetailLevel: aContainerTwo.
	aToolLevel := self requestToolDetailLevel: aTool.

	self assert: aContainerOneLevel equals: GtPhlowToolDetailState detailed.
	self assert: aContainerTwoLevel equals: GtPhlowToolDetailState normal.
	self assert: aToolLevel equals: GtPhlowToolDetailState normal.

	^ aContainerOne
]

{ #category : #'examples - events' }
GtPhlowToolDetailModelExamples >> containerContainerToolDetailedLevel_ContainerLevelReponse [
	<gtExample>
	| aContainerOne aTool aContainerOneDimension aContainerTwo aContainerTwoDimension aToolDimension aReceivedDimension |
	aContainerOne := self containerContainerToolDetailedLevel.

	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.

	aReceivedDimension := self requestContainerDetailLevel: aTool.
	self assert: aReceivedDimension equals: GtPhlowToolDetailState normal.

	aContainerOneDimension := self requestToolDetailLevel: aContainerOne.
	aContainerTwoDimension := self requestToolDetailLevel: aContainerTwo.
	aToolDimension := self requestToolDetailLevel: aTool.

	self assert: aContainerOneDimension equals: GtPhlowToolDetailState detailed.
	self assert: aContainerTwoDimension equals: GtPhlowToolDetailState normal.
	self assert: aToolDimension equals: GtPhlowToolDetailState normal.

	^ aContainerOne
]

{ #category : #'examples - events' }
GtPhlowToolDetailModelExamples >> containerContainerToolDetailedLevel_InSpace [
	<gtExample>
	| aContainerOne aTool aSpace aContainerTwo aContainerOneDimension aContainerTwoDimension aToolDimension |
	aContainerOne := self containerContainerToolDetailedLevel.
	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.

	aSpace := self putInSpace: aContainerOne.

	aContainerOneDimension := self requestToolDetailLevel: aContainerOne.
	aContainerTwoDimension := self requestToolDetailLevel: aContainerTwo.
	aToolDimension := self requestToolDetailLevel: aTool.

	self assert: aContainerOneDimension equals: GtPhlowToolDetailState detailed.
	self assert: aContainerTwoDimension equals: GtPhlowToolDetailState normal.
	self assert: aToolDimension equals: GtPhlowToolDetailState normal.

	self closeSpace: aSpace with: aContainerOne.
	^ aContainerOne
]

{ #category : #'examples - elements' }
GtPhlowToolDetailModelExamples >> containerContainerToolElement [
	<gtExample>
	| aContainerOne aContainerTwo |
	aContainerOne := self containerElement.
	aContainerTwo := self containerWithToolElement.
	aContainerTwo labeled: 'Container Two'.
	aContainerOne addChild: aContainerTwo at: 1 as: #container.
	^ aContainerOne
]

{ #category : #'examples - elements' }
GtPhlowToolDetailModelExamples >> containerElement [
	<gtExample>
	| anElement |
	anElement := self element.
	anElement labeled: 'Container'.

	self showcaseContainerElementConfiguration: anElement.
	
	^ anElement
]

{ #category : #'examples - events' }
GtPhlowToolDetailModelExamples >> containerElementUndefinedResponse [
	<gtExample>
	| aContainer aTool aPreviousDimension aNewDimension aSpace |
	aContainer := self containerWithToolElement.
	aTool := aContainer childAt: 1.
	aPreviousDimension := self requestToolDetailLevel: aTool.
	aSpace := self putInSpace: aContainer.
	aNewDimension := self requestToolDetailLevel: aTool.
	self assert: aNewDimension equals: aPreviousDimension.

	self closeSpace: aSpace with: aContainer.
	^ aContainer
]

{ #category : #'examples - elements' }
GtPhlowToolDetailModelExamples >> containerWithToolElement [
	<gtExample>
	| aContainer aTool |
	aContainer := self containerElement.
	aTool := self toolElement.
	aContainer addChild: aTool at: 1 as: #tool.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> containerWithToolElementAndAptitude [
	<gtExample>
	|  aTool aContainer |
	aContainer := self containerWithToolElement.
	aTool := aContainer childAt: 1.
	aTool aptitude: self lookWithBackgroundChanges.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> containerWithToolElementWithDetailLook_Custom [
	<gtExample>
	|  aContainer aTool aScripter |
	
	aContainer := self containerWithToolElementAndAptitude.
	aTool := aContainer childAt: 1.
	
	aScripter := BlScripter new element: aContainer.
	self setToolDetailLevel: aTool to: (GtPhlowToolDetailState level: #custom).
	aScripter play.

	self assert: aTool background paint color equals: self customBackgroundColor.
	
	^ aScripter elementWithoutParent
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> containerWithToolElementWithDetailLook_Detailed [
	<gtExample>
	|  aContainer aTool aScripter |
	aContainer := self containerWithToolElementAndAptitude.
	aTool := aContainer childAt: 1.
	
	aScripter := BlScripter new element: aContainer.
	self setToolDetailLevel: aTool to: (GtPhlowToolDetailState detailed).
	aScripter play.
	
	self assert: aTool background paint color equals: self detailedBackgroundColor.
	^ aScripter elementWithoutParent
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> containerWithToolElementWithDetailLook_Normal [
	<gtExample>
	|  aContainer aTool aScripter |
	aContainer := self containerWithToolElementAndAptitude.
	aTool := aContainer childAt: 1.
	
	aScripter := BlScripter new element: aContainer.
	self setToolDetailLevel: aTool to: (GtPhlowToolDetailState normal).
	aScripter play.
	
	self assert: aTool background paint color equals: self normalBackgroundColor.
	
	^ aScripter elementWithoutParent
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> containerWithToolElementWithDetailLook_Showcase [
	<gtExample>
	|  aContainer aTool |
	aContainer := self containerWithToolElementAndAptitude.
	aTool := aContainer childAt: 1.
	self lookShowcaseButtonsFor: aContainer in: aTool.
	^ aContainer
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> customBackgroundColor [
	<gtExample>
	^ Color red alpha: 0.3
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> detailedBackgroundColor [
	<gtExample>
	^ Color green alpha: 0.3
]

{ #category : #'examples - elements' }
GtPhlowToolDetailModelExamples >> element [
	<gtExample>
	^ BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ].
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> lookShowcaseButtonFor: aLevelState element: anElement [
	"aSymbol defines what information level should be used by clicking on a button"
	<gtExample>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		label: aLevelState printString;
		action: [ :aButton | anElement states addState: aLevelState ]
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> lookShowcaseButtonsFor: aContainer in: aTool [
	<gtExample>
	| aToolbar |
	aToolbar := BrToolbar new
		aptitude: BrGlamorousToolbarAptitude new;
		constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		addItem: (self 
			lookShowcaseButtonFor: GtPhlowToolDetailState normal element: aContainer);
		addItem: (self
			lookShowcaseButtonFor: GtPhlowToolDetailState detailed element: aContainer);
		addItem: (self
			lookShowcaseButtonFor: (GtPhlowToolDetailState level: #custom) element: aContainer).
	aTool addChild: aToolbar as: #toolbar.
	^ aTool
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> lookWithBackgroundChanges [
	<gtExample>
	^ GtPhlowToolDetailAptitude new
		normal: [ :aStyle | aStyle background: self normalBackgroundColor ];
		detailed: [ :aStyle | aStyle background: self detailedBackgroundColor ];
		level: #custom style: [ :aStyle | aStyle background: self customBackgroundColor ]
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> normalBackgroundColor [
	<gtExample>
	^ Color blue alpha: 0.3
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> requestContainerDetailLevel: anElement [
	<gtExample>
	^ GtPhlowToolDetailState getLevelOf: anElement
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> requestToolDetailLevel: anElement [
	<gtExample>
	^ GtPhlowToolDetailState getLevelOf: anElement
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> setToolDetailLevel: anElement to: aLevelState [
	anElement states addState: aLevelState
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> showcaseContainerElementConfiguration: anElement [
	<gtExample>
	| aLevel aLabel |
	aLevel := GtPhlowToolDetailState getLevelOf: anElement.
	aLabel := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new
				foreground: Color white);
			text: 'Container Level of Detail: ', aLevel asString.
	anElement
		layout: BlFrameLayout new;
		background: (Color black alpha: 0.2);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
			c margin: (BlInsets all: 30) ];
		addChild: (aLabel);
		when: GtPhlowToolDetailChanged
		do: [ :anEvent | aLabel text: 'Container Level of Detail: ', anEvent level asString ].
	^ anElement
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> showcaseToolElementConfiguration: anElement [
	<gtExample>
	| aLevel aLabel |

	aLevel := GtPhlowToolDetailState getLevelOf: anElement.
	
	aLabel := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new
				foreground: Color white);
			text: 'Tool Level of Detail: ', aLevel asString.
	anElement
		layout: BlFrameLayout new;
		background: (Color blue alpha: 0.2);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
			c margin: (BlInsets all: 30) ];
		addChild: (aLabel);
		when: GtPhlowToolDetailChanged
		do: [ :anEvent | aLabel text: 'Tool Level of Detail: ', anEvent level asString ].
	^ anElement
]

{ #category : #'examples - elements' }
GtPhlowToolDetailModelExamples >> toolElement [
	<gtExample>
	| anElement |
	
	anElement := self element.
	anElement labeled: 'Tool'.
	
	"Some configuration for a showcase"
	self showcaseToolElementConfiguration: anElement.
	
	^ anElement
]

{ #category : #'examples - elements' }
GtPhlowToolDetailModelExamples >> toolElementInSpace [
	<gtExample>
	| aContainer aSpace aTool aContainerDimension aToolDimension |
	aContainer := self containerWithToolElement.
	aTool := aContainer childAt: 1.
	aSpace := self putInSpace: aContainer.
	aContainerDimension := self requestToolDetailLevel: aContainer.
	aToolDimension := self requestToolDetailLevel: aTool.
	^ aSpace
]

{ #category : #'examples - tools' }
GtPhlowToolDetailModelExamples >> toolOne [
	<gtExample>
	| aTool anElement |
	aTool := self basicValuableTool.
	aTool valuable: [ 
		BlElement new
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			background: self defaultBackgroundColor;
			addAptitude: self lookWithBackgroundChanges;
			addChild: (self labelWithText: 'One') ].
	aTool name: 'One'.

	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name equals: 'One'.
	^ aTool
]

{ #category : #'examples - tools' }
GtPhlowToolDetailModelExamples >> toolTwo [
	<gtExample>
	| aTool anElement |
	aTool := self basicValuableTool.
	aTool valuable: [ 
		BlElement new
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			background: self defaultBackgroundColor;
			addAptitude: self lookWithBackgroundChanges;
			addChild: (self labelWithText: 'Two') ].
	aTool name: 'Two'.

	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name equals: 'Two'.
	^ aTool
]
