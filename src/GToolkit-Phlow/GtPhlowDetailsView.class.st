Class {
	#name : #GtPhlowDetailsView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'rows',
		'localSend'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #'api - converting' }
GtPhlowDetailsView >> asElementDo: aBlockClosure [
	| detailsElement viewElement |
	detailsElement := GtPhlowDetailsElement new
		detailsView: self.
	viewElement := detailsElement asScrollableElement.
	
	self beViewElement: viewElement.
	
	^aBlockClosure value: viewElement
]

{ #category : #views }
GtPhlowDetailsView >> gtRowsFor: aView [
	<gtView>
	rows ifNil: [^aView empty].
	^(aView columnedList)
		title: 'Rows';
		priority: 11;
		items: [rows];
		column: 'Name' text: [:each | each name ];
		column: 'Value' text: [:each | each valueComputation ];
		column: 'Text' text: [:each | each textComputation ]
]

{ #category : #initialization }
GtPhlowDetailsView >> initialize [
	super initialize.
	
	rows := OrderedCollection new
]

{ #category : #private }
GtPhlowDetailsView >> localSend [
	^ localSend
]

{ #category : #private }
GtPhlowDetailsView >> localSend: aBlock [
	"Do not use; only used by remote views as an hack"
	localSend := aBlock
]

{ #category : #'as yet unclassified' }
GtPhlowDetailsView >> phlowDetailRows [
	^ rows
]

{ #category : #private }
GtPhlowDetailsView >> row: aString value: aBlockClosure [
	rows add: (GtPhlowDetailsRow new
		name: aString;
		valueComputation: aBlockClosure)
]

{ #category : #'api - scripting' }
GtPhlowDetailsView >> row: aString value: aValueComputation text: aTextComputation [
	rows add: (GtPhlowDetailsRow new
		name: aString;
		valueComputation: aValueComputation;
		textComputation: aTextComputation)
]
