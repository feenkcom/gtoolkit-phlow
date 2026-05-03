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
GtPhlowTextFutureColumn >> addException: anException inLabel: aLabel as: anElementIdOrNil [
	| anElementId aNewElement |
	anException emit.
	anElementId := anElementIdOrNil ifNil: [ #futureException ].
	aNewElement := anException asDebuggableElement
			hFitContentLimited;
			vFitContent;
			id: anElementId.

	aLabel
		directChildNamed: anElementId asSymbol
		ifFound: [ :aCurrentElement | 
			aLabel
				replaceChild: aCurrentElement
				with: aNewElement
				as: anElementId ]
		ifNone: [ aLabel addChild: aNewElement ]
]

{ #category : #'api - building' }
GtPhlowTextFutureColumn >> bindToCellElement: aCellElement cellObject: aCellObject atPosition: aRowIndex [
	| anAsyncFuture |
	anAsyncFuture := futureComputation
			ifNil: [ [ aCellObject gtDisplayText ] asAsyncFuture ]
			ifNotNil: [ :aBlock | 
				[ | aContext aResult |
				aContext := GtPhlowTextFutureColumnContext new
						rowItem: aCellObject;
						rowIndex: aRowIndex;
						columnIndex: index;
						theme: aCellElement theme.
				aResult := aBlock
						phlowValue: aCellObject
						withEnoughArguments: {aRowIndex.
								aCellElement theme}.
				aCellElement userData at: self class put: aContext.
				aContext result: aResult ] asAsyncFuture ].

	aCellElement asyncFuture future: anAsyncFuture asAsyncFuture
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> computePendingLabelTextFor: aLabel [
	| aText |
	aText := pendingComputation
			ifNil: [ '' ]
			ifNotNil: [ :aBlock | 
				[ | aContext aResult |
				aContext := aLabel userData
						at: self class
						ifAbsent: [ GtPhlowTextFutureColumnContext new
								columnIndex: index;
								theme: aLabel theme ].
				aResult := aBlock
						phlowValue: aContext rowItem
						withEnoughArguments: {aContext rowIndex.
								aContext}.
				aResult gtDisplayText ]
					onErrorDo: [ :anException | 
						self
							addException: anException
							inLabel: aLabel
							as: #columnCellFuturePendingException.
						anException return: '' ] ].

	aLabel text: aText
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> computeSuccessLabelTextFor: aLabel value: aTextFutureContext [
	| aText |
	aText := successComputation
			ifNil: [ aTextFutureContext result gtDisplayText ]
			ifNotNil: [ :aBlock | 
				[ (aBlock
					phlowValue: aTextFutureContext result
					withEnoughArguments: {aTextFutureContext}) gtDisplayText ]
					onErrorDo: [ :anException | 
						self
							addException: anException
							inLabel: aLabel
							as: #columnCellFutureSuccessException.
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
					self
						addException: anError
						inLabel: aLabel
						as: #columnCellFutureEvaluationException ];
				whenSuccess: [ :aLabel :aTextFutureContext | self computeSuccessLabelTextFor: aLabel value: aTextFutureContext ] ]
]

{ #category : #'api - configuration' }
GtPhlowTextFutureColumn >> future: aBlock [
	"Set a block that computes its value in an async future.
	Block has following parameters: [ :aRowItem :aRowIndex :aContext | ].
	aContext is kind of `GtPhlowTextFutureColumnContext` instance."

	futureComputation := aBlock
]

{ #category : #'private - accessing' }
GtPhlowTextFutureColumn >> futureComputation [
	"I am used to compute displayed value of a remote view.
	See `GtPhlowTextFutureColumn>>#updateValue:forComputedItem:rowIndex:columnIndex:`."

	^ futureComputation
]

{ #category : #'api - configuration' }
GtPhlowTextFutureColumn >> pending: aBlock [
	"Set a block that computes a pending text during the computation.
	Note that the value must be computed fast to not block the UI process.
	Block has following parameters: [ :aRowItem :aRowIndex :aContext | ].
	aContext is kind of `GtPhlowTextFutureColumnContext` instance."

	pendingComputation := aBlock
]

{ #category : #'api - configuration' }
GtPhlowTextFutureColumn >> success: aBlock [
	"Set a block that computes a success text during the computation.
	Note that the value must be computed fast to not block the UI process.
	aBlock has following parameters: [ :aResult :aContext | ].
	aBlock returns a string or text.
	aContext is kind of `GtPhlowTextFutureColumnContext` instance."

	successComputation := aBlock
]

{ #category : #'private - accessing' }
GtPhlowTextFutureColumn >> successComputation [
	"I am used to compute displayed value of a remote view.
	See `GtPhlowTextFutureColumn>>#updateValue:forComputedItem:rowIndex:columnIndex:`."

	^ successComputation
]
