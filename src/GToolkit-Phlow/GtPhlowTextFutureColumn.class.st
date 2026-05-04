Class {
	#name : #GtPhlowTextFutureColumn,
	#superclass : #GtPhlowTypedColumn,
	#instVars : [
		'futureComputation',
		'pendingComputation',
		'successComputation',
		'resultCache'
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
	| aCacheKey aCacheValue anAsyncFuture |
	aCacheKey := self createCacheKeyRowItem: aCellObject rowIndex: aRowIndex.
	aCacheValue := resultCache
			at: aCacheKey
			ifPresent: [ :theCacheValue | 
				theCacheValue successResultHolder
					ifDefined: [ :theContext | 
						aCellElement text: theContext successText.
						^ self ]
					ifNone: [  ].
				theCacheValue exceptionResultHolder
					ifDefined: [ :theContext | 
						aCellElement asyncFuture future: theContext asAsyncFuture.
						^ self ]
					ifNone: [  ].
				theCacheValue futureResultHolder
					ifDefined: [ :theContext | 
						aCellElement text: theContext exceptionText.
						^ self ]
					ifNone: [  ] ]
			ifAbsentPut: [ GtPhlowColumnCacheValue new ].

	anAsyncFuture := [ | aContext aResult |
		aContext := self
				createContextCellElement: aCellElement
				rowItem: aCellObject
				rowIndex: aRowIndex.
		aResult := futureComputation
				ifNil: [ aCellObject gtDisplayText ]
				ifNotNil: [ :aBlock | 
					aBlock
						phlowValue: aCellObject
						withEnoughArguments: {aRowIndex.
								aContext} ].
		aContext result: aResult.
		aCacheValue futureResult: aContext.
		aContext ] asAsyncFuture.

	aCellElement asyncFuture future: anAsyncFuture asAsyncFuture
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> computeErrorLabelTextFor: aLabel exception: anError [
	| aContext aText aCacheKey aCacheValue |
	aContext := aLabel userData
			at: self class name
			ifAbsent: [ GtPhlowTextFutureColumnContext new
					columnIndex: index;
					theme: aLabel theme ].
	aCacheKey := self
			createCacheKeyRowItem: aContext rowItem
			rowIndex: aContext rowIndex.

	aCacheValue := resultCache
			at: aCacheKey
			ifPresent: [ :theCacheValue | 
				theCacheValue exceptionResultHolder
					ifDefined: [ :theContext | 
						aLabel text: theContext exceptionText.
						^ self ]
					ifNone: [  ].
				theCacheValue ]
			ifAbsentPut: [ GtPhlowColumnCacheValue new ].

	aText := '' asRopedText.
	aLabel text: aText.
	aContext exceptionText: aText.
	aCacheValue exceptionResult: aContext.

	self
		addException: anError
		inLabel: aLabel
		as: #columnCellFutureEvaluationException
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
	| aCacheKey aCacheValue aText |
	aCacheKey := self
			createCacheKeyRowItem: aTextFutureContext rowItem
			rowIndex: aTextFutureContext rowIndex.
	aCacheValue := resultCache
			at: aCacheKey
			ifPresent: [ :theCacheValue | 
				theCacheValue successResultHolder
					ifDefined: [ :theContext | 
						aLabel text: theContext successText.
						^ self ]
					ifNone: [  ].
				theCacheValue ]
			ifAbsentPut: [ GtPhlowColumnCacheValue new ].

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

	aTextFutureContext successText: aText.
	aCacheValue successResult: aTextFutureContext.

	aLabel text: aText
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> createCacheKeyRowItem: aCellObject rowIndex: aRowIndex [
	^ GtPhlowColumnCacheKey new
		rowItem: aCellObject;
		rowIndex: aRowIndex
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
				whenError: [ :aLabel :anError | self computeErrorLabelTextFor: aLabel exception: anError ];
				whenSuccess: [ :aLabel :aTextFutureContext | self computeSuccessLabelTextFor: aLabel value: aTextFutureContext ] ]
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> createContextCellElement: aCellElement rowItem: aCellObject rowIndex: aRowIndex [
	| aContext |
	aContext := GtPhlowTextFutureColumnContext new
			rowItem: aCellObject;
			rowIndex: aRowIndex;
			columnIndex: index;
			theme: aCellElement theme.
	aCellElement userData at: self class name put: aContext.
	^ aContext
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

{ #category : #initialization }
GtPhlowTextFutureColumn >> initialize [
	super initialize.
	self initializeResultCache
]

{ #category : #initialization }
GtPhlowTextFutureColumn >> initializeResultCache [
	"The cache is accessed only in the UI process, therefore it can be a regular dictionary."

	resultCache := Dictionary new
]

{ #category : #'api - configuration' }
GtPhlowTextFutureColumn >> pending: aBlock [
	"Set a block that computes a pending text during the computation.
	Note that the value must be computed fast to not block the UI process.
	Block has following parameters: [ :aRowItem :aRowIndex :aContext | ].
	aContext is kind of `GtPhlowTextFutureColumnContext` instance."

	pendingComputation := aBlock
]

{ #category : #'api - building' }
GtPhlowTextFutureColumn >> prepareForUpdateContent [
	"Items are going to be updated. Columns can clear caches, etc.
	It is called only from the UI process."

	super prepareForUpdateContent.

	self initializeResultCache
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
