Class {
	#name : #GtPhlowListingViewMultipleSelection,
	#superclass : #GtPhlowListingViewSelection,
	#instVars : [
		'selectionItems'
	],
	#category : #'GToolkit-Phlow-Support - Selection'
}

{ #category : #converting }
GtPhlowListingViewMultipleSelection >> asRemoteSelection [
	^ GtRemotePhlowListingViewMultipleSelection new
		selectionItems: (self selectionItems collect: [ :each | each asRemoteSelectionItem ])
]

{ #category : #testing }
GtPhlowListingViewMultipleSelection >> isMultipleSelection [
	^ true
]

{ #category : #accessing }
GtPhlowListingViewMultipleSelection >> selectionItems [
	^ selectionItems ifNil: [ selectionItems := #() ]
]

{ #category : #accessing }
GtPhlowListingViewMultipleSelection >> selectionItems: aCollectionOfSelectionItems [
	selectionItems := aCollectionOfSelectionItems
]

{ #category : #accessing }
GtPhlowListingViewMultipleSelection >> size [
	^ selectionItems 
			ifNil: [0] 
			ifNotNil: [ :aCollection | aCollection size ]	
]
