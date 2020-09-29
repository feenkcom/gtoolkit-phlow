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
GtPhlowToolDetailModelExamples >> containerContainerToolDetailedResponse [
	<gtExample>
	| aContainerOne aTool aPreviousDimension aNewDimension aContainerDimension aSpace aContainerTwo |
	aContainerOne := self containerContainerToolElement.
	aContainerOne dispatchEvent: GtPhlowToolDetailWish beDetailedTool.
	aContainerDimension := self requestToolDetailLevel: aContainerOne.
	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.
	aPreviousDimension := self requestToolDetailLevel: aTool.
	self assert: aPreviousDimension ~= aContainerDimension.
	aSpace := self putInSpace: aContainerOne.
	aNewDimension := self requestToolDetailLevel: aTool.
	self assert: aNewDimension ~= aPreviousDimension.
	self assert: aNewDimension equals: aContainerDimension.
	^ aSpace
]

{ #category : #'examples - events' }
GtPhlowToolDetailModelExamples >> containerContainerToolDetailedVolume [
	<gtExample>
	| aContainerOne aTool aContainerOneDimension aContainerTwo aContainerTwoDimension aToolDimension |
	aContainerOne := self containerContainerToolElement.
	aContainerOne dispatchEvent: GtPhlowToolDetailWish beDetailedTool.

	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.

	aContainerOneDimension := self requestToolDetailLevel: aContainerOne.
	aContainerTwoDimension := self requestToolDetailLevel: aContainerTwo.
	aToolDimension := self requestToolDetailLevel: aTool.

	self assert: aContainerOneDimension equals: GtPhlowToolDetailState detailedName.
	self assert: aContainerTwoDimension equals: GtPhlowToolDetailState undefinedName.
	self assert: aToolDimension equals: GtPhlowToolDetailState normalName.

	^ aContainerOne
]

{ #category : #'examples - events' }
GtPhlowToolDetailModelExamples >> containerContainerToolDetailedVolume_ContainerVolumeReponse [
	<gtExample>
	| aContainerOne aTool aContainerOneDimension aContainerTwo aContainerTwoDimension aToolDimension aReceivedDimension |
	aContainerOne := self containerContainerToolDetailedVolume.

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
GtPhlowToolDetailModelExamples >> containerContainerToolDetailedVolume_InSpace [
	<gtExample>
	| aContainerOne aTool aSpace aContainerTwo aContainerOneDimension aContainerTwoDimension aToolDimension |
	aContainerOne := self containerContainerToolDetailedVolume.
	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.

	aSpace := self putInSpace: aContainerOne.

	aContainerOneDimension := self requestToolDetailLevel: aContainerOne.
	aContainerTwoDimension := self requestToolDetailLevel: aContainerTwo.
	aToolDimension := self requestToolDetailLevel: aTool.

	self assert: aContainerOneDimension equals: GtPhlowToolDetailState detailedName.
	self assert: aContainerTwoDimension equals: GtPhlowToolDetailState undefinedName.
	self assert: aToolDimension equals: GtPhlowToolDetailState detailedName.

	^ aSpace
]

{ #category : #'examples - elements' }
GtPhlowToolDetailModelExamples >> containerContainerToolElement [
	<gtExample>
	| aContainerOne aContainerTwo |
	aContainerOne := self containerElement.
	aContainerTwo := self containerWithToolElement.
	aContainerTwo labeled: 'Container Two'.
	aContainerOne addChild: aContainerTwo.
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
	^ anElement
]

{ #category : #'examples - events' }
GtPhlowToolDetailModelExamples >> containerElementDetailedResponse [
	<gtExample>
	| aContainer aTool aPreviousDimension aNewDimension aContainerDimension aSpace |
	aContainer := self containerWithToolElement.
	aContainer dispatchEvent: GtPhlowToolDetailWish beDetailedTool.
	aContainerDimension := self requestToolDetailLevel: aContainer.
	aTool := aContainer childAt: 1.
	aPreviousDimension := self requestToolDetailLevel: aTool.
	self assert: aPreviousDimension ~= aContainerDimension.
	aSpace := self putInSpace: aContainer.
	aNewDimension := self requestToolDetailLevel: aTool.
	self assert: aNewDimension ~= aPreviousDimension.
	self assert: aNewDimension equals: aContainerDimension.
	^ aSpace
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
	^ aSpace
]

{ #category : #'examples - elements' }
GtPhlowToolDetailModelExamples >> containerWithToolElement [
	<gtExample>
	| aContainer aTool |
	aContainer := self containerElement.
	aTool := self toolElement.
	aContainer addChild: aTool.
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
	aTool dispatchEvent: GtPhlowToolDetailWish beDetailedTool.
	self assert: aTool background paint color equals: self detailedBackgroundColor.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolDetailModelExamples >> containerWithToolElementWithDetailLook_Normal [
	<gtExample>
	|  aContainer aTool |
	aContainer := self containerWithToolElementWithDetailLook.
	aTool := aContainer childAt: 1.
	aTool dispatchEvent: GtPhlowToolDetailWish beNormalTool.
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

{ #category : #'examples - elements' }
GtPhlowToolDetailModelExamples >> toolElement [
	<gtExample>
	| anElement aDimension |
	anElement := self element.
	anElement labeled: 'Tool'.
	anElement addInteractiveModelState: self basicToolDetailModel.
	aDimension := self requestToolDetailLevel: anElement.
	self 
		assert: aDimension
		equals: self basicToolDetailModel defaultLevel.
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
