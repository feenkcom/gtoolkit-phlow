Class {
	#name : #GtPhlowCompositeToolStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'as yet unclassified' }
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
				referenceSender;
				onParentStepTarget: self;
				onPagerToolElement;
				onPhlowToolEntity.
			aSubStep check
				label: 'Assert tool labels';
				value: [ :aCompositePhlowTool | 
						aCompositePhlowTool tools collect: [ :aTool | aTool name ] ]
					equals: aCollectionOfLabels asArray;
				referenceSender;
				onParentStepTarget: self;
				onPagerToolElement;
				onPhlowToolEntity.
			aSubStep check
				label: 'Assert tool types';
				value: [ :aCompositePhlowTool | 
						aCompositePhlowTool tools collect: [ :aTool | aTool class ] ]
					equals: aCollectionOfTypes asArray;
				referenceSender;
				onParentStepTarget: self;
				onPagerToolElement;
				onPhlowToolEntity  ].


	^ step

		"
		
			
	self assert: mainToolElement tabs size equals: aCollectionOfLabels size.
	self 
		assert: (mainToolElement tabs collect: [ :aTab | 
			aTab tabLabel text asString ])  asArray
		equals: aCollectionOfLabels asArray.
	self 
		assert: (mainToolElement viewModel 
			indexOf:  mainToolElement viewModel selectedTab)
		equals: anIndex."
]

{ #category : #'as yet unclassified' }
GtPhlowCompositeToolStep >> assertPhlowToolSatisfies: anOneArgBlock description: aDescriptionOneArgBlock [
	^ self check
		label: 'Assert phlow tool condition';
		satisfies: anOneArgBlock description: aDescriptionOneArgBlock;
		referenceSender;
		onParentStepTarget: self;
		onPagerToolElement;
		onPhlowToolEntity.
]

{ #category : #'as yet unclassified' }
GtPhlowCompositeToolStep >> assertPhlowToolValue: anOneArgBlock equals: anEqualsBlock [
	^ self check
		label: 'Assert phlow tool condition';
		value: anOneArgBlock equals: anEqualsBlock;
		referenceSender;
		onParentStepTarget: self;
		onPagerToolElement;
		onPhlowToolEntity.
]

{ #category : #'as yet unclassified' }
GtPhlowCompositeToolStep >> assertToolsWithLabels: aCollectionOfLabels [
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
