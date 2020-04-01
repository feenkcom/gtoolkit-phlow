Class {
	#name : #GtPhlowCollector,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'to',
		'from',
		'object',
		'pragmaNames'
	],
	#category : #'GToolkit-Phlow-Builders'
}

{ #category : #sorting }
GtPhlowCollector class >> sortByPriority: aCollection [
	aCollection sort: [ :a :b | 
		[ a priority < b priority]
			on: Error
			do: [ :error | true ] ].
]

{ #category : #actions }
GtPhlowCollector >> collect [
	"Collect objects according to given configuration"
	<return: #Array>
	^ self subclassResponsibility
]

{ #category : #private }
GtPhlowCollector >> collectPragmas [
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
GtPhlowCollector >> from [
	<return: #Class>
	^ from
]

{ #category : #accessing }
GtPhlowCollector >> from: aClass [
	self 
		assert: [ aClass notNil ]
		description: [ 'From-Class must be non-nil' ].
	from := aClass
]

{ #category : #'api - accessing' }
GtPhlowCollector >> fromObject: anObject [
	self object: anObject.
	self from: anObject class.
	self to: ProtoObject
]

{ #category : #initialization }
GtPhlowCollector >> initialize [
	super initialize.
	self initializePragmaNames.
]

{ #category : #initialization }
GtPhlowCollector >> initializePragmaNames [
	"Subclasses may define their own default pragma names"
	pragmaNames := #()
]

{ #category : #initialization }
GtPhlowCollector >> initializeSearchRange [
	"Define which object and what classes in an hierarchy to consider while searching pragmas"
	object := nil.
	from := UndefinedObject.
	to := ProtoObject
]

{ #category : #accessing }
GtPhlowCollector >> object [
	<return: #Object>
	^ object
]

{ #category : #accessing }
GtPhlowCollector >> object: anObject [
	object := anObject.
]

{ #category : #'api - accessing' }
GtPhlowCollector >> pragmaName: aSymbol [
	self 
		assert: [ aSymbol notNil ]
		description: [ 'Pragma name must be non-nil' ].
	self pragmaNames: (Array with: aSymbol)
]

{ #category : #accessing }
GtPhlowCollector >> pragmaNames [
	<return: #Collection of: #Symbol>
	^ pragmaNames
]

{ #category : #accessing }
GtPhlowCollector >> pragmaNames: aCollectionOfSymbols [
	self 
		assert: [ aCollectionOfSymbols notNil ]
		description: [ 'Collection of pragma names must be non-nil' ].
	pragmaNames := aCollectionOfSymbols
]

{ #category : #sorting }
GtPhlowCollector >> sortByPriority: aCollection [
	self class sortByPriority: aCollection
]

{ #category : #accessing }
GtPhlowCollector >> to [
	<return: #Class>
	^ to
]

{ #category : #accessing }
GtPhlowCollector >> to: aClass [
	self 
		assert: [ aClass notNil ]
		description: [ 'To-Class must be non-nil' ].
	to := aClass
]
