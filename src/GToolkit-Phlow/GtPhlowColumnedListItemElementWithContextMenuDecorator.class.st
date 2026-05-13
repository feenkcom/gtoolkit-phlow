Class {
	#name : #GtPhlowColumnedListItemElementWithContextMenuDecorator,
	#superclass : #GtPhlowListItemElementWithContextMenuDecorator,
	#category : #'GToolkit-Phlow-Support - List columned'
}

{ #category : #'api - instantiation' }
GtPhlowColumnedListItemElementWithContextMenuDecorator >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| anElement |
	anElement := stencilBuilder
			itemType: self itemType;
			build.
	
	"Prefer building context menu using `BrMenuModel` objects."
	contextMenuItemsStencil
		ifNotNil: [ self buildContextMenuItemsAptitudeFor: anElement ]
		ifNil: [ self buildContextMenuAptitudeFor: anElement ].
	
	^ anElement
]

{ #category : #'as yet unclassified' }
GtPhlowColumnedListItemElementWithContextMenuDecorator >> listOfKindClass [
	^ BrColumnedList
]
