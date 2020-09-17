"
I exemplify ${class:TGtPhlowSendTransformable}$ and ${class:TGtPhlowSendTreeNodeTransformable}$.

"
Trait {
	#name : #TGtPhlowSendTransformationExamples,
	#traits : 'TGtSpaceExamples',
	#classTraits : 'TGtSpaceExamples classTrait',
	#category : #'GToolkit-Phlow-Examples - Views'
}

{ #category : #'examples - support' }
TGtPhlowSendTransformationExamples >> doubleClickItemAt: anIndex for: anElement [
	<gtExample>
	"Double click on an item at anIndex in anElement (list, tree)"
	| anInfiniteElement anItemElement |
	anElement 
		allChildrenBreadthFirstDetect: [ :eachChild | 
			(eachChild isKindOf: BlInfiniteElement) ]
		ifFound: [ :aChild | anInfiniteElement := aChild ].
	self 
		assert: anInfiniteElement isNotNil 
		description: [ 'Cannot find an infinite element in ', anElement asString ].
	self 
		assert: anInfiniteElement childrenCount >= anIndex 
		description: [ anElement asString, '''s infinite element has ', anInfiniteElement childrenCount asString, 
			' children. Cannot double click on an item at ', anIndex asString, ' position.' ].
	anItemElement := anInfiniteElement childAt: anIndex.
	BlSpace simulateDoubleClickOn: anItemElement.
]

{ #category : #'examples - support' }
TGtPhlowSendTransformationExamples >> elementItemsFor: anElement [
	"Return element items"
	<gtExample>
	^ self explicitRequirement
]

{ #category : #'examples - support' }
TGtPhlowSendTransformationExamples >> itemsFor: anElement ofSize: anAmount [
	<gtExample>
	| theItems |
	theItems := self elementItemsFor: anElement.
	self assert: theItems size equals: anAmount.
	^ theItems
]

{ #category : #'examples - support' }
TGtPhlowSendTransformationExamples >> selectItemAt: anIndex for: anElement [
	<gtExample>
	"Select an item at anIndex in anElement (list, tree)"
	self explicitRequirement
]

{ #category : #'examples - support' }
TGtPhlowSendTransformationExamples >> sendNumberAddition [
	<gtExample>
	^ 200
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendObject_Block [
	<gtExample>
	| view element |
	view := self viewWithTenItems.
	view send: [ :aNumber :aSelectionIndices | 
		aNumber + self sendNumberAddition ].
	view asElementDo: [ :el | element := el ].
	self itemsFor: element ofSize: 10.
	^ view
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendObject_Block_Element [
	<gtExample>
	| view element |
	view := self sendObject_Block.
	view asElementDo: [ :el | element := el ].
	self itemsFor: element ofSize: 10.
	^ element
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendObject_Block_Element_DoubleClickEvent [
	<gtExample>
	| anElement aCollection |
	aCollection := OrderedCollection new.
	anElement := self sendObject_Block_Element.
	anElement size: 600@400; forceLayout.
	anElement 
		addEventHandlerOn: GtPhlowObjectEvent 
		do: [ :anEvent | aCollection add: anEvent ].
	self doubleClickItemAt: 1 for: anElement.
	self assert: aCollection size equals: 2.
	self assert: aCollection first class equals: GtPhlowObjectToSelect.
	self assert: aCollection second class equals: GtPhlowObjectToSpawn.
	self assert: aCollection first object equals: 201.
	self assert: aCollection second object equals: 201.
	
	^ anElement
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendObject_Block_Element_SelectEvent [
	<gtExample>
	| anElement aCollection |
	aCollection := OrderedCollection new.
	anElement := self sendObject_Block_Element.
	anElement 
		addEventHandlerOn: GtPhlowObjectEvent 
		do: [ :anEvent | aCollection add: anEvent ].
	self selectItemAt: 1 for: anElement.
	self assert: aCollection size equals: 1.
	self assert: aCollection first class equals: GtPhlowObjectToSelect.
	self assert: aCollection first object equals: 201.
	^ anElement
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendObject_Symbol [
	<gtExample>
	| view element |
	view := self viewWithTenItems.
	view send: #negated.
	view asElementDo: [ :el | element := el ].
	self itemsFor: element ofSize: 10.
	^ view
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendObject_Symbol_Element [
	<gtExample>
	| view element |
	view := self sendObject_Symbol.
	view asElementDo: [ :el | element := el ].
	self itemsFor: element ofSize: 10.
	^ element
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendObject_Symbol_Element_SelectEvent [
	<gtExample>
	| anElement aCollection |
	aCollection := OrderedCollection new.
	anElement := self sendObject_Symbol_Element.
	anElement 
		addEventHandlerOn: GtPhlowObjectEvent 
		do: [ :anEvent | aCollection add: anEvent ].
	self selectItemAt: 1 for: anElement.
	self assert: aCollection size equals: 1.
	self assert: aCollection first class equals: GtPhlowObjectToSelect.
	self assert: aCollection first object equals: -1.
	^ anElement
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendTool [
	<gtExample>
	| view element |
	view := self viewWithTenItems.
	view sendTool: [ :aNumber | GtPhlowValuableTool new
		valuable: [ BrFrame new
			labeled: 'tool';
			matchParent;
			alignCenter;
			addChild: (BrLabel new
				look: BrGlamorousLabelLook;
				text: aNumber;
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ]) ] ].
	view asElementDo: [ :el | element := el ].
	self itemsFor: element ofSize: 10.
	^ view
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendTool_Element [
	<gtExample>
	| view element |
	view := self sendTool.
	view asElementDo: [ :el | element := el ].
	self itemsFor: element ofSize: 10.
	^ element
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendTool_Element_SelectEvent [
	<gtExample>
	| anElement aCollection |
	aCollection := OrderedCollection new.
	anElement := self sendTool_Element.
	anElement 
		addEventHandlerOn: GtPhlowObjectEvent 
		do: [ :anEvent | aCollection add: anEvent ].
	self selectItemAt: 1 for: anElement.
	self assert: aCollection size equals: 1.
	self assert: aCollection first class equals: GtPhlowObjectToSelect.
	self assert: aCollection first tool class equals: GtPhlowValuableTool.
	
	^ anElement
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendTool_Element_SelectEvent_Tool [
	<gtExample>
	| anElement aCollection |
	aCollection := OrderedCollection new.
	anElement := self sendTool_Element.
	anElement 
		addEventHandlerOn: GtPhlowObjectEvent 
		do: [ :anEvent | aCollection add: anEvent ].
	self selectItemAt: 1 for: anElement.
	self assert: aCollection size equals: 1.
	self assert: aCollection first class equals: GtPhlowObjectToSelect.
	self assert: aCollection first tool class equals: GtPhlowValuableTool.
	
	^ aCollection first tool.
]

{ #category : #'examples - transformation' }
TGtPhlowSendTransformationExamples >> sendTool_Element_SelectEvent_ToolElement [
	<gtExample>
	| aTool anElement aLabel |
	aTool := self sendTool_Element_SelectEvent_Tool.
	anElement := aTool asElement.

	self assert: anElement class equals: BrFrame.
	self assert: anElement childrenCount equals: 1.
	
	aLabel := anElement childAt: 1.
	self assert: aLabel class equals: BrLabel.
	self assert: aLabel text characters equals: '1'.
	
	^ anElement
]

{ #category : #'examples - view' }
TGtPhlowSendTransformationExamples >> viewWithTenItems [
	"Return an initialized view with 10 (root) items"
	<gtExample>
	^ self explicitRequirement
]
