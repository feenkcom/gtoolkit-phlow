"
I add scripting methods that simplify colum definitions for {{gtClass:GtPhlowColumnedListView}} and {{gtClass:GtPhlowColumnedTreeView}}.

"
Trait {
	#name : #TGtPhlowColumnScripts,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column [
	<return: #GtPhlowExplicitColumn>

	^ self explicitColumn
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString do: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aBlock value: aColumn
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString icon: aFormatBlocOrSymbol [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn icon: aFormatBlocOrSymbol.
	aColumn width: 36.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString icon: aFormatBlocOrSymbol weight: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn icon: aFormatBlocOrSymbol.
	aColumn weight: aNumber.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString icon: aFormatBlocOrSymbol width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn icon: aFormatBlocOrSymbol.
	aColumn width: aNumber.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString iconName: anIconNameComputation [
	self column: aTitleString iconNameDo: [ :aColumn |
		aColumn
			item: GtPhlowIdentityFunction uniqueInstance;
			iconName: anIconNameComputation ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString iconName: anIconNameComputation width: aNumber [
	self column: aTitleString iconNameDo: [ :aColumn |
		aColumn
			item: GtPhlowIdentityFunction uniqueInstance;
			iconName: anIconNameComputation;
			width: aNumber ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitle iconNameDo: aBlock [
	aBlock value: (self iconNameColumn title: aTitle)
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString item: anItemComputation text: aBlock [	
	self column: aTitleString textDo: [ :aColumn |
		aColumn
			item: anItemComputation;
			format: aBlock ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitle number: aBlock [
	self numberColumn
		title: aTitle;
		item: aBlock
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitle number: aBlock format: aFormatBlock [
	self numberColumn
		title: aTitle;
		item: aBlock;
		format: aFormatBlock
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitle numberDo: aBlock [
	aBlock value: (self numberColumn title: aTitle)
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString stencil: aFormatBlocOrSymbol [
	self column: aTitleString icon: aFormatBlocOrSymbol weight: 1
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString stencil: aFormatBlocOrSymbol weight: aNumber [
	self column: aTitleString icon: aFormatBlocOrSymbol weight: aNumber
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString stencil: aFormatBlocOrSymbol width: aNumber [
	self column: aTitleString icon: aFormatBlocOrSymbol width: aNumber
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString text: aBlock [	
	self column: aTitleString textDo: [ :aColumn |
		aColumn
			item: GtPhlowIdentityFunction uniqueInstance;
			format: aBlock ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString text: aBlock spawn: aSpawnBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn text: aBlock spawn: aSpawnBlock
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString text: aBlock spawn: aSpawnBlock width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn text: aBlock spawn: aSpawnBlock.
	aColumn width: aNumber.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString text: aBlock weight: aNumber [
	self column: aTitleString textDo: [ :aColumn |
		aColumn
			item: GtPhlowIdentityFunction uniqueInstance;
			format: aBlock;
			weight: aNumber ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString text: aBlock width: aNumber [
	self column: aTitleString textDo: [ :aColumn |
		aColumn
			item: GtPhlowIdentityFunction uniqueInstance;
			format: aBlock;
			width: aNumber ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString textDo: aBlock [
	aBlock value: (self textColumn title: aTitleString)
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString textFuture: aFutureBlock executionConfiguration: aConfigurationBlock pending: aPendingBlock success: aSuccessBlock [
	"aFutureBlock:
	  - is a block that computes its value in an async future,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ].
	 aConfigurationBlock:
	   - is a block that computes future execution configuration,
	   - parameters are [ :aConfiguration | ],
	   - aConfiguration is kind of `AsyncFutureExecutionConfiguration` instance which
	     can be modified or aConfigurationBlock can return another instance of that kind,
	   - the execution configuration must be computed quickly to not block the UI process.
	 aPendingBlock:
	  - is a block that computes a pending text while aFutureBlock is computed,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ],
	  - the pending text must be computed quickly to not block the UI process.
	 aSuccessBlock:
	  - is a block that computes a success text of the aFutureBlock return value that is displayed instead of the pending text,
	  - parameters are [ :aResult :aContext | ],
	  - the success text must be computed quickly to not block the UI process.
	 aContext parameter of the blocks above:
	  - is kind of `GtPhlowTextFutureColumnContext` instance that access value,
	  - it provides access to `rowItem`, `rowIndex`, `columnIndex`, `theme` (BlTheme instance)."

	self
		column: aTitleString
		textFutureDo: [ :aColumn | 
			aColumn
				item: GtPhlowIdentityFunction uniqueInstance;
				executionConfiguration: aConfigurationBlock;
				future: aFutureBlock;
				pending: aPendingBlock;
				success: aSuccessBlock ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString textFuture: aFutureBlock executionConfiguration: aConfigurationBlock pending: aPendingBlock success: aSuccessBlock weight: aNumber [
	"aFutureBlock:
	  - is a block that computes its value in an async future,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ].
	 aConfigurationBlock:
	   - is a block that computes future execution configuration,
	   - parameters are [ :aConfiguration | ],
	   - aConfiguration is kind of `AsyncFutureExecutionConfiguration` instance which
	     can be modified or aConfigurationBlock can return another instance of that kind,
	   - the execution configuration must be computed quickly to not block the UI process.
	 aPendingBlock:
	  - is a block that computes a pending text while aFutureBlock is computed,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ],
	  - the pending text must be computed quickly to not block the UI process.
	 aSuccessBlock:
	  - is a block that computes a success text of the aFutureBlock return value that is displayed instead of the pending text,
	  - parameters are [ :aResult :aContext | ],
	  - the success text must be computed quickly to not block the UI process.
	 aContext parameter of the blocks above:
	  - is kind of `GtPhlowTextFutureColumnContext` instance that access value,
	  - it provides access to `rowItem`, `rowIndex`, `columnIndex`, `theme` (BlTheme instance)."

	self
		column: aTitleString
		textFutureDo: [ :aColumn | 
			aColumn
				item: GtPhlowIdentityFunction uniqueInstance;
				executionConfiguration: aConfigurationBlock;
				future: aFutureBlock;
				pending: aPendingBlock;
				success: aSuccessBlock;
				weight: aNumber ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString textFuture: aFutureBlock executionConfiguration: aConfigurationBlock pending: aPendingBlock success: aSuccessBlock width: aNumber [
	"aFutureBlock:
	  - is a block that computes its value in an async future,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ].
	 aConfigurationBlock:
	   - is a block that computes future execution configuration,
	   - parameters are [ :aConfiguration | ],
	   - aConfiguration is kind of `AsyncFutureExecutionConfiguration` instance which
	     can be modified or aConfigurationBlock can return another instance of that kind,
	   - the execution configuration must be computed quickly to not block the UI process.
	 aPendingBlock:
	  - is a block that computes a pending text while aFutureBlock is computed,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ],
	  - the pending text must be computed quickly to not block the UI process.
	 aSuccessBlock:
	  - is a block that computes a success text of the aFutureBlock return value that is displayed instead of the pending text,
	  - parameters are [ :aResult :aContext | ],
	  - the success text must be computed quickly to not block the UI process.
	 aContext parameter of the blocks above:
	  - is kind of `GtPhlowTextFutureColumnContext` instance that access value,
	  - it provides access to `rowItem`, `rowIndex`, `columnIndex`, `theme` (BlTheme instance)."

	self
		column: aTitleString
		textFutureDo: [ :aColumn | 
			aColumn
				item: GtPhlowIdentityFunction uniqueInstance;
				executionConfiguration: aConfigurationBlock;
				future: aFutureBlock;
				pending: aPendingBlock;
				success: aSuccessBlock;
				width: aNumber ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString textFuture: aFutureBlock pending: aPendingBlock success: aSuccessBlock [
	"aFutureBlock:
	  - is a block that computes its value in an async future,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ].
	 aPendingBlock:
	  - is a block that computes a pending text while aFutureBlock is computed,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ],
	  - the pending text must be computed quickly to not block the UI process.
	 aSuccessBlock:
	  - is a block that computes a success text of the aFutureBlock return value that is displayed instead of the pending text,
	  - parameters are [ :aResult :aContext | ],
	  - the success text must be computed quickly to not block the UI process.
	 aContext parameter of the blocks above:
	  - is kind of `GtPhlowTextFutureColumnContext` instance that access value,
	  - it provides access to `rowItem`, `rowIndex`, `columnIndex`, `theme` (BlTheme instance)."

	self
		column: aTitleString
		textFutureDo: [ :aColumn | 
			aColumn
				item: GtPhlowIdentityFunction uniqueInstance;
				future: aFutureBlock;
				pending: aPendingBlock;
				success: aSuccessBlock ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString textFuture: aFutureBlock pending: aPendingBlock success: aSuccessBlock weight: aNumber [
	"aFutureBlock:
	  - is a block that computes its value in an async future,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ].
	 aPendingBlock:
	  - is a block that computes a pending text while aFutureBlock is computed,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ],
	  - the pending text must be computed quickly to not block the UI process.
	 aSuccessBlock:
	  - is a block that computes a success text of the aFutureBlock return value that is displayed instead of the pending text,
	  - parameters are [ :aResult :aContext | ],
	  - the success text must be computed quickly to not block the UI process.
	 aContext parameter of the blocks above:
	  - is kind of `GtPhlowTextFutureColumnContext` instance that access value,
	  - it provides access to `rowItem`, `rowIndex`, `columnIndex`, `theme` (BlTheme instance)."

	self
		column: aTitleString
		textFutureDo: [ :aColumn | 
			aColumn
				item: GtPhlowIdentityFunction uniqueInstance;
				future: aFutureBlock;
				pending: aPendingBlock;
				success: aSuccessBlock;
				weight: aNumber ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString textFuture: aFutureBlock pending: aPendingBlock success: aSuccessBlock width: aNumber [
	"aFutureBlock:
	  - is a block that computes its value in an async future,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ].
	 aPendingBlock:
	  - is a block that computes a pending text while aFutureBlock is computed,
	  - parameters are [ :aRowItem :aRowIndex :aContext | ],
	  - the pending text must be computed quickly to not block the UI process.
	 aSuccessBlock:
	  - is a block that computes a success text of the aFutureBlock return value that is displayed instead of the pending text,
	  - parameters are [ :aResult :aContext | ],
	  - the success text must be computed quickly to not block the UI process.
	 aContext parameter of the blocks above:
	  - is kind of `GtPhlowTextFutureColumnContext` instance that access value,
	  - it provides access to `rowItem`, `rowIndex`, `columnIndex`, `theme` (BlTheme instance)."

	self
		column: aTitleString
		textFutureDo: [ :aColumn | 
			aColumn
				item: GtPhlowIdentityFunction uniqueInstance;
				future: aFutureBlock;
				pending: aPendingBlock;
				success: aSuccessBlock;
				width: aNumber ]
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString textFutureDo: aBlock [
	aBlock value: (self textFutureColumn title: aTitleString)
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> columnOfType: aColumnClass [
	^ self explicitRequirement
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> explicitColumn [
	<return: #GtPhlowExplicitColumn>

	^ self columnOfType: GtPhlowExplicitColumn
]

{ #category : #'as yet unclassified' }
TGtPhlowColumnScripts >> fallbackColumnWhenEmpty [
	"There must be always at least one column, even if users didn't specify any. In that case we create this column"

	^ (GtPhlowTextColumn new
		index: 1;
		title: 'Items')
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> iconNameColumn [
	<return: #GtPhlowThemeIconNameColumn>

	^ self columnOfType: GtPhlowThemeIconNameColumn
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> numberColumn [
	<return: #GtPhlowNumberColumn>

	^ self columnOfType: GtPhlowNumberColumn
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> textColumn [
	<return: #GtPhlowTextColumn>

	^ self columnOfType: GtPhlowTextColumn
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> textFutureColumn [
	<return: #GtPhlowTextFutureColumn>

	^ self columnOfType: GtPhlowTextFutureColumn
]
