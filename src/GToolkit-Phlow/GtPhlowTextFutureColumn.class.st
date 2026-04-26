Class {
	#name : #GtPhlowTextFutureColumn,
	#superclass : #GtPhlowTypedColumn,
	#instVars : [
		'futureComputation',
		'pendingComputation',
		'successComputation'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> addException: anException inLabel: aLabel [
	anException emit.
	aLabel
		addChild: (anException asDebuggableElement
				hFitContentLimited;
				vFitContent)
]

{ #category : #'api - building' }
GtPhlowTextFutureColumn >> bindToCellElement: aCellElement cellObject: aCellObject atPosition: aRowIndex [
	| anAsyncFuture |

	anAsyncFuture := futureComputation
		ifNil: [ [ aCellObject gtDisplayText ] asAsyncFuture ]
		ifNotNil: [ :aBlock |
			aBlock
				phlowValue: aCellObject
				withEnoughArguments: { aRowIndex . index. aCellElement theme } ].

	aCellElement asyncFuture future: anAsyncFuture asAsyncFuture
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> computePendingLabelTextFor: aLabel [
	| aText |
	aText := pendingComputation
			ifNil: [ '' ]
			ifNotNil: [ :aBlock | 
				[ (aBlock phlowValue: aLabel theme withEnoughArguments: {}) gtDisplayText ]
					onErrorDo: [ :anException | 
						self addException: anException inLabel: aLabel.
						anException return: '' ] ].

	aLabel text: aText
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> computeSuccessLabelTextFor: aLabel value: aValue [
	| aText |
	aText := successComputation
			ifNil: [ aValue gtDisplayText ]
			ifNotNil: [ :aBlock | 
				[ (aBlock phlowValue: aValue withEnoughArguments: {aLabel theme}) gtDisplayText ]
					onErrorDo: [ :anException | 
						self addException: anException inLabel: aLabel.
						anException return: '' ] ].

	aLabel text: aText
]

{ #category : #'api - building' }
GtPhlowTextFutureColumn >> createCellElement [
	^ BrLabel new
		aptitude: BrGlamorousListLabelAptitude;
		alignCenterLeft;
		hMatchParent;
		vFitContent;
		text: '';
		withAsyncFutureDo: [ :anElementFuture | 
			anElementFuture
				executionConfiguration: GtPhlowUtility defaultFutureExecutionConfigurationForViewParts;
				whenPending: [ :aLabel | self computePendingLabelTextFor: aLabel ];
				whenError: [ :aLabel :anError | 
					aLabel text: ''.
					self addException: anError inLabel: aLabel ];
				whenSuccess: [ :aLabel :aValue | self computeSuccessLabelTextFor: aLabel value: aValue ] ]
]

{ #category : #'api - configuration' }
GtPhlowTextFutureColumn >> future: aBlock [
	futureComputation := aBlock
]

{ #category : #'api - configuration' }
GtPhlowTextFutureColumn >> pending: aBlock [
	pendingComputation := aBlock
]

{ #category : #'api - configuration' }
GtPhlowTextFutureColumn >> success: aBlock [
	successComputation := aBlock
]
