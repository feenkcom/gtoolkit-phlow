"
I am {{gtClass:BlEvent}}. 
I am fired when users explicitly select tabs to inform that another tool tab is selected.
"
Class {
	#name : #GtPhlowExplicitlySelectedTabEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selectedTab',
		'toolElement'
	],
	#category : #'GToolkit-Phlow-Tool - Selection'
}

{ #category : #accessing }
GtPhlowExplicitlySelectedTabEvent >> selectedTab [
	^ selectedTab
]

{ #category : #accessing }
GtPhlowExplicitlySelectedTabEvent >> selectedTab: anObject [
	selectedTab := anObject
]

{ #category : #sending }
GtPhlowExplicitlySelectedTabEvent >> sendTo: anObject [
	^ anObject phlowExplicitlySelectedTabEvent: self
]

{ #category : #accessing }
GtPhlowExplicitlySelectedTabEvent >> toolElement [
	^ toolElement
]

{ #category : #accessing }
GtPhlowExplicitlySelectedTabEvent >> toolElement: anObject [
	toolElement := anObject
]
