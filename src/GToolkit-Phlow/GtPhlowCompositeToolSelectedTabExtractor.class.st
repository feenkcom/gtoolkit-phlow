Class {
	#name : #GtPhlowCompositeToolSelectedTabExtractor,
	#superclass : #Object,
	#instVars : [
		'tabGroupElement'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #accessing }
GtPhlowCompositeToolSelectedTabExtractor >> extractTabIdentifier [
	<return: #GtPhlowToolTabIdentifier>
	| selectedTabPhlowContext |
	
	selectedTabPhlowContext := tabGroupElement viewModel selectedTab widget phlow.
	^ (selectedTabPhlowContext isToolLabel and: [
		selectedTabPhlowContext entity notNil ])
			ifTrue: [ selectedTabPhlowContext entity toolTabIdentifier ]
			ifFalse: [ nil ].
]

{ #category : #accessing }
GtPhlowCompositeToolSelectedTabExtractor >> tabGroupElement: aTabGroupElement [
	tabGroupElement := aTabGroupElement
]
