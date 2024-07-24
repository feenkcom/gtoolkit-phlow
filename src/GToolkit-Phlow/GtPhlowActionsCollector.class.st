Class {
	#name : #GtPhlowActionsCollector,
	#superclass : #GtPhlowCollector,
	#traits : 'TGtPhlowContextAccessor',
	#classTraits : 'TGtPhlowContextAccessor classTrait',
	#instVars : [
		'sortedUsing',
		'selectUsing'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #'api - actions' }
GtPhlowActionsCollector >> collect [
	<return: #Array of: #GtPhlowAction>
	<gtCollector>
	| anActions |
	
	anActions := self sortedPragmas 
		collect: [ :eachPragma | 
			GtPhlowAction noAction  
				on: self object 
				perform: eachPragma methodSelector
				withContext: self context  ]
		thenSelect: self selectUsing.
	self sortByPriority: anActions.
	
	^ anActions
]

{ #category : #initialization }
GtPhlowActionsCollector >> defaultPragmaNames [
	^ #( #gtAction )
]

{ #category : #initialization }
GtPhlowActionsCollector >> initialize [
	super initialize.
	
	self initializePhlowContext.
	
	sortedUsing := [ :aPragma :bPragma | aPragma selector < bPragma selector ].
	selectUsing := [ :anAction | true ]
]

{ #category : #accessing }
GtPhlowActionsCollector >> selectUsing [
	<return: #BlockClosure>
	^ selectUsing
]

{ #category : #accessing }
GtPhlowActionsCollector >> selectUsing: anOneArgBlock [
	self 
		assert: [ anOneArgBlock notNil ]
		description: [ 'Select block must be non-nil' ].
	self 
		assert: [ anOneArgBlock numArgs = 1 ]
		description: [ 'Select block must receive one argument' ].
	selectUsing := anOneArgBlock
]

{ #category : #private }
GtPhlowActionsCollector >> sortedPragmas [
	<return: #Collection of: #Pragma>
	^ self collectPragmas sort: self sortedUsing
]

{ #category : #accessing }
GtPhlowActionsCollector >> sortedUsing [
	<return: #BlockClosure>
	^ sortedUsing
]

{ #category : #accessing }
GtPhlowActionsCollector >> sortedUsing: aTwoArgBlock [
	self 
		assert: [ aTwoArgBlock notNil ]
		description: [ 'Sorting block must be non-nil' ].
	self 
		assert: [ aTwoArgBlock numArgs = 2 ]
		description: [ 'Sorting block must receive two arguments' ].
	sortedUsing := aTwoArgBlock
]
