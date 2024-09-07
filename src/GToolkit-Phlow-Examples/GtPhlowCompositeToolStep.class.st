Class {
	#name : #GtPhlowCompositeToolStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'as yet unclassified' }
GtPhlowCompositeToolStep >> assertToolsWithLabels: aCollectionOfLabels [
	| anAssertStep |
	anAssertStep := self check
		label: ('Assert tools with labels {1}' 
			format: {aCollectionOfLabels asCommaString});
		value: [ :aToolElement | aToolElement tabs size ]
			equals: aCollectionOfLabels size;
		value: [ :aToolElement | aToolElement tabs size ]
			equals: aCollectionOfLabels size;
		referenceSender;
		onParentStepTarget: self.

	^ anAssertStep
]
