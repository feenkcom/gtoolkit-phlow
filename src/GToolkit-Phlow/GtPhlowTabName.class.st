Class {
	#name : #GtPhlowTabName,
	#superclass : #GtPhlowTabIdentifier,
	#instVars : [
		'string'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #factory }
GtPhlowTabName class >> null [ 
	^ GtPhlowNullTabIdentifier default
]

{ #category : #actions }
GtPhlowTabName >> applySelectionTo: anInspectorElement [
	<return: #GtPhlowToolSelectionStateResponse>
	^ (GtPhlowTabSelector byViewName tabName: self)
		selectTabInInspectorElement: anInspectorElement
		on: nil
]

{ #category : #printing }
GtPhlowTabName >> descriptionOn: aStream [

	aStream 
		nextPutAll: 'Tab name: ';
		print: self string 
]

{ #category : #testing }
GtPhlowTabName >> isEqualToString: aString [
	^ self string = aString
]

{ #category : #testing }
GtPhlowTabName >> matchesTab: aTabModel [
	| currentTabTitle |
	currentTabTitle := aTabModel widget phlow entity ifNotNil: #title.
	^ self isEqualToString: currentTabTitle asString
]

{ #category : #printing }
GtPhlowTabName >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< self string ]
]

{ #category : #accessing }
GtPhlowTabName >> string [
	<return: #String>
	^ string
]

{ #category : #accessing }
GtPhlowTabName >> string: aString [
	self 
		assert: [ aString isString ] 
		description: [ 'Tab name must be a string' ].
	string := aString
]
