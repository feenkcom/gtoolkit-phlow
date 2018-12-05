Class {
	#name : #GtPhlowDemoDefinitionsExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #methods }
GtPhlowDemoDefinitionsExamples >> bazMethodDefinition [
	<gtExample>
	| aCompiledMethod |
	aCompiledMethod := self demoClass compile: 'bazFor: aView
	<gtView>
	^ aView explicit 
		title: ''Baz'';
		stencil: [ BlElement new
			background: Color random;
			size: 150@300 ]' classified: 'gt-extension'.
	self assert: aCompiledMethod equals: #bazFor:.
	^ (self demoClass >> #bazFor:) asRingDefinition
]

{ #category : #methods }
GtPhlowDemoDefinitionsExamples >> collectionOfDefiningMethods [
	<gtExample>
	^ Array 
		with: self fooMethodDefinition
		with: self bazMethodDefinition
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
				package: 'GToolkit-PhlowTempPackage' ].
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

{ #category : #methods }
GtPhlowDemoDefinitionsExamples >> fooMethodDefinition [
	<gtExample>
	| aCompiledMethod |
	aCompiledMethod := self demoClass compile: 'fooFor: aView
	<gtView>
	^ aView explicit 
		title: ''Foo'';
		stencil: [ BlElement new
			background: Color random;
			size: 300@150 ]' classified: 'gt-extension'.
	self assert: aCompiledMethod equals: #fooFor:.
	^ (self demoClass >> #fooFor:) asRingDefinition
]

{ #category : #methods }
GtPhlowDemoDefinitionsExamples >> printOnMethodDefinition [
	<gtExample>
	| aCompiledMethod |
	aCompiledMethod := self demoClass compile: 'printOn: aStream
	aStream nextPutAll: ''Print A''' classified: 'printing'.
	self assert: aCompiledMethod equals: #printOn:.
	^ (self demoClass >> #printOn:) asRingDefinition
]
