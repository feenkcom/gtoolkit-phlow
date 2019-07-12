Class {
	#name : #GtPhlowDefiningMethods,
	#superclass : #Object,
	#instVars : [
		'methods'
	],
	#category : #'GToolkit-Phlow-Builders'
}

{ #category : #accessing }
GtPhlowDefiningMethods >> fullName [
	"Return Class>>#selector name"
	<return: #Symbol>
	^ self methods first fullName
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
					(GtMethodCoder forMethod: eachMethod) 
						expanded: true; asElement) ].
			aContainer ]
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
