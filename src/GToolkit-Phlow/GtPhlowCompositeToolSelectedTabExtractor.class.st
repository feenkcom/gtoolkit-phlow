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
	<return: #GtPhlowToolTabIdentifier or: #GtPhlowToolNullTabIdentifier>
	| selectedTabPhlowContext |
	
	tabGroupElement viewModel hasSelectedTab ifFalse: [ ^ GtPhlowToolNullTabIdentifier uniqueInstance ].
	
	selectedTabPhlowContext := tabGroupElement viewModel selectedTab widget phlow.
	^ (selectedTabPhlowContext isToolLabel and: [
		selectedTabPhlowContext entity notNil ])
			ifTrue: [ selectedTabPhlowContext entity toolTabIdentifier ]
			ifFalse: [ GtPhlowToolNullTabIdentifier uniqueInstance ].
]

{ #category : #accessing }
GtPhlowCompositeToolSelectedTabExtractor >> tabGroupElement: aTabGroupElement [
	tabGroupElement := aTabGroupElement
]
