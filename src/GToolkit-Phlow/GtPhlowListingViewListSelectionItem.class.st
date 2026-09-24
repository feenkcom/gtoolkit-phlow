Class {
	#name : #GtPhlowListingViewListSelectionItem,
	#superclass : #GtPhlowListingViewSelectionItem,
	#category : #'GToolkit-Phlow-Support - Selection'
}

{ #category : #converting }
GtPhlowListingViewListSelectionItem >> asRemoteSelectionItem [
	| item |
	item := GtRemotePhlowListingViewListSelectionItem new
		nodeIdentifier: self nodeIdentifier asRemoteNodeIdentifier.
	self selectionIndex ifNotNil: [ :idx | item selectionIndex: idx ].
	^ item
]
