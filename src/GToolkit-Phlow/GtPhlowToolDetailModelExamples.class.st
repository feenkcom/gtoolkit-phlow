"
I exemplify ${class:GtPhlowToolAbstractDetailModel}$.
"
Class {
	#name : #GtPhlowToolDetailModelExamples,
	#superclass : #GtPhlowToolExamples,
	#category : #'GToolkit-Phlow-Tool - Examples'
}

{ #category : #'examples - models' }
GtPhlowToolDetailModelExamples >> basicContainerDetailModel [
	<gtExample>
	| aModel |
	aModel := GtPhlowToolContainerDetailModel new.
	self assert: aModel level isNotNil.
	self
		assert: aModel level
		equals: GtPhlowToolDetailState undefinedName.
	^ aModel
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> basicToolDetailLook [
	<gtExample>
	| aLook |
	aLook := GtPhlowToolDetailLook new.
	^ aLook
]

{ #category : #'examples - models' }
GtPhlowToolDetailModelExamples >> basicToolDetailModel [
	<gtExample>
	| aModel |
	aModel := GtPhlowToolDetailModel new.
	self assert: aModel level isNotNil.
	self assert: aModel level equals: GtPhlowToolDetailState normalName.
	^ aModel
]

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
	aContainerOne dispatchEvent: GtPhlowToolDetailWish beDetailedLevel.

	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.

	aContainerOneLevel := self requestToolDetailLevel: aContainerOne.
	aContainerTwoLevel := self requestToolDetailLevel: aContainerTwo.
	aToolLevel := self requestToolDetailLevel: aTool.

	self assert: aContainerOneLevel equals: GtPhlowToolDetailState detailedName.
	self assert: aContainerTwoLevel equals: GtPhlowToolDetailState undefinedName.
	self assert: aToolLevel equals: GtPhlowToolDetailState normalName.

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
	self assert: aReceivedDimension equals: GtPhlowToolDetailState detailedName.

	aContainerOneDimension := self requestToolDetailLevel: aContainerOne.
	aContainerTwoDimension := self requestToolDetailLevel: aContainerTwo.
	aToolDimension := self requestToolDetailLevel: aTool.

	self assert: aContainerOneDimension equals: GtPhlowToolDetailState detailedName.
	self assert: aContainerTwoDimension equals: GtPhlowToolDetailState undefinedName.
	self assert: aToolDimension equals: GtPhlowToolDetailState normalName.

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

	self assert: aContainerOneDimension equals: GtPhlowToolDetailState detailedName.
	self assert: aContainerTwoDimension equals: GtPhlowToolDetailState undefinedName.
	self assert: aToolDimension equals: GtPhlowToolDetailState detailedName.

	self closeSpace: aSpace with: aContainerOne.
	^ aContainerOne
]

{ #category : #'examples - events' }
GtPhlowToolDetailModelExamples >> containerContainerToolDetailedResponse [
	<gtExample>
	| aContainerOne aTool aPreviousDimension aNewDimension aContainerDimension aSpace aContainerTwo |
	aContainerOne := self containerContainerToolElement.
	aContainerOne dispatchEvent: GtPhlowToolDetailWish beDetailedLevel.
	aContainerDimension := self requestToolDetailLevel: aContainerOne.
	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.
	aPreviousDimension := self requestToolDetailLevel: aTool.
	self assert: aPreviousDimension ~= aContainerDimension.
	aSpace := self putInSpace: aContainerOne.
	aNewDimension := self requestToolDetailLevel: aTool.
	self assert: aNewDimension ~= aPreviousDimension.
	self assert: aNewDimension equals: aContainerDimension.
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
	| anElement aDimension |
	anElement := self element.
	anElement labeled: 'Container'.
	anElement addInteractiveModelState: self basicContainerDetailModel.
	aDimension := self requestToolDetailLevel: anElement.
	self 
		assert: aDimension
		equals: self basicContainerDetailModel defaultLevel.

	self showcaseContainerElementConfiguration: anElement.
	
	^ anElement
]

{ #category : #'examples - events' }
GtPhlowToolDetailModelExamples >> containerElementDetailedResponse [
	<gtExample>
	| aContainer aTool aPreviousToolLevel aNewToolLevel aContainerLevel aSpace |

	"Define a tool with a detailed level."
	aContainer := self containerWithToolElement.
	aContainer dispatchEvent: GtPhlowToolDetailWish beDetailedLevel.
	aContainerLevel := self requestToolDetailLevel: aContainer.
	
	"Request a current tool level."
	aTool := aContainer childAt: 1.
	aPreviousToolLevel := self requestToolDetailLevel: aTool.
	self assert: aPreviousToolLevel ~= aContainerLevel.

	"By attaching the widget into a space, 
	the tool will ask its parents for a level of detail that should be used."
	aSpace := self putInSpace: aContainer.
	aNewToolLevel := self requestToolDetailLevel: aTool.
	self assert: aNewToolLevel ~= aPreviousToolLevel.
	self assert: aNewToolLevel equals: aContainerLevel.

	self closeSpace: aSpace with: aContainer.
	^ aContainer
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
GtPhlowToolDetailModelExamples >> containerWithToolElementWithDetailLook [
	<gtExample>
	|  aTool aContainer |
	aContainer := self containerWithToolElement.
	aTool := aContainer childAt: 1.
	aTool look: self lookWithBackgroundChanges.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> containerWithToolElementWithDetailLook_Custom [
	<gtExample>
	|  aContainer aTool |
	aContainer := self containerWithToolElementWithDetailLook.
	aTool := aContainer childAt: 1.
	aTool dispatchEvent: (GtPhlowToolDetailWish beLevel: #custom).
	self assert: aTool background paint color equals: self customBackgroundColor.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> containerWithToolElementWithDetailLook_Detailed [
	<gtExample>
	|  aContainer aTool |
	aContainer := self containerWithToolElementWithDetailLook.
	aTool := aContainer childAt: 1.
	aTool dispatchEvent: GtPhlowToolDetailWish beDetailedLevel.
	self assert: aTool background paint color equals: self detailedBackgroundColor.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> containerWithToolElementWithDetailLook_Normal [
	<gtExample>
	|  aContainer aTool |
	aContainer := self containerWithToolElementWithDetailLook.
	aTool := aContainer childAt: 1.
	aTool dispatchEvent: GtPhlowToolDetailWish beNormalLevel.
	self assert: aTool background paint color equals: self normalBackgroundColor.
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

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> lookWithBackgroundChanges [
	<gtExample>
	| aLook |
	aLook := self basicToolDetailLook.
	aLook 
		normal: [ :aWidget | 
			aWidget background: self normalBackgroundColor ];
		detailed: [ :aWidget | aWidget background: self detailedBackgroundColor ];
		level: #custom style: [ :aWidget | aWidget background: self customBackgroundColor ].
	^ aLook
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> normalBackgroundColor [
	<gtExample>
	^ Color blue alpha: 0.3
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> requestContainerDetailLevel: anElement [
	<gtExample>
	| aRequest |
	aRequest := GtPhlowToolContainerDetailRequest new.
	anElement fireEvent: aRequest.
	^ aRequest response level
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> requestToolDetailLevel: anElement [
	<gtExample>
	| aRequest |
	aRequest := BrInteractionRequest new.
	aRequest canBePropagated: false.
	anElement dispatchEvent: aRequest.
	self assert: aRequest response states size equals: 1.
	^ aRequest response states anyOne level
]

{ #category : #'examples - support' }
GtPhlowToolDetailModelExamples >> showcaseContainerElementConfiguration: anElement [
	<gtExample>
	| aLevel aLabel |
	aLevel := self requestToolDetailLevel: anElement.
	aLabel := BrLabel new
			look: (BrGlamorousLabelLook new
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
	aLevel := self requestToolDetailLevel: anElement.
	aLabel := BrLabel new
			look: (BrGlamorousLabelLook new
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
	| anElement aLevel |
	anElement := self element.
	anElement labeled: 'Tool'.
	anElement addInteractiveModelState: self basicToolDetailModel.
	aLevel := self requestToolDetailLevel: anElement.
	self 
		assert: aLevel
		equals: self basicToolDetailModel defaultLevel.
	
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
	self 
		assert: aContainerDimension
		equals: self basicContainerDetailModel defaultLevel.
	self 
		assert: aToolDimension 
		equals: self basicToolDetailModel defaultLevel.
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
			addInteractiveModelState: self basicToolDetailModel;
			addLook: self lookWithBackgroundChanges;
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
			addInteractiveModelState: self basicToolDetailModel;
			addLook: self lookWithBackgroundChanges;
			addChild: (self labelWithText: 'Two') ].
	aTool name: 'Two'.

	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name equals: 'Two'.
	^ aTool
]
