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

{ #category : #stream }
GtPhlowDefiningMethods >> gtOriginMethodsInto: aWriteStream [ 
	aWriteStream nextPutAll: self methods
]

{ #category : #accessing }
GtPhlowDefiningMethods >> gtPhlowIncludesCompiledMethod: aCompiledMethod [
	^ self methods anySatisfy: [ :eachMethod | 
		eachMethod gtPhlowIncludesCompiledMethod: aCompiledMethod ]
]

{ #category : #ui }
GtPhlowDefiningMethods >> gtSourceFor: aView [
	<gtView>
	self methods ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Source';
		stencil: [ 
			| aContainer |
			aContainer := BlElement new.
			aContainer 
				layout: BlLinearLayout vertical;
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal matchParent ].
			self methods do: [ :eachMethod | 
				aContainer addChild: (
					(GtPharoMethodCoder forMethod: eachMethod) asCoderViewModel
						withHeader;
						expanded: true;
						asElement) ].
			aContainer asScrollableElement]
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
