Class {
	#name : #GtPhlowListingViewTreeSelectionItem,
	#superclass : #GtPhlowListingViewSelectionItem,
	#category : #'GToolkit-Phlow-Support - Selection'
}

{ #category : #converting }
GtPhlowListingViewTreeSelectionItem >> asRemoteSelectionItem [
	| item |
	item := GtRemotePhlowListingViewTreeSelectionItem new
		nodeIdentifier: self nodeIdentifier asRemoteNodeIdentifier.
	self selectionIndex ifNotNil: [ :idx | item selectionIndex: idx ].
	^ item
]
