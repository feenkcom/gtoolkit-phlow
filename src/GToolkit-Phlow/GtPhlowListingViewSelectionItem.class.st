Class {
	#name : #GtPhlowListingViewSelectionItem,
	#superclass : #Object,
	#instVars : [
		'nodeIdentifier',
		'selectionIndex'
	],
	#category : #'GToolkit-Phlow-Support - Selection'
}

{ #category : #testing }
GtPhlowListingViewSelectionItem class >> isAbstract [
	^ self name = #GtPhlowListingViewSelectionItem
]

{ #category : #comparing }
GtPhlowListingViewSelectionItem >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self nodeIdentifier = anObject nodeIdentifier
		and: [ self selectionIndex = anObject selectionIndex ]
]

{ #category : #converting }
GtPhlowListingViewSelectionItem >> asRemoteSelectionItem [
	^ self subclassResponsibility
]

{ #category : #printing }
GtPhlowListingViewSelectionItem >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #printing }
GtPhlowListingViewSelectionItem >> descriptionOn: aStream [
	self nodeIdentifier descriptionOn: aStream.
	self selectionIndex ifNotNil: [ :anIndex |
		aStream nextPutAll: ' @ '.
		aStream print: anIndex ]
]

{ #category : #comparing }
GtPhlowListingViewSelectionItem >> hash [
	^ self nodeIdentifier hash bitXor: self selectionIndex hash
]

{ #category : #accessing }
GtPhlowListingViewSelectionItem >> nodeIdentifier [
	^ nodeIdentifier
]

{ #category : #accessing }
GtPhlowListingViewSelectionItem >> nodeIdentifier: aNodeIdentifier [
	nodeIdentifier := aNodeIdentifier
]

{ #category : #printing }
GtPhlowListingViewSelectionItem >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		self descriptionOn: aStream ]
]

{ #category : #accessing }
GtPhlowListingViewSelectionItem >> selectionIndex [
	^ selectionIndex
]

{ #category : #accessing }
GtPhlowListingViewSelectionItem >> selectionIndex: anInteger [
	selectionIndex := anInteger
]
