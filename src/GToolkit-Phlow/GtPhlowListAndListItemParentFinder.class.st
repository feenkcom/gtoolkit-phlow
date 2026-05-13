"
I search for an infinite element, e.g., {{gtClass:BrList}} and {{gtClass:BrTree}}.
I search among parents of a given {{gtMethod:GtPhlowListAndListItemParentFinder>>element: | label=#selector}}. 
I evaluate {{gtMethod:GtPhlowListAndListItemParentFinder>>foundBlock: | label=#selector}} if the infinite element is founds.
I evaluate {{gtMethod:GtPhlowListAndListItemParentFinder>>noneBlock: | label=#selector}} in other cases.
"
Class {
	#name : #GtPhlowListAndListItemParentFinder,
	#superclass : #Object,
	#instVars : [
		'element',
		'foundBlock',
		'noneBlock',
		'listKindOfClass'
	],
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowListAndListItemParentFinder >> element [
	^ element
]

{ #category : #accessing }
GtPhlowListAndListItemParentFinder >> element: anElement [
	"Set element from which it starts to search for its list/tree item element 
	and its list/tree element."

	element := anElement
]

{ #category : #finding }
GtPhlowListAndListItemParentFinder >> find [
	"Search for list/tree element and list/tree item element.
	Evaluate either foundBlock or noneBlock."

	^ element
		withAllParentsDetect: [ :eachParent | 
			eachParent constraints infinite holder infiniteElement notNil ]
		ifFound: [ :aListItemElement | 
			aListItemElement
				allParentsDetect: [ :eachParent | 
					eachParent phlow isViewContent ]
				ifFound: [ :aContainerElement | 
					(aContainerElement isKindOf: listKindOfClass)
						ifTrue: [ 
							foundBlock cull: aContainerElement cull: aListItemElement ]
						ifFalse: [				
							aContainerElement
								allChildrenBreadthFirstDetect: [ :eachChild | 
									eachChild isKindOf: listKindOfClass ]
								ifFound: [ :aListElement | 
									foundBlock cull: aListElement cull: aListItemElement ]
								ifNone: noneBlock ] ]
				ifNone: noneBlock ]
		ifNone: noneBlock
]

{ #category : #accessing }
GtPhlowListAndListItemParentFinder >> foundBlock [
	^ foundBlock
]

{ #category : #accessing }
GtPhlowListAndListItemParentFinder >> foundBlock: aBlock [
	"Set a block that is evaluated if list and list item is found.
	It has two arguments: [ :aListElement :aListItemElement | ]"

	foundBlock := aBlock
]

{ #category : #accessing }
GtPhlowListAndListItemParentFinder >> listKindOfClass [
	^ listKindOfClass
]

{ #category : #accessing }
GtPhlowListAndListItemParentFinder >> listKindOfClass: aClass [
	"Set a list class that is expected to find"

	listKindOfClass := aClass
]

{ #category : #accessing }
GtPhlowListAndListItemParentFinder >> noneBlock [
	^ noneBlock
]

{ #category : #accessing }
GtPhlowListAndListItemParentFinder >> noneBlock: aBlock [
	"Set a block that is evaluated if list and list item is not found"

	noneBlock := aBlock
]
