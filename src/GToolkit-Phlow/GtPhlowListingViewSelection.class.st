Class {
	#name : #GtPhlowListingViewSelection,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Support - Selection'
}

{ #category : #'instance creation' }
GtPhlowListingViewSelection class >> forMultipleListIndexes: aCollectionOfIntegers [
	^ GtPhlowListingViewMultipleSelection new
		selectionItems: (aCollectionOfIntegers collect: [ :each |
			GtPhlowListingViewListSelectionItem new
				nodeIdentifier: (GtPhlowNodeIdentifier forListIndex: each);
				selectionIndex: each ])
]

{ #category : #'instance creation' }
GtPhlowListingViewSelection class >> forSingleListIndex: anInteger [
	^ GtPhlowListingViewSingleSelection new
		selectionItem: (GtPhlowListingViewListSelectionItem new
			nodeIdentifier: (GtPhlowNodeIdentifier forListIndex: anInteger);
			selectionIndex: anInteger)
]

{ #category : #'instance creation' }
GtPhlowListingViewSelection class >> forSingleTreePath: anArray selectionIndex: anInteger [
	^ GtPhlowListingViewSingleSelection new
		selectionItem: (GtPhlowListingViewTreeSelectionItem new
			nodeIdentifier: (GtPhlowNodeIdentifier forTreePath: anArray);
			selectionIndex: anInteger)
]

{ #category : #testing }
GtPhlowListingViewSelection class >> isAbstract [
	^ self name = #GtPhlowListingViewSelection
]

{ #category : #comparing }
GtPhlowListingViewSelection >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self selectionItems = anObject selectionItems
]

{ #category : #converting }
GtPhlowListingViewSelection >> asRemoteSelection [
	^ self subclassResponsibility
]

{ #category : #printing }
GtPhlowListingViewSelection >> descriptionOn: aStream [
	self selectionItems 
		do: [ :each | each descriptionOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #'gt - extensions' }
GtPhlowListingViewSelection >> gtViewSelectionItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Selection items';
		items: [ self selectionItems ];
		column: 'Index in tree' text: [ :each | each selectionIndex ] width: 100;
		column: 'Node identifier' text: [ :each | each nodeIdentifier ]
]

{ #category : #comparing }
GtPhlowListingViewSelection >> hash [
	^ self selectionItems hash
]

{ #category : #testing }
GtPhlowListingViewSelection >> isMultipleSelection [
	^ false
]

{ #category : #enumerating }
GtPhlowListingViewSelection >> nodeIdentifiersDo: aBlock [
	self selectionItemsDo: [ :each | aBlock value: each nodeIdentifier ]
]

{ #category : #printing }
GtPhlowListingViewSelection >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		self descriptionOn: aStream ]
]

{ #category : #accessing }
GtPhlowListingViewSelection >> selectionIndex [
	^ self selectionIndices
]

{ #category : #accessing }
GtPhlowListingViewSelection >> selectionIndices [
	^ Array withAll: (self selectionItems collect: [ :each | 
			each selectionIndex ])
]

{ #category : #accessing }
GtPhlowListingViewSelection >> selectionItems [
	^ self subclassResponsibility
]

{ #category : #enumerating }
GtPhlowListingViewSelection >> selectionItemsDo: aBlock [
	self selectionItems do: aBlock
]

{ #category : #accessing }
GtPhlowListingViewSelection >> size [
	^ self subclassResponsibility
]
