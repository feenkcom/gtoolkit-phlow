Class {
	#name : #GtPhlowTreeItemElementWithContextMenuDecorator,
	#superclass : #GtPhlowListItemElementWithContextMenuDecorator,
	#category : #'GToolkit-Phlow-Support - Tree utilities'
}

{ #category : #accessing }
GtPhlowTreeItemElementWithContextMenuDecorator >> buildContextMenuAptitudeFor: anElement [
	"It is an old way to build context menu.
	Use #buildContextMenuItemsAptitudeFor: instead."
	
	| aContextMenuAptitude |
	aContextMenuAptitude := BrGlamorousWithContextMenuAptitude
			content: [ 
				GtPhlowListAndListItemParentFinder new
					element: anElement;
					listKindOfClass: self listOfKindClass;
					foundBlock: [ :aListElement :aListItemElement | 
						| anItemHolder anItemPosition anItemObject anItemType |
						anItemHolder := aListItemElement constraints infinite holder.
						anItemPosition := anItemHolder dataSourcePosition.
						anItemObject := aListElement viewModel itemAt: anItemPosition.

						anItemType := aListElement viewModel nodeTypeStencil
							itemPosition: anItemPosition;
							itemNode: anItemObject;
							build.

						contextMenuStencil
							itemType: anItemType;
							itemObject: anItemObject;
							itemPosition: anItemPosition;
							itemElement: anElement;
							build ];
					noneBlock: [ BlElement new ];
					find ].

	anElement addAptitude: aContextMenuAptitude
]

{ #category : #private }
GtPhlowTreeItemElementWithContextMenuDecorator >> buildContextMenuItemsAptitudeFor: anElement [
	| aMenuAptitude |
	aMenuAptitude := BrWithExplicitMenuAptitude new
			withAllExtraEventHandlers;
			withClickPositionRelocator;
			handleSubmenu: [ 
				GtPhlowListAndListItemParentFinder new
					element: anElement;
					listKindOfClass: self listOfKindClass;
					foundBlock: [ :aListElement :aListItemElement | 
						| anItemHolder anItemPosition anItemObject anItemType |
						anItemHolder := aListItemElement constraints infinite holder.
						anItemPosition := anItemHolder dataSourcePosition.
						anItemObject := aListElement viewModel itemAt: anItemPosition.

						anItemType := aListElement viewModel nodeTypeStencil
							itemPosition: anItemPosition;
							itemNode: anItemObject;
							build.

						contextMenuItemsStencil
							itemType: anItemType;
							itemObject: anItemObject;
							itemPosition: anItemPosition;
							itemElement: anElement;
							build ];
					noneBlock: [ nil ];
					find ].

	anElement addAptitude: aMenuAptitude.
]

{ #category : #accessing }
GtPhlowTreeItemElementWithContextMenuDecorator >> buildDefault [
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

{ #category : #private }
GtPhlowTreeItemElementWithContextMenuDecorator >> listOfKindClass [
	^ BrTree
]
