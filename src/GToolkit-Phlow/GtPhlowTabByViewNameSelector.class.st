Class {
	#name : #GtPhlowTabByViewNameSelector,
	#superclass : #GtPhlowTabSelector,
	#traits : 'TGtInspectorTabNameAccessor',
	#classTraits : 'TGtInspectorTabNameAccessor classTrait',
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #initialization }
GtPhlowTabByViewNameSelector >> initialize [
	super initialize.
	
	self initializeTabName.
]

{ #category : #actions }
GtPhlowTabByViewNameSelector >> matchesTab: aTabModel [ 
	^ self tabName matchesTab: aTabModel
]

{ #category : #printing }
GtPhlowTabByViewNameSelector >> printOn: aStream [
	aStream 
		nextPutAll: 'Selector of: ';
		print: self tabName
]
