Class {
	#name : #GtPhlowTabbedToolSelectionState,
	#superclass : #GtPhlowSingleToolSelectionState,
	#instVars : [
		'tabIdentifier'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #actions }
GtPhlowTabbedToolSelectionState >> applyCompositeSelectionStateToElement: aToolElement [
	<return: #GtPhlowToolSelectionStateResponse>
	^ aToolElement phlow isCompositeTool
		ifTrue: [ self selectToolTabInElement: aToolElement ]
		ifFalse: [ aToolElement selectTabWithIdentifier: self tabIdentifier ].
]

{ #category : #actions }
GtPhlowTabbedToolSelectionState >> applySelectionStateToElement: aToolElement [
	<return: #GtPhlowToolSelectionStateResponse>
	^ aToolElement selectTabWithIdentifier: self tabIdentifier
]

{ #category : #'gt-views' }
GtPhlowTabbedToolSelectionState >> gtDetailsFor: aView [
	<gtView>
	^ aView details
		title: 'Info';
		priority: 10;
		row: #targetToolIdentifier value: [ targetToolIdentifier ];
		row: #tabIdentifier value: [ tabIdentifier ]
]

{ #category : #printing }
GtPhlowTabbedToolSelectionState >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		 self tabIdentifier descriptionOn: aStream ]
]

{ #category : #private }
GtPhlowTabbedToolSelectionState >> selectToolTabInElement: aTabGroupElement [
	<return: #GtPhlowToolSelectionStateResponse>
	| aToolElement |
	aToolElement := aTabGroupElement phlow firstChildWithTool.
	aToolElement ifNil: [ ^ GtPhlowToolSelectionStateResponse notApplied ].
	
	^ aToolElement selectTabWithIdentifier: self tabIdentifier
]

{ #category : #accessing }
GtPhlowTabbedToolSelectionState >> tabIdentifier [
	^ tabIdentifier
]

{ #category : #accessing }
GtPhlowTabbedToolSelectionState >> tabIdentifier: aTabIdentifier [
	tabIdentifier := aTabIdentifier
]
