Class {
	#name : #GtPhlowColumnedTreeItemElementWithContextMenuDecorator,
	#superclass : #GtPhlowColumnedListItemElementWithContextMenuDecorator,
	#instVars : [
		'columns',
		'columnElements'
	],
	#category : #'GToolkit-Phlow-Support - List columned'
}

{ #category : #accessing }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> buildDefault [
	<return: #BrStencil or: #BlElement>
	
	| anElement aContextMenuAptitude |
	anElement := stencilBuilder
			itemType: self itemType;
			columns: columns;
			columnElements: columnElements;
			build.

	aContextMenuAptitude := BrGlamorousWithContextMenuAptitude
			content:
				[ anElement
					withAllParentsDetect: [ :eachParent | eachParent constraints infinite holder infiniteElement notNil ]
					ifFound:
						[ :aListItemElement | 
						anElement
							allParentsDetect: [ :eachParent | eachParent phlow isView ]
							ifFound:
								[ :aContainerElement | 
								aContainerElement
									allChildrenBreadthFirstDetect: [ :eachChild | eachChild isKindOf: BrColumnedTree ]
									ifFound:
										[ :aListElement | 
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
									ifNone: [ BlElement new ] ]
							ifNone: [ 
						BlElement new ] ]
					ifNone: [ BlElement new ] ].

	anElement addAptitude: aContextMenuAptitude.
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

{ #category : #accessing }
GtPhlowColumnedTreeItemElementWithContextMenuDecorator >> reset [
	super reset.
	
	columnElements := nil.
	columns := nil
]
