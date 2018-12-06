Class {
	#name : #GtPhlowDefiningMethods,
	#superclass : #Object,
	#instVars : [
		'methods'
	],
	#category : #'GToolkit-Phlow-Builders'
}

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
