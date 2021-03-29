Class {
	#name : #GtPhlowDemoDefinitionsExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'method - baz' }
GtPhlowDemoDefinitionsExamples >> bazMethodDefinition [
	<gtExample>
	| aRing |
	(self demoClass canUnderstand: self bazMethodName) 
		ifFalse: [ self compileBazMethod ].
	aRing := (self demoClass >> self bazMethodName) asRingDefinition.
	self assert: aRing isDefined.
	^ aRing
]

{ #category : #'method - baz' }
GtPhlowDemoDefinitionsExamples >> bazMethodName [
	<gtExample>
	^ #bazFor:
]

{ #category : #methods }
GtPhlowDemoDefinitionsExamples >> collectionOfDefiningMethods [
	<gtExample>
	^ Array 
		with: self fooMethodDefinition
		with: self bazMethodDefinition
]

{ #category : #'method - baz' }
GtPhlowDemoDefinitionsExamples >> compileBazMethod [
	<gtExample>
	| aSymbol |
		
	aSymbol := GtPharoCodeModifier
		compileMethodSource: self bazMethodName asString, ' aView
	<gtView>
	^ aView explicit 
		title: ''Baz'';
		priority: 2;
		stencil: [ BlElement new
			background: Color random;
			size: 150@300 ]'
		in: self demoClass
		protocol: 'gt-extension'.
	
	self assert: aSymbol equals: self bazMethodName.
	^ aSymbol
]

{ #category : #'method - empty view' }
GtPhlowDemoDefinitionsExamples >> compileEmptyViewMethod [
	<gtExample>
	| aSymbol |
	
	aSymbol := GtPharoCodeModifier
		compileMethodSource: self emptyViewMethodName asString, ' aView
	<gtView>
	^ aView empty 
		priority: -100; 
		title: ''Empty'''
		in: self demoClass
		protocol: 'gt-extension'.
		
	self assert: aSymbol equals: self emptyViewMethodName.
	^ aSymbol
]

{ #category : #'method - foo' }
GtPhlowDemoDefinitionsExamples >> compileFooMethod [
	<gtExample>
	| aSymbol |
	
	aSymbol := GtPharoCodeModifier
		compileMethodSource: self fooMethodName asString, ' aView
	<gtView>
	^ aView explicit 
		title: ''Foo'';
		priority: 1;
		stencil: [ BlElement new
			background: Color random;
			size: 300@150 ]'
		in: self demoClass
		protocol: 'gt-extension'.
	
	^ aSymbol
]

{ #category : #'method - foo' }
GtPhlowDemoDefinitionsExamples >> compileFooMethodVersionTwo [
	<gtExample>
	| aSymbol |

	aSymbol := GtPharoCodeModifier
		compileMethodSource: self fooMethodName asString, ' aView
	<gtView>
	^ aView explicit 
		title: ''Foo'';
		priority: 3;
		stencil: [ BlElement new
			background: Color random;
			geometry: BlCircle new;
			size: 300@150 ]'
		in: self demoClass
		protocol: 'gt-extension'.
	
	self assert: aSymbol equals: self fooMethodName.
	^ aSymbol
]

{ #category : #'method - printOn' }
GtPhlowDemoDefinitionsExamples >> compilePrintOnMethod [
	<gtExample>
	| aSymbol |
	
	aSymbol := GtPharoCodeModifier
		compileMethodSource: 'printOn: aStream
	aStream nextPutAll: ''Print A'''
		in: self demoClass
		protocol: 'printing'.

	self assert: aSymbol equals: #printOn:.
	^ (self demoClass >> self printOnMethodName) asRingDefinition
]

{ #category : #classes }
GtPhlowDemoDefinitionsExamples >> demoClass [
	<gtExample>
	| aClass |
	aClass := self class environment
		at: self demoClassName
		ifAbsent: [ Object
				subclass: self demoClassName
				instanceVariableNames: ''
				classVariableNames: ''
				package: self demoPackageName ].
	self
		assert: (self class environment at: self demoClassName)
		equals: aClass.
	^ aClass
]

{ #category : #classes }
GtPhlowDemoDefinitionsExamples >> demoClassName [
	<gtExample>
	^ #GtPhlowDemoClass
]

{ #category : #packages }
GtPhlowDemoDefinitionsExamples >> demoPackageName [
	<gtExample>
	^ 'GToolkit-PhlowTempPackage'
]

{ #category : #classes }
GtPhlowDemoDefinitionsExamples >> demoSubClass [
	<gtExample>
	| aClass |
	aClass := self class environment
		at: self demoSubClassName
		ifAbsent: [ self demoClass
				subclass: self demoSubClassName
				instanceVariableNames: ''
				classVariableNames: ''
				package: self demoPackageName ].
	self
		assert: (self class environment at: self demoSubClassName)
		equals: aClass.
	^ aClass
]

{ #category : #classes }
GtPhlowDemoDefinitionsExamples >> demoSubClassName [
	<gtExample>
	^ #GtPhlowDemoSubClass
]

{ #category : #'method - empty view' }
GtPhlowDemoDefinitionsExamples >> emptyViewMethodDefinition [
	<gtExample>
	| aRing |
	(self demoClass canUnderstand: self emptyViewMethodName) 
		ifFalse: [ self compileEmptyViewMethod ].
	aRing := (self demoClass >> self emptyViewMethodName) asRingDefinition.
	self assert: aRing isDefined.
	^ aRing
]

{ #category : #'method - empty view' }
GtPhlowDemoDefinitionsExamples >> emptyViewMethodName [
	<gtExample>
	^ #emptyViewFor:
]

{ #category : #'method - baz' }
GtPhlowDemoDefinitionsExamples >> ensureBazMethodRemoved [
	<gtExample>
	| aRing |
	self demoClass 
		compiledMethodAt: self bazMethodName 
		ifPresent: [ :aCompiledMethod | GtPharoCodeModifier removeMethod: aCompiledMethod ]
		ifAbsent: [ "do nothing" ].
	aRing := RGMethodDefinition new 
			name: self bazMethodName;
			parentName: self demoClass name;
			isMetaSide: self demoClass isMeta;
			asActive.
	self assert: aRing isDefined not.
	^ aRing
]

{ #category : #'method - foo' }
GtPhlowDemoDefinitionsExamples >> ensureFooMethodRemoved [
	<gtExample>
	| aRing |
	self demoClass 
		compiledMethodAt: self fooMethodName 
		ifPresent: [ :aCompiledMethod | self demoClass removeSelector: self fooMethodName ]
		ifAbsent: [ "do nothing" ].
	aRing := RGMethodDefinition new 
			name: self fooMethodName;
			parentName: self demoClass name;
			isMetaSide: self demoClass isMeta;
			asActive.
	self assert: aRing isDefined not.
	^ aRing
]

{ #category : #'method - printOn' }
GtPhlowDemoDefinitionsExamples >> ensurePrintOnMethodRemoved [
	<gtExample>
	| aRing |
	self demoClass 
		compiledMethodAt: self printOnMethodName 
		ifPresent: [ :aCompiledMethod | self demoClass removeSelector: self printOnMethodName ]
		ifAbsent: [ "do nothing" ].
	aRing := RGMethodDefinition new 
			name: self printOnMethodName;
			parentName: self demoClass name;
			isMetaSide: self demoClass isMeta;
			asActive.
	self assert: aRing isDefined not.
	^ aRing
]

{ #category : #'method - foo' }
GtPhlowDemoDefinitionsExamples >> fooMethodDefinition [
	<gtExample>
	| aRing |
	(self demoClass canUnderstand: self fooMethodName) 
		ifFalse: [ self compileFooMethod ].
	aRing := (self demoClass >> self fooMethodName) asRingDefinition.
	self assert: aRing isDefined.
	^ aRing
]

{ #category : #'method - foo' }
GtPhlowDemoDefinitionsExamples >> fooMethodName [
	<gtExample>
	^ #fooFor:
]

{ #category : #'method - printOn' }
GtPhlowDemoDefinitionsExamples >> printOnMethodDefinition [
	<gtExample>
	| aRing |
	self demoClass 
		compiledMethodAt: self printOnMethodName 
		ifAbsent: [ self compilePrintOnMethod ].
	aRing := (self demoClass >> self printOnMethodName) asRingDefinition.
	self assert: aRing isDefined.
	^ aRing
]

{ #category : #'method - printOn' }
GtPhlowDemoDefinitionsExamples >> printOnMethodName [
	^ #printOn:
]
