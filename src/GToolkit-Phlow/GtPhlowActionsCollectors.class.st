Class {
	#name : #GtPhlowActionsCollectors,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'from',
		'to',
		'sortedUsing',
		'pragmaNames',
		'object',
		'selectUsing'
	],
	#category : #'GToolkit-Phlow-Builders'
}

{ #category : #'api - actions' }
GtPhlowActionsCollectors >> collect [
	<return: #Array of: #GtPhlowAction>
	^ self sortedPragmas 
		collect: [ :eachPragma | 
			| anAction |
			anAction := GtPhlowNoAction new.
			 [thisContext
						object: self object
						perform: eachPragma methodSelector
						withArguments: {anAction}
						inClass: self from ]
				on: Error
				do: [ :error |
					error freeze.
					GtPhlowActionWithError new 
						error: error ] ]
		thenSelect: self selectUsing
]

{ #category : #private }
GtPhlowActionsCollectors >> collectPragmas [
	<return: #Collection of: #Pragma>
	^ self pragmaNames 
		flatCollect: [ :eachPragmaName |
			Pragma
				allNamed: eachPragmaName
				from: self from
				to: self to ] 
		as: OrderedCollection.
]

{ #category : #accessing }
GtPhlowActionsCollectors >> from [
	<return: #Class>
	^ from
]

{ #category : #accessing }
GtPhlowActionsCollectors >> from: aClass [
	self 
		assert: [ aClass notNil ]
		description: [ 'From-Class must be non-nil' ].
	from := aClass
]

{ #category : #'api - accessing' }
GtPhlowActionsCollectors >> fromObject: anObject [
	self object: anObject.
	self from: anObject class.
	self to: ProtoObject
]

{ #category : #initialization }
GtPhlowActionsCollectors >> initialize [
	super initialize.
	pragmaNames := #( #gtAction ).
	object := nil.
	from := UndefinedObject.
	to := ProtoObject.
	sortedUsing := [ :aPragma :bPragma | aPragma keyword < bPragma keyword ].
	selectUsing := [ :anAction | true ].

]

{ #category : #accessing }
GtPhlowActionsCollectors >> object [
	<return: #Object>
	^ object
]

{ #category : #accessing }
GtPhlowActionsCollectors >> object: anObject [
	object := anObject.
]

{ #category : #'api - accessing' }
GtPhlowActionsCollectors >> pragmaName: aSymbol [
	self 
		assert: [ aSymbol notNil ]
		description: [ 'Pragma name must be non-nil' ].
	self pragmaNames: (Array with: aSymbol)
]

{ #category : #accessing }
GtPhlowActionsCollectors >> pragmaNames [
	<return: #Collection of: #Symbol>
	^ pragmaNames
]

{ #category : #accessing }
GtPhlowActionsCollectors >> pragmaNames: aCollectionOfSymbols [
	self 
		assert: [ aCollectionOfSymbols notNil ]
		description: [ 'Collection of pragma names must be non-nil' ].
	pragmaNames := aCollectionOfSymbols
]

{ #category : #accessing }
GtPhlowActionsCollectors >> selectUsing [
	<return: #BlockClosure>
	^ selectUsing
]

{ #category : #accessing }
GtPhlowActionsCollectors >> selectUsing: anOneArgBlock [
	self 
		assert: [ anOneArgBlock notNil ]
		description: [ 'Select block must be non-nil' ].
	self 
		assert: [ anOneArgBlock numArgs = 1 ]
		description: [ 'Select block must receive one argument' ].
	selectUsing := anOneArgBlock
]

{ #category : #private }
GtPhlowActionsCollectors >> sortedPragmas [
	<return: #Collection of: #Pragma>
	^ self collectPragmas sort: self sortedUsing
]

{ #category : #accessing }
GtPhlowActionsCollectors >> sortedUsing [
	<return: #BlockClosure>
	^ sortedUsing
]

{ #category : #accessing }
GtPhlowActionsCollectors >> sortedUsing: aTwoArgBlock [
	self 
		assert: [ aTwoArgBlock notNil ]
		description: [ 'Sorting block must be non-nil' ].
	self 
		assert: [ aTwoArgBlock numArgs = 2 ]
		description: [ 'Sorting block must receive two arguments' ].
	sortedUsing := aTwoArgBlock
]

{ #category : #accessing }
GtPhlowActionsCollectors >> to [
	<return: #Class>
	^ to
]

{ #category : #accessing }
GtPhlowActionsCollectors >> to: aClass [
	self 
		assert: [ aClass notNil ]
		description: [ 'To-Class must be non-nil' ].
	to := aClass
]
