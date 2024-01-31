"
I am an identifier for locating the tab of a tool within a tab group.

I use the tool name, in addition to the class of the tool. This means that two tools that are instances of the same class will have a different identitifer if they have different names. 

This makes it possible for two instances of the same tool class to be in a composite tool and be handled correctlys, if they have the different names. It is not possible to have two tools that are instances of the same class with the same name in a composite tool. There needs to be a way to differentiate them.
"
Class {
	#name : #GtPhlowToolTabIdentifier,
	#superclass : #Object,
	#instVars : [
		'toolName',
		'toolClassName'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #'initialization ' }
GtPhlowToolTabIdentifier class >> forTool: aPhlowTool [
	^ self new
		initializeForTool: aPhlowTool
]

{ #category : #comparing }
GtPhlowToolTabIdentifier >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ toolClassName = anObject toolClassName and: [
		toolName = anObject toolName ]
]

{ #category : #comparing }
GtPhlowToolTabIdentifier >> hash [

	^ toolClassName hash
		bitXor: toolName hash
]

{ #category : #initialization }
GtPhlowToolTabIdentifier >> initializeForTool: aPhlowTool [
	toolName := aPhlowTool name.
	toolClassName := aPhlowTool class name.
]

{ #category : #testing }
GtPhlowToolTabIdentifier >> matchesTab: aTabModel [
	<return: #Boolean>
	| toolLabelPhlowContext |
	toolLabelPhlowContext := aTabModel widget phlow.
	
	^ toolLabelPhlowContext isToolLabel and: [ 
		self = toolLabelPhlowContext entity toolTabIdentifier ]
]

{ #category : #printing }
GtPhlowToolTabIdentifier >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< toolClassName;
			<< ' - ';
			<< toolName ]
]

{ #category : #accessing }
GtPhlowToolTabIdentifier >> toolClassName [
	^ toolClassName
]

{ #category : #accessing }
GtPhlowToolTabIdentifier >> toolName [
	^ toolName
]
