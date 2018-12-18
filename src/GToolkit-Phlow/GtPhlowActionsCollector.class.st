Class {
	#name : #GtPhlowActionsCollector,
	#superclass : #GtPhlowCollector,
	#instVars : [
		'sortedUsing',
		'selectUsing'
	],
	#category : #'GToolkit-Phlow-Builders'
}

{ #category : #'api - actions' }
GtPhlowActionsCollector >> collect [
	<return: #Array of: #GtPhlowAction>
	<gtCollector>
	| anActions |
	anActions := self sortedPragmas 
		collect: [ :eachPragma | 
			| anAction |
			anAction := GtPhlowAction noAction.
			[ thisContext
						object: self object
						perform: eachPragma methodSelector
						withArguments: {anAction}
						inClass: self object class ]
				on: Error
				do: [ :error |
					error freeze.
					GtPhlowActionWithError new 
						definingMethod: eachPragma method asRingDefinition;
						error: error ] ]
		thenSelect: self selectUsing.
	anActions sort: [ :a :b | 
		[ a priority < b priority ]
			on: Error
			do: [ :error | true ] ].
	^ anActions
]

{ #category : #initialization }
GtPhlowActionsCollector >> initialize [
	super initialize.
	sortedUsing := [ :aPragma :bPragma | aPragma keyword < bPragma keyword ].
	selectUsing := [ :anAction | true ].

]

{ #category : #initialization }
GtPhlowActionsCollector >> initializePragmaNames [
	"Subclasses may define their own default pragma names"
	pragmaNames := #( #gtAction ).
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
