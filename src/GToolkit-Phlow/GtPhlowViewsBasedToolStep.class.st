Class {
	#name : #GtPhlowViewsBasedToolStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Phlow-Scripter'
}

{ #category : #testing }
GtPhlowViewsBasedToolStep class >> isAbstract [
	^ self name = #GtPhlowViewsBasedToolStep
]

{ #category : #'steps - checks' }
GtPhlowViewsBasedToolStep >> assertHasActionWithIconAndLabel: anActionLabel [
	
	^ self do
				label: ('Assert tool has action with icon and label {1}'
					format: {anActionLabel});
				block: [ :aToolbar | aToolbar items do: [ :anActionElement |
					self assert: anActionElement children size equals: 2.
					self assert: anActionElement children first id equals: (BlElementId named: #icon).
					self assert: anActionElement children second id equals: (BlElementId named: #label)  ] ];
				onParentStepTarget: self;
				referenceSender;
				// #header;
				// #toolbar
]

{ #category : #'steps - checks' }
GtPhlowViewsBasedToolStep >> assertHasExactTabNames: aCollectionOfLabels [
	| step |
	step := self
		substeps2: ('Assert tabs with labels {1}'
					format: {aCollectionOfLabels asCommaString})
		do: [ :aSubStep | 
			aSubStep check
				label: 'Assert number of tabs';
				value: [ :aTabGroup | aTabGroup tabs size ]
					equals: aCollectionOfLabels size;
				onParentStepTarget: self;
				referenceSender;
				// GtPhlowCompositeViewElementId.
			aSubStep check
				label: 'Assert tab labels';
				value: [ :aTabGroup | 
						(aTabGroup tabs collect: [ :aTab | aTab tabLabel text asString ]) asArray ]
					equals: aCollectionOfLabels;
				onParentStepTarget: self;
				referenceSender;
				// GtPhlowCompositeViewElementId ].
	^ step
]

{ #category : #'steps - checks' }
GtPhlowViewsBasedToolStep >> assertHasExactToolActionModelsWithLabels: aCollectionOfLabels [
	| step |
	step := self
		substeps2: ('Assert tool actions model labels are {1}'
					format: {aCollectionOfLabels asCommaString})
		do: [ :aSubStep | 
			aSubStep check
				label: 'Assert number of tool actions';
				value: [ :aToolbar | aToolbar numberOfItems ]
					equals: aCollectionOfLabels size;
				onParentStepTarget: self;
				referenceSender;
				// #header;
				// #titleContainer;
				// #toolbar.
			aSubStep check
				label: 'Assert tool actions model labels';
				value: [ :aToolbar | 
						(aToolbar items collect: [ :anAction | anAction label asString ]) asArray ]
					equals: aCollectionOfLabels;
				onParentStepTarget: self;
				referenceSender;
				// #header;
				// #titleContainer;
				// #toolbar ].
	^ step
]

{ #category : #'steps - checks' }
GtPhlowViewsBasedToolStep >> assertHasExactToolActionsWithIds: aCollectionOfIds [
	| step |
	step := self
		substeps2: ('Assert tool actions with ids {1}'
					format: {aCollectionOfIds asCommaString})
		do: [ :aSubStep | 
			aSubStep check
				label: 'Assert number of tool actions';
				value: [ :aToolbar | aToolbar numberOfItems ]
					equals: aCollectionOfIds size;
				onParentStepTarget: self;
				referenceSender;
				// #header;
				// #titleContainer;
				// #toolbar.
			aSubStep check
				label: 'Assert tool actions ids';
				value: [ :aToolbar | 
						(aToolbar items collect: [ :anAction | anAction id ]) asArray ]
					equals: aCollectionOfIds;
				onParentStepTarget: self;
				referenceSender;
				// #header;
				// #titleContainer;
				// #toolbar ].
	^ step
]

{ #category : #asserting }
GtPhlowViewsBasedToolStep >> assertHasNoTabWithName: aTabName [
	^ self assert
		label: ('Assert tool has no tab named {1}' format: { aTabName });
		satisfies: [ :aTabGroup |
			(aTabGroup tabs noneSatisfy: [ :aTab | aTab tabLabel text asString = aTabName asString ]) ];
		onParentStepTarget: self;
		referenceSender;
		// GtPhlowCompositeViewElementId
]

{ #category : #asserting }
GtPhlowViewsBasedToolStep >> assertHasTabWithName: aTabName [
	^ self assert
		label: ('Assert tool has tab named {1}' format: { aTabName });
		satisfies: [ :aTabGroup |
			(aTabGroup tabs anySatisfy: [ :aTab | aTab tabLabel text asString = aTabName asString ]) ];
		onParentStepTarget: self;
		referenceSender;
		// GtPhlowCompositeViewElementId
]

{ #category : #asserting }
GtPhlowViewsBasedToolStep >> assertHasTabsWithNames: aCollectionOfTabNames [
	aCollectionOfTabNames do: [ :eachTabName |
		self assertHasTabWithName: eachTabName ].
	^ self
]

{ #category : #asserting }
GtPhlowViewsBasedToolStep >> assertHasToolActionWithId: anActionId [
		| step |
	step := self
		substeps2: ('Assert tool has action with id {1}' format: { anActionId })
		do: [ :aSubStep | 
			aSubStep assert
				label: ('Assert button exists');
				exists;
				onParentStepTarget: self;
				referenceSender;
				// #header;
				// #titleContainer;
				// #toolbar;
				// anActionId.
				
			aSubStep assert
				label: ('Assert phlow entity has same id' );
				satisfies: [ :anAction |
					anAction phlow entity id = anActionId ];
				onParentStepTarget: self;
				referenceSender;
				// #header;
				// #titleContainer;
				// #toolbar;
				// anActionId	].
	^ step
]

{ #category : #'steps - checks' }
GtPhlowViewsBasedToolStep >> assertPlaygroundElementIsPresent [
	^ self assert
			label: 'Tool playground exists';
			exists;
			onParentStepTarget: self;
			referenceSender;
			// #playgroundPage
]

{ #category : #'steps - checks' }
GtPhlowViewsBasedToolStep >> assertSelectedTabWithName: aName [
	self assert
		label: ('Assert selected tab is {1}' format: {aName});
		satisfies: [ :aTabGroup | 
				aTabGroup viewModel hasSelectedTab
					and: [ aTabGroup viewModel selectedTab tabLabel text asString = aName asString ] ]
			description: [ 'There must be a selected tab with name {1}' format: {aName} ];
		onParentStepTarget: self;
		referenceSender;
		// GtPhlowCompositeViewElementId
]

{ #category : #'steps - checks' }
GtPhlowViewsBasedToolStep >> assertToolHasActionWithIconAndLabel: anActionLabel [
	| step |
	step := self
		substeps2: ('Assert tool has action with icon and label {1}'
					format: {anActionLabel})
		do: [ :aSubStep | 
			aSubStep check
				label: 'Assert action with given label is present';
				exists;
				onParentStepTarget: self;
				referenceSender;
				// #header;
				// #titleContainer;
				// #toolbar;
				/ [ :anActionElement | anActionElement label asString  = anActionLabel ].
				
			aSubStep do
				label: 'Assert action has label and icon';
				block: [ :aToolbar | 
					aToolbar items 
						detect: [ :anActionElement | anActionElement label asString  = anActionLabel ] 
						ifFound: [ :anActionElement |
							self assert: anActionElement children size equals: 2.
							self assert: anActionElement children first id equals: (BlElementId named: #icon).
							self assert: anActionElement children second id equals: (BlElementId named: #label) ] 
						ifNone: [ Error signal: 'Could not find action' ] ];
				onParentStepTarget: self;
				referenceSender;
				// #header;
				// #titleContainer;
				// #toolbar ].
		
	^ step
]

{ #category : #'steps - interactions' }
GtPhlowViewsBasedToolStep >> clickOnActionWithId: anActionId [
	^ self click
		onParentStepTarget: self;
		referenceSender;
		label: ('Click on action with id {1}' format: { anActionId });
		// #header;
		// #toolbar;
		// anActionId
]

{ #category : #'steps - interactions' }
GtPhlowViewsBasedToolStep >> clickOnTabWithName: aTabName [
	^ self click
		onParentStepTarget: self;
		referenceSender;
		label: ('Click on inspector tab named {1}' format: { aTabName });
		// GtPhlowCompositeViewElementId;
		// BrTab;
		@ [ :aTab | aTab label asString = aTabName ]
]

{ #category : #'steps - interactions' }
GtPhlowViewsBasedToolStep >> dragPlaygroundVerticallyBy: aNumber [
	^ (self mouseDragBy: 0 @ aNumber)
		label: ('Drag inspector playground by {1}' format: { aNumber });
		referenceSender;
		// LeInspectorPlaygroundResizerId
]
