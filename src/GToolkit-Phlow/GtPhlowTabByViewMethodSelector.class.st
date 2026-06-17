Class {
	#name : #GtPhlowTabByViewMethodSelector,
	#superclass : #GtPhlowTabSelector,
	#instVars : [
		'methodSelector'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #actions }
GtPhlowTabByViewMethodSelector >> matchesTab: aTabModel [ 
	| currentViewSelector |
	currentViewSelector := aTabModel widget phlow entity methodSelector.
	^ currentViewSelector = self methodSelector
]

{ #category : #accessing }
GtPhlowTabByViewMethodSelector >> methodSelector [
	^ methodSelector
]

{ #category : #accessing }
GtPhlowTabByViewMethodSelector >> methodSelector: aSelector [
	methodSelector := aSelector
]

{ #category : #printing }
GtPhlowTabByViewMethodSelector >> printOn: aStream [
	aStream 
		nextPutAll: 'Select view with selector: ';
		print: self methodSelector
]
