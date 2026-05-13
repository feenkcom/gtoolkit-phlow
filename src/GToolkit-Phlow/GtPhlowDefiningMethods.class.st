Class {
	#name : #GtPhlowDefiningMethods,
	#superclass : #Object,
	#instVars : [
		'methods'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #accessing }
GtPhlowDefiningMethods >> compiledMethod [
	<return: #CompiledMethod>
	^ self methods first compiledMethod
]

{ #category : #accessing }
GtPhlowDefiningMethods >> fullName [
	"Return Class>>#selector name"
	<return: #Symbol>
	^ self methods first fullName
]

{ #category : #printing }
GtPhlowDefiningMethods >> gtDisplayOn: aStream [
	| aCount |
	self methods ifEmpty: [ ^ super gtDisplayOn: aStream ].
	aStream nextPutAll: self fullName.

	self methods size > 1 ifFalse: [ ^ self ].
	aCount := self methods size - 1.
	aStream
		nextPutAll: ' [+';
		print: aCount;
		nextPutAll: (' more method' asPluralBasedOn: aCount);
		nextPut: $]
]

{ #category : #stream }
GtPhlowDefiningMethods >> gtOriginMethodsInto: aWriteStream [ 
	aWriteStream nextPutAll: self methods
]

{ #category : #accessing }
GtPhlowDefiningMethods >> gtPhlowIncludesCompiledMethod: aCompiledMethod [
	^ self methods anySatisfy: [ :eachMethod | 
		eachMethod gtPhlowIncludesCompiledMethod: aCompiledMethod ]
]

{ #category : #accessing }
GtPhlowDefiningMethods >> methodClass [
	<return: #Class>
	^ self methods first methodClass
]

{ #category : #accessing }
GtPhlowDefiningMethods >> methods [
	^ methods
]

{ #category : #accessing }
GtPhlowDefiningMethods >> methods: anObject [
	methods := anObject
]

{ #category : #accessing }
GtPhlowDefiningMethods >> selector [
	<return: #Symbol>
	^ self methods first selector
]
