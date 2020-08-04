Class {
	#name : #GtPhlowToolVolumeModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Tool - Examples'
}

{ #category : #'examples - tools' }
GtPhlowToolVolumeModelExamples >> basicCompositeTool [
	<gtExample>
	| aTool anElement |
	aTool := GtPhlowCompositeTool new.
	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name isString.
	^ aTool
]

{ #category : #'examples - models' }
GtPhlowToolVolumeModelExamples >> basicContainerVolumeModel [
	<gtExample>
	| aModel |
	aModel := GtPhlowToolContainerVolumeModel new.
	self assert: aModel dimension isNotNil.
	self assert: aModel dimension equals: GtPhlowToolVolumeState undefinedName.
	^ aModel
]

{ #category : #'examples - looks' }
GtPhlowToolVolumeModelExamples >> basicToolVolumeLook [
	<gtExample>
	| aLook |
	aLook := GtPhlowToolVolumeLook new.
	^ aLook
]

{ #category : #'examples - models' }
GtPhlowToolVolumeModelExamples >> basicToolVolumeModel [
	<gtExample>
	| aModel |
	aModel := GtPhlowToolVolumeModel new.
	self assert: aModel dimension isNotNil.
	self assert: aModel dimension equals: GtPhlowToolVolumeState normalName.
	^ aModel
]

{ #category : #'examples - tools' }
GtPhlowToolVolumeModelExamples >> basicValuableTool [
	<gtExample>
	| aTool anElement |
	aTool := GtPhlowValuableTool new.
	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name isString.
	^ aTool
]

{ #category : #'examples - tools' }
GtPhlowToolVolumeModelExamples >> compositeTool [
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
GtPhlowToolVolumeModelExamples >> containerContainerToolDetailedResponse [
	<gtExample>
	| aContainerOne aTool aPreviousDimension aNewDimension aContainerDimension aSpace aContainerTwo |
	aContainerOne := self containerContainerToolElement.
	aContainerOne dispatchEvent: GtPhlowToolVolumeWish beDetailedTool.
	aContainerDimension := self requestToolVolumeDimension: aContainerOne.
	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.
	aPreviousDimension := self requestToolVolumeDimension: aTool.
	self assert: aPreviousDimension ~= aContainerDimension.
	aSpace := self putInSpace: aContainerOne.
	aNewDimension := self requestToolVolumeDimension: aTool.
	self assert: aNewDimension ~= aPreviousDimension.
	self assert: aNewDimension equals: aContainerDimension.
	^ aSpace
]

{ #category : #'examples - events' }
GtPhlowToolVolumeModelExamples >> containerContainerToolDetailedVolume [
	<gtExample>
	| aContainerOne aTool aContainerOneDimension aContainerTwo aContainerTwoDimension aToolDimension |
	aContainerOne := self containerContainerToolElement.
	aContainerOne dispatchEvent: GtPhlowToolVolumeWish beDetailedTool.

	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.

	aContainerOneDimension := self requestToolVolumeDimension: aContainerOne.
	aContainerTwoDimension := self requestToolVolumeDimension: aContainerTwo.
	aToolDimension := self requestToolVolumeDimension: aTool.

	self assert: aContainerOneDimension equals: GtPhlowToolVolumeState detailedName.
	self assert: aContainerTwoDimension equals: GtPhlowToolVolumeState undefinedName.
	self assert: aToolDimension equals: GtPhlowToolVolumeState normalName.

	^ aContainerOne
]

{ #category : #'examples - events' }
GtPhlowToolVolumeModelExamples >> containerContainerToolDetailedVolume_ContainerVolumeReponse [
	<gtExample>
	| aContainerOne aTool aContainerOneDimension aContainerTwo aContainerTwoDimension aToolDimension aReceivedDimension |
	aContainerOne := self containerContainerToolElement.

	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.

	aReceivedDimension := self requestContainerVolumeDimension: aTool.
	self assert: aReceivedDimension equals: GtPhlowToolVolumeState detailedName.

	aContainerOneDimension := self requestToolVolumeDimension: aContainerOne.
	aContainerTwoDimension := self requestToolVolumeDimension: aContainerTwo.
	aToolDimension := self requestToolVolumeDimension: aTool.

	self assert: aContainerOneDimension equals: GtPhlowToolVolumeState detailedName.
	self assert: aContainerTwoDimension equals: GtPhlowToolVolumeState undefinedName.
	self assert: aToolDimension equals: GtPhlowToolVolumeState normalName.

	^ aContainerOne
]

{ #category : #'examples - events' }
GtPhlowToolVolumeModelExamples >> containerContainerToolDetailedVolume_InSpace [
	<gtExample>
	| aContainerOne aTool aSpace aContainerTwo aContainerOneDimension aContainerTwoDimension aToolDimension |
	aContainerOne := self containerContainerToolDetailedVolume.
	aContainerTwo := aContainerOne childAt: 1.
	aTool := aContainerTwo childAt: 1.

	aSpace := self putInSpace: aContainerOne.

	aContainerOneDimension := self requestToolVolumeDimension: aContainerOne.
	aContainerTwoDimension := self requestToolVolumeDimension: aContainerTwo.
	aToolDimension := self requestToolVolumeDimension: aTool.

	self assert: aContainerOneDimension equals: GtPhlowToolVolumeState detailedName.
	self assert: aContainerTwoDimension equals: GtPhlowToolVolumeState undefinedName.
	self assert: aToolDimension equals: GtPhlowToolVolumeState detailedName.

	^ aSpace
]

{ #category : #'examples - elements' }
GtPhlowToolVolumeModelExamples >> containerContainerToolElement [
	<gtExample>
	| aContainerOne aContainerTwo |
	aContainerOne := self containerElement.
	aContainerTwo := self containerWithToolElement.
	aContainerTwo labeled: 'Container Two'.
	aContainerOne addChild: aContainerTwo.
	^ aContainerOne
]

{ #category : #'examples - elements' }
GtPhlowToolVolumeModelExamples >> containerElement [
	<gtExample>
	| anElement aDimension |
	anElement := self element.
	anElement labeled: 'Container'.
	anElement addInteractiveModelState: self basicContainerVolumeModel.
	aDimension := self requestToolVolumeDimension: anElement.
	self 
		assert: aDimension
		equals: self basicContainerVolumeModel defaultDimension.
	^ anElement
]

{ #category : #'examples - events' }
GtPhlowToolVolumeModelExamples >> containerElementDetailedResponse [
	<gtExample>
	| aContainer aTool aPreviousDimension aNewDimension aContainerDimension aSpace |
	aContainer := self containerWithToolElement.
	aContainer dispatchEvent: GtPhlowToolVolumeWish beDetailedTool.
	aContainerDimension := self requestToolVolumeDimension: aContainer.
	aTool := aContainer childAt: 1.
	aPreviousDimension := self requestToolVolumeDimension: aTool.
	self assert: aPreviousDimension ~= aContainerDimension.
	aSpace := self putInSpace: aContainer.
	aNewDimension := self requestToolVolumeDimension: aTool.
	self assert: aNewDimension ~= aPreviousDimension.
	self assert: aNewDimension equals: aContainerDimension.
	^ aSpace
]

{ #category : #'examples - events' }
GtPhlowToolVolumeModelExamples >> containerElementUndefinedResponse [
	<gtExample>
	| aContainer aTool aPreviousDimension aNewDimension aSpace |
	aContainer := self containerWithToolElement.
	aTool := aContainer childAt: 1.
	aPreviousDimension := self requestToolVolumeDimension: aTool.
	aSpace := self putInSpace: aContainer.
	aNewDimension := self requestToolVolumeDimension: aTool.
	self assert: aNewDimension equals: aPreviousDimension.
	^ aSpace
]

{ #category : #'examples - elements' }
GtPhlowToolVolumeModelExamples >> containerWithToolElement [
	<gtExample>
	| aContainer aTool |
	aContainer := self containerElement.
	aTool := self toolElement.
	aContainer addChild: aTool.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolVolumeModelExamples >> containerWithToolElementWithVolumeLook [
	<gtExample>
	|  aTool aContainer |
	aContainer := self containerWithToolElement.
	aTool := aContainer childAt: 1.
	aTool look: self lookWithBackgroundChanges.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolVolumeModelExamples >> containerWithToolElementWithVolumeLook_Custom [
	<gtExample>
	|  aContainer aTool |
	aContainer := self containerWithToolElementWithVolumeLook.
	aTool := aContainer childAt: 1.
	aTool dispatchEvent: (GtPhlowToolVolumeWish beVolume: #custom).
	self assert: aTool background paint color equals: self customBackgroundColor.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolVolumeModelExamples >> containerWithToolElementWithVolumeLook_Detailed [
	<gtExample>
	|  aContainer aTool |
	aContainer := self containerWithToolElementWithVolumeLook.
	aTool := aContainer childAt: 1.
	aTool dispatchEvent: GtPhlowToolVolumeWish beDetailedTool.
	self assert: aTool background paint color equals: self detailedBackgroundColor.
	^ aContainer
]

{ #category : #'examples - looks' }
GtPhlowToolVolumeModelExamples >> containerWithToolElementWithVolumeLook_Normal [
	<gtExample>
	|  aContainer aTool |
	aContainer := self containerWithToolElementWithVolumeLook.
	aTool := aContainer childAt: 1.
	aTool dispatchEvent: GtPhlowToolVolumeWish beNormalTool.
	self assert: aTool background paint color equals: self normalBackgroundColor.
	^ aContainer
]

{ #category : #'examples - support' }
GtPhlowToolVolumeModelExamples >> customBackgroundColor [
	<gtExample>
	^ Color red alpha: 0.3
]

{ #category : #'examples - support' }
GtPhlowToolVolumeModelExamples >> defaultBackgroundColor [
	<gtExample>
	^ Color yellow alpha: 0.3
]

{ #category : #'examples - support' }
GtPhlowToolVolumeModelExamples >> detailedBackgroundColor [
	<gtExample>
	^ Color green alpha: 0.3
]

{ #category : #'examples - elements' }
GtPhlowToolVolumeModelExamples >> element [
	<gtExample>
	^ BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ].
]

{ #category : #'examples - support' }
GtPhlowToolVolumeModelExamples >> labelWithText: aString [
	<gtExample>
	^ BrLabel new
		look: BrGlamorousLabelLook;
		fitContent;
		alignCenter;
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		text: aString
]

{ #category : #'examples - looks' }
GtPhlowToolVolumeModelExamples >> lookWithBackgroundChanges [
	<gtExample>
	| aLook |
	aLook := self basicToolVolumeLook.
	aLook 
		normal: [ :aWidget | 
			aWidget background: self normalBackgroundColor ];
		detailed: [ :aWidget | aWidget background: self detailedBackgroundColor ];
		volume: #custom style: [ :aWidget | aWidget background: self customBackgroundColor ].
	^ aLook
]

{ #category : #'examples - spaces' }
GtPhlowToolVolumeModelExamples >> newSpace [
	<gtExample>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Phlow Tool Volume Examples'.
	aSpace extent: 600@400.
	aSpace withHalos.
	^ aSpace
]

{ #category : #'examples - support' }
GtPhlowToolVolumeModelExamples >> normalBackgroundColor [
	<gtExample>
	^ Color blue alpha: 0.3
]

{ #category : #'examples - spaces' }
GtPhlowToolVolumeModelExamples >> putInSpace: aBlElement [
	<gtExample>
	| aSpace |
	self 
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	aSpace := self newSpace.
	aSpace root addChild: aBlElement.
	^ aSpace
]

{ #category : #'examples - support' }
GtPhlowToolVolumeModelExamples >> requestContainerVolumeDimension: anElement [
	<gtExample>
	| aRequest |
	aRequest := GtPhlowToolContainerVolumeRequest new.
	anElement fireEvent: aRequest.
	^ aRequest response dimension
]

{ #category : #'examples - support' }
GtPhlowToolVolumeModelExamples >> requestToolVolumeDimension: anElement [
	<gtExample>
	| aRequest |
	aRequest := BrInteractionRequest new.
	aRequest canBePropagated: false.
	anElement dispatchEvent: aRequest.
	self assert: aRequest response states size equals: 1.
	^ aRequest response states anyOne dimension
]

{ #category : #'examples - elements' }
GtPhlowToolVolumeModelExamples >> toolElement [
	<gtExample>
	| anElement aDimension |
	anElement := self element.
	anElement labeled: 'Tool'.
	anElement addInteractiveModelState: self basicToolVolumeModel.
	aDimension := self requestToolVolumeDimension: anElement.
	self 
		assert: aDimension
		equals: self basicToolVolumeModel defaultDimension.
	^ anElement
]

{ #category : #'examples - elements' }
GtPhlowToolVolumeModelExamples >> toolElementInSpace [
	<gtExample>
	| aContainer aSpace aTool aContainerDimension aToolDimension |
	aContainer := self containerWithToolElement.
	aTool := aContainer childAt: 1.
	aSpace := self putInSpace: aContainer.
	aContainerDimension := self requestToolVolumeDimension: aContainer.
	aToolDimension := self requestToolVolumeDimension: aTool.
	self 
		assert: aContainerDimension
		equals: self basicContainerVolumeModel defaultDimension.
	self 
		assert: aToolDimension 
		equals: self basicToolVolumeModel defaultDimension.
	^ aSpace
]

{ #category : #'examples - tools' }
GtPhlowToolVolumeModelExamples >> toolOne [
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
			addInteractiveModelState: self basicToolVolumeModel;
			addLook: self lookWithBackgroundChanges;
			addChild: (self labelWithText: 'One') ].
	aTool name: 'One'.

	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name equals: 'One'.
	^ aTool
]

{ #category : #'examples - tools' }
GtPhlowToolVolumeModelExamples >> toolTwo [
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
			addInteractiveModelState: self basicToolVolumeModel;
			addLook: self lookWithBackgroundChanges;
			addChild: (self labelWithText: 'Two') ].
	aTool name: 'Two'.

	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name equals: 'Two'.
	^ aTool
]
