Class {
	#name : #GtPhlowTreeItemElementWithContextMenuDecorator,
	#superclass : #GtPhlowListItemElementWithContextMenuDecorator,
	#category : #'GToolkit-Phlow-Support - Tree utilities'
}

{ #category : #accessing }
GtPhlowTreeItemElementWithContextMenuDecorator >> buildDefault [
	| anElement aContextMenuAptitude |
	<return: #BrStencil or: #BlElement>

	anElement := stencilBuilder
		itemType: self itemType;
		build.

	aContextMenuAptitude :=
		BrGlamorousWithContextMenuAptitude
			content: [
				anElement
					allParentsDetect: [ :eachParent | eachParent constraints infinite holder infiniteElement notNil ]
					ifFound: [ :aListItemElement |
						anElement
							allParentsDetect: [ :eachParent | eachParent phlow isViewContent ]
							ifFound: [ :aListElement |
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
					ifNone: [ BlElement new ]
					]
					ifNone: [ BlElement new ].
				
				
				 ].

	anElement addAptitude: aContextMenuAptitude.
	^ anElement
]
