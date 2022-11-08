Class {
	#name : #GtPhlowColumnedListItemElementWithContextMenuDecorator,
	#superclass : #GtPhlowListItemElementWithContextMenuDecorator,
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #accessing }
GtPhlowColumnedListItemElementWithContextMenuDecorator >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| anElement aContextMenuAptitude |
	anElement := stencilBuilder
			itemType: self itemType;
			build.

	aContextMenuAptitude := BrGlamorousWithContextMenuAptitude
			content: [ anElement
					allParentsDetect: [ :eachParent | eachParent phlow isView ]
					ifFound: [ :aContainerElement | 
						aContainerElement
							allChildrenBreadthFirstDetect: [ :eachChild | eachChild isKindOf: BrColumnedList ]
							ifFound: [ :aListElement | 
								| anItemHolder anItemPosition anItemObject anItemType |
								anItemHolder := anElement constraints infinite holder.
								anItemPosition := anItemHolder dataSourcePosition.
								anItemObject := aListElement viewModel itemAt: anItemPosition.
								anItemType := aListElement viewModel itemTypeStencil
										itemPosition: anItemPosition;
										itemObject: anItemObject;
										build.

								contextMenuStencil
									itemType: anItemType;
									itemObject: anItemObject;
									itemPosition: anItemPosition;
									itemElement: anElement;
									build ]
							ifNone: [ BlElement new ] ]
					ifNone: [ BlElement new ] ].

	anElement addAptitude: aContextMenuAptitude.
	^ anElement
]
