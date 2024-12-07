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
	| aContextMenuAptitude |
	aContextMenuAptitude := BrGlamorousWithContextMenuAptitude
			content: [ 
				self 
					findColumnedTreeFor: anElement 
					ifFound: [ :aListElement :aListItemElement |
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
							build ] 
					ifNone: [ BlElement new ] ].

	anElement addAptitude: aContextMenuAptitude.
]

{ #category : #private }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> buildContextMenuItemsAptitudeFor: anElement [
	| aMenuAptitude |
	aMenuAptitude := BrWithExplicitMenuAptitude new
			beClickPositionRelocator;
			stencil: [ 
				self 
					findColumnedTreeFor: anElement 
					ifFound: [ :aListElement :aListItemElement |
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
							build ] 
					ifNone: [ nil ] ].

	anElement addAptitude: aMenuAptitude.
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
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> findColumnedTreeFor: anElement ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self
		for: anElement
		findListOfKind: BrColumnedTree
		ifFound: aFoundBlock
		ifNone: aNoneBlock.
]

{ #category : #private }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> for: anElement findListOfKind: aListClass ifFound: aFoundBlock ifNone: aNoneBlock [
	^ anElement
		withAllParentsDetect: [ :eachParent | 
			eachParent constraints infinite holder infiniteElement notNil ]
		ifFound: [ :aListItemElement | 
			anElement
				allParentsDetect: [ :eachParent | 
					eachParent phlow isViewContent ]
				ifFound: [ :aContainerElement | 
					aContainerElement
						allChildrenBreadthFirstDetect: [ :eachChild | 
							eachChild isKindOf: aListClass ]
						ifFound: [ :aListElement | 
							aFoundBlock cull: aListElement cull: aListItemElement ]
						ifNone: aNoneBlock ]
				ifNone: aNoneBlock ]
		ifNone: aNoneBlock
]

{ #category : #accessing }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> reset [
	super reset.
	
	columnElements := nil.
	columns := nil
]
