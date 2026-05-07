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
	| aCacheKey aCacheValue anAsyncFuture aContext |
	aCacheKey := self createCacheKeyRowItem: aCellObject rowIndex: aRowIndex.
	aCacheValue := resultCache
			at: aCacheKey
			ifPresent: [ :theCacheValue | 
				theCacheValue successResultHolder
					ifDefined: [ :theContext | 
						self bindToCellElement: aCellElement setUserDataContext: theContext.
						self updateCellElement: aCellElement exceptionsFromContext: theContext.
						aCellElement text: theContext successText.
						^ self ]
					ifNone: [  ].
				theCacheValue exceptionResultHolder
					ifDefined: [ :theContext | 
						self bindToCellElement: aCellElement setUserDataContext: theContext.
						self updateCellElement: aCellElement exceptionsFromContext: theContext.
						aCellElement text: theContext exceptionText.
						^ self ]
					ifNone: [  ].
				theCacheValue futureResultHolder
					ifDefined: [ :theContext | 
						self bindToCellElement: aCellElement setUserDataContext: theContext.
						self updateCellElement: aCellElement exceptionsFromContext: theContext.
						aCellElement asyncFuture future: theContext asAsyncFuture.
						^ self ]
					ifNone: [  ] ]
			ifAbsentPut: [ GtPhlowColumnCacheValue new ].

	aContext := self
			createContextCellElement: aCellElement
			rowItem: aCellObject
			rowIndex: aRowIndex.

	anAsyncFuture := [ | aResult |
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
GtPhlowTextFutureColumn >> bindToCellElement: aCellElement setUserDataContext: theContext [
	aCellElement userData at: self class name put: theContext
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> computeErrorLabelTextFor: aLabel exception: anError [
	| aContext aText aCacheKey aCacheValue |
	aContext := self retrieveContextFromLabelElement: aLabel.
	aContext futureException: (GtSystemUtility freeze: anError).

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
		as: #futureException
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> computePendingLabelTextFor: aLabel [
	| aContext aText |
	aLabel userData
		at: self class name
		ifAbsent: [ GtJustContextStackSignal emit ].
	aContext := self retrieveContextFromLabelElement: aLabel.

	aText := pendingComputation
			ifNil: [ '' ]
			ifNotNil: [ :aBlock | 
				[ | aResult |
				aResult := aBlock
						phlowValue: aContext rowItem
						withEnoughArguments: {aContext rowIndex.
								aContext}.
				aResult gtDisplayText ]
					onErrorDo: [ :anException | 
						| aCacheKey aCacheValue |
						aCacheKey := self
								createCacheKeyRowItem: aContext rowItem
								rowIndex: aContext rowIndex.
						aCacheValue := resultCache
								at: aCacheKey
								ifPresent: [ :theCacheValue | theCacheValue ]
								ifAbsentPut: [ GtPhlowColumnCacheValue new ].

						aContext pendingException: (GtSystemUtility freeze: anException).
						aCacheValue exceptionResult: aContext.
						self
							addException: anException
							inLabel: aLabel
							as: #futurePendingException.
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
						aTextFutureContext successException: (GtSystemUtility freeze: anException).
						self
							addException: anException
							inLabel: aLabel
							as: #futureSuccessException.
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
	self bindToCellElement: aCellElement setUserDataContext: aContext.
	^ aContext
]

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> ensureRemove: aLabel childWithId: anElementId [
	aLabel
		directChildNamed: anElementId asSymbol
		ifFound: [ :aCurrentElement | aCurrentElement removeFromParent ]
		ifNone: [  ]
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

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> retrieveContextFromLabelElement: aLabel [
	^ aLabel userData
		at: self class name
		ifAbsent: [ GtPhlowTextFutureColumnContext new
				columnIndex: index;
				theme: aLabel theme ]
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

{ #category : #'private - building' }
GtPhlowTextFutureColumn >> updateCellElement: aCellElement exceptionsFromContext: aTextFutureContext [
	aTextFutureContext futureException
		ifNil: [ self ensureRemove: aCellElement childWithId: #futureException ]
		ifNotNil: [ :anEception | 
			self
				addException: anEception
				inLabel: aCellElement
				as: #futureException ].

	aTextFutureContext pendingException
		ifNil: [ self ensureRemove: aCellElement childWithId: #futurePendingException ]
		ifNotNil: [ :anEception | 
			self
				addException: anEception
				inLabel: aCellElement
				as: #futurePendingException ].

	aTextFutureContext successException
		ifNil: [ self ensureRemove: aCellElement childWithId: #futureSuccessException ]
		ifNotNil: [ :anEception | 
			self
				addException: anEception
				inLabel: aCellElement
				as: #futureSuccessException ]
]
