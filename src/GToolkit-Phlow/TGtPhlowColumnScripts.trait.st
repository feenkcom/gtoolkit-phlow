"
I add scripting methods that simplify colum definitions for ${class:GtPhlowColumnedListView}$ and ${class:GtPhlowColumnedTreeView}$.
"
Trait {
	#name : #TGtPhlowColumnScripts,
	#category : 'GToolkit-Phlow-Support'
}

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column [
	<return: #GtPhlowColumn>
	^ self explicitRequirement
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString do: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aBlock value: aColumn
]

{ #category : #'scripting - deprecated' }
TGtPhlowColumnScripts >> column: aTitleString evaluated: aBlock [
	self 
		deprecated: 'Please use #column:item: instead.'
		transformWith: '`@receiver column: `@one evaluated: `@two' -> '`@receiver column: `@one item: `@two'.
	^ self column: aTitleString item: aBlock
]

{ #category : #'scripting - deprecated' }
TGtPhlowColumnScripts >> column: aTitleString format: aBlock [
	self 
		deprecated: 'Please use #column:text: instead.'
		transformWith: '`@receiver column: `@one format: `@two' -> '`@receiver column: `@one text: `@two'.
	self column: aTitleString text: aBlock
]

{ #category : #'scripting - deprecated' }
TGtPhlowColumnScripts >> column: aTitleString format: aBlock width: aNumber [
	self 
		deprecated: 'Please use #column:text:width: instead.'
		transformWith: '`@receiver column: `@one format: `@two width: `@three' 
			-> '`@receiver column: `@one text: `@two width: `@three'.
	self column: aTitleString text: aBlock width: aNumber
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
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn iconName: anIconNameComputation.
	aColumn width: 36.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString iconName: anIconNameComputation width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn iconName: anIconNameComputation.
	aColumn width: aNumber.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString item: aBlock [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: aBlock
]

{ #category : #'scripting - deprecated' }
TGtPhlowColumnScripts >> column: aTitleString item: anItemComputation format: aFormatBlocOrSymbol [
	self 
		deprecated: 'Please use #column:item:text: instead.'
		transformWith: '`@receiver column: `@one item: `@two format: `@three' -> '`@receiver column: `@one item: `@two text: `@three'.
	self column: aTitleString item: anItemComputation text: aFormatBlocOrSymbol
]

{ #category : #'scripting - deprecated' }
TGtPhlowColumnScripts >> column: aTitleString item: anItemComputation format: aFormatBlocOrSymbol width: aNumber [
	self 
		deprecated: 'Please use #column:item:text:width. instead.'
		transformWith: '`@receiver column: `@one item: `@two format: `@three width: `@four'
			-> '`@receiver column: `@one item: `@two text: `@three width: `@four'.
	self column: aTitleString item: anItemComputation text: aFormatBlocOrSymbol width: aNumber
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString item: anItemComputation icon: aFormatBlocOrSymbol width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn icon: aFormatBlocOrSymbol.
	aColumn width: aNumber.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString item: anItemComputation text: aFormatBlocOrSymbol [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn text: aFormatBlocOrSymbol
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString item: anItemComputation text: aFormatBlocOrSymbol weight: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn text: aFormatBlocOrSymbol.
	aColumn weight: aNumber.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString item: anItemComputation text: aFormatBlocOrSymbol width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: anItemComputation.
	aColumn text: aFormatBlocOrSymbol.
	aColumn width: aNumber.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString item: aBlock weight: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: aBlock.
	aColumn weight: aNumber.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString item: aBlock width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn item: aBlock.
	aColumn width: aNumber.
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
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn text: aBlock
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString text: aBlock weight: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn text: aBlock.
	aColumn weight: aNumber.
]

{ #category : #'api - scripting column' }
TGtPhlowColumnScripts >> column: aTitleString text: aBlock width: aNumber [
	| aColumn |
	aColumn := self column.
	aColumn title: aTitleString.
	aColumn text: aBlock.
	aColumn width: aNumber.
]
