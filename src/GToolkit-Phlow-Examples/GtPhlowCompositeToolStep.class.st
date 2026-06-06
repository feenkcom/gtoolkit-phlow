Class {
	#name : #GtPhlowCompositeToolStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Phlow-Examples-Scripter'
}

{ #category : #assertions }
GtPhlowCompositeToolStep >> assertPhlowToolLabels: aCollectionOfLabels andTypes: aCollectionOfTypes [
	| step |
	step := self
		substeps2: ('Assert phlow tools with labels {1}'
					format: {aCollectionOfLabels asCommaString})
		do: [ :aSubStep | 
			aSubStep check
				label: 'Assert number of tools';
				value: [ :aCompositePhlowTool | aCompositePhlowTool tools size ]
					equals: aCollectionOfLabels size;
				onParentStepTarget: self;
				onPagerToolElement;
				onPhlowToolEntity.
			aSubStep check
				label: 'Assert tool labels';
				value: [ :aCompositePhlowTool | 
						aCompositePhlowTool tools collect: [ :aTool | aTool name ] ]
					equals: aCollectionOfLabels asArray;
				onParentStepTarget: self;
				onPagerToolElement;
				onPhlowToolEntity.
			aSubStep check
				label: 'Assert tool types';
				value: [ :aCompositePhlowTool | 
						aCompositePhlowTool tools collect: [ :aTool | aTool class ] ]
					equals: aCollectionOfTypes asArray;
				onParentStepTarget: self;
				onPagerToolElement;
				onPhlowToolEntity ].
	^ step
]

{ #category : #assertions }
GtPhlowCompositeToolStep >> assertPhlowToolSatisfies: anOneArgBlock description: aDescriptionOneArgBlock [
	^ self check
		label: 'Assert phlow tool condition';
		satisfies: anOneArgBlock description: aDescriptionOneArgBlock;
		referenceSender;
		onParentStepTarget: self;
		onPagerToolElement;
		onPhlowToolEntity.
]

{ #category : #assertions }
GtPhlowCompositeToolStep >> assertPhlowToolTabsCount: aTabsCount [
	^ self check
				label: ('Assert phlow tool tabs count is {1}'
					format: {aTabsCount asString});
				value: [ :aToolElement | aToolElement tabs size ]
					equals: aTabsCount;
				onParentStepTarget: self;
				onPagerToolElement
]

{ #category : #assertions }
GtPhlowCompositeToolStep >> assertPhlowToolTabsHaveBothIconsAndLabels [
		^ self do
				label: ('Assert phlow tool tabs have only icons');
				block: [ :aToolElement | aToolElement tabs do: [ :aTab |
					self assert: aTab widget children size equals: 2.
					self assert: aTab widget children first id equals: (BlElementId named: #icon).
					self assert: aTab widget children second id equals: (BlElementId named: #label)  ] ];
				onParentStepTarget: self;
				onPagerToolElement
]

{ #category : #assertions }
GtPhlowCompositeToolStep >> assertPhlowToolTabsHaveOnlyIcons [
		^ self do
				label: ('Assert phlow tool tabs have only icons');
				block: [ :aToolElement | aToolElement tabs do: [ :aTab |
					self assert: aTab widget children size equals: 1.
					self assert: aTab widget children first id equals: (BlElementId named: #icon) ] ];
				referenceSender;
				onParentStepTarget: self;
				onPagerToolElement
]

{ #category : #assertions }
GtPhlowCompositeToolStep >> assertPhlowToolValue: anOneArgBlock equals: anEqualsBlock [
	^ self check
		label: 'Assert phlow tool condition';
		value: anOneArgBlock equals: anEqualsBlock;
		referenceSender;
		onParentStepTarget: self;
		onPagerToolElement;
		onPhlowToolEntity.
]

{ #category : #assertions }
GtPhlowCompositeToolStep >> assertPhlowToolValueSatisfies: anBlock [
	^ self check
		label: 'Assert phlow tool condition';
		satisfies: anBlock;
		referenceSender;
		onParentStepTarget: self;
		onPagerToolElement;
		onPhlowToolEntity.
]

{ #category : #assertions }
GtPhlowCompositeToolStep >> assertPhlowToolsWithTabLabels: aCollectionOfLabels [
	| anAssertStep |
	anAssertStep := self check
		label: ('Assert tools with labels {1}' 
			format: {aCollectionOfLabels asCommaString});
		value: [ :aToolElement | aToolElement tabs size ]
			equals: aCollectionOfLabels size;
		referenceSender;
		onParentStepTarget: self.

	^ anAssertStep
]

{ #category : #assertions }
GtPhlowCompositeToolStep >> assertSelectedToolAtIndex: anIndex withName: aName [
	^ self assert
		label: ('Assert selected tool at index {1} has label {2}' format: {anIndex asString. aName});
		satisfies: [ :aToolElement | 
				aToolElement viewModel hasSelectedTab
					and: [ aToolElement viewModel selectedTab tabLabel text asString = aName asString ] ]
			description: [ 'There must be a selected tab with name {1}' format: {aName} ];
		onParentStepTarget: self;
		onPagerToolElement
]

{ #category : #actions }
GtPhlowCompositeToolStep >> assertSelectedToolAtIndex: anIndex withTabName: aName [
	| step |
	step := self
		substeps2: ('Assert selected tool at index {1} has tab label and name {2}' 
			format: {anIndex asString. aName})
		do: [ :aSubStep | 
			aSubStep assert
				label: ('Check selected tool tab label');
				satisfies: [ :aToolElement | 
						aToolElement viewModel hasSelectedTab
							and: [ aToolElement viewModel selectedTab tabLabel text asString = aName asString ] ]
					description: [ 'There must be a selected tab with label {1}' format: {aName} ];
				onParentStepTarget: self;
				onPagerToolElement.
				
			aSubStep assert
				label: ('Check selected tool name');
				satisfies: [ :aToolElement | 
						aToolElement viewModel selectedTab widget phlow entity name = aName asString  ]
					description: [ 'There must be a selected tool with name {1}' format: {aName} ];
				onParentStepTarget: self;
				onPagerToolElement.
				
			aSubStep assert
				label: ('Check selected tool tab index');
				satisfies: [ :aToolElement | 
						(aToolElement viewModel indexOf: aToolElement viewModel selectedTab) = anIndex  ] 
					description: [ 'Index of selected tool tab must be {1}' format: {anIndex asString} ];
				onParentStepTarget: self;
				onPagerToolElement ].
	^ step
]

{ #category : #'as yet unclassified' }
GtPhlowCompositeToolStep >> clickOnToolAtIndex: anIndex [
	^ self click
		label: ('Select tool at index {1}' format: {anIndex asString});
		onParentStepTarget: self;
		onPagerToolElement;
		id: #header;
		id: #scrolltabbar;
		id: #tabbar;
		onChildAt: anIndex
]
