Class {
	#name : #GtPhlowListingViewSingleSelection,
	#superclass : #GtPhlowListingViewSelection,
	#instVars : [
		'selectionItem'
	],
	#category : #'GToolkit-Phlow-Support - Selection'
}

{ #category : #converting }
GtPhlowListingViewSingleSelection >> asRemoteSelection [
	^ GtRemotePhlowListingViewSingleSelection new
		selectionItem: self selectionItem asRemoteSelectionItem
]

{ #category : #accessing }
GtPhlowListingViewSingleSelection >> selectionItem [
	^ selectionItem
]

{ #category : #accessing }
GtPhlowListingViewSingleSelection >> selectionItem: aSelectionItem [
	selectionItem := aSelectionItem
]

{ #category : #accessing }
GtPhlowListingViewSingleSelection >> selectionItems [
	^ { self selectionItem }
]

{ #category : #accessing }
GtPhlowListingViewSingleSelection >> size [
	^ 1
]
