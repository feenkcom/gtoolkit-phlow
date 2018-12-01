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
	^ aView list
		title: 'Source';
		items: [ self methods ];
		itemElement: [ :aMethodDefinition |
			(GtMethodCoder forMethod: aMethodDefinition) expanded: true; asElement ]
]

{ #category : #accessing }
GtPhlowDefiningMethods >> methods [
	^ methods
]

{ #category : #accessing }
GtPhlowDefiningMethods >> methods: anObject [
	methods := anObject
]
