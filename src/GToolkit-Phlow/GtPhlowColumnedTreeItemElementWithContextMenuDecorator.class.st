Class {
	#name : #GtPhlowColumnedTreeItemElementWithContextMenuDecorator,
	#superclass : #GtPhlowColumnedListItemElementWithContextMenuDecorator,
	#instVars : [
		'columns',
		'columnElements'
	],
	#category : #'GToolkit-Phlow-Support - List columned'
}

{ #category : #private }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> buildContextMenuAptitudeFor: anElement [
	"It is an old way to build context menu.
	Use #buildContextMenuItemsAptitudeFor: instead."

	| aContextMenuAptitude |
	aContextMenuAptitude := BrGlamorousWithExplicitContextMenuAptitude
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
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> buildContextMenuItemsAptitudeFor: anElement [
	| aMenuAptitude |
	aMenuAptitude := BrGlamorousWithExplicitContextMenuAptitude menu: [ 
				GtPhlowListAndListItemParentFinder new
					element: anElement;
					listKindOfClass: self listOfKindClass;
					foundBlock: [ :aListElement :aListItemElement | 
						| anItemHolder anItemPosition anItemObject anItemType |
						anItemHolder := aListItemElement constraints infinite holder.
						anItemPosition := anItemHolder dataSourcePosition.
						anItemObject := self isMultipleSelectionEnabled
								ifTrue: [ aListElement selectedItems
										ifEmpty: [ {(aListElement viewModel itemAt: anItemPosition) value} ] ]
								ifFalse: [ aListElement selectedItems
										ifNotEmpty: [ :items | items anyOne ]
										ifEmpty: [ (aListElement viewModel itemAt: anItemPosition) value ] ].
						
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

	anElement addAptitude: aMenuAptitude
]

{ #category : #accessing }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| anElement |
	anElement := stencilBuilder
			itemType: self itemType;
			columns: columns;
			columnElements: columnElements;
			build.

	"Prefer building context menu using `BrMenuModel` objects."
	contextMenuItemsStencil
		ifNotNil: [ self buildContextMenuItemsAptitudeFor: anElement ]
		ifNil: [ self buildContextMenuAptitudeFor: anElement ].

	^ anElement
]

{ #category : #accessing }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> columnElements: aListOfColumnElements [
	columnElements := aListOfColumnElements
]

{ #category : #accessing }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> columns: aListOfColumns [
	columns := aListOfColumns
]

{ #category : #private }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> listOfKindClass [
	^ BrColumnedTree
]

{ #category : #accessing }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> reset [
	super reset.
	
	columnElements := nil.
	columns := nil
]
