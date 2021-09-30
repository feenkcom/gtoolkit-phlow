"
#Context menu decorator for a list item element

Decorates {{gtClass:BrListItemElementStencilBuilder}} and adds support for a context menu. Intended to be used by {{gtClass:GtPhlowListView}}.

"
Class {
	#name : #GtPhlowListItemElementWithContextMenuDecorator,
	#superclass : #BrListItemElementStencilBuilder,
	#instVars : [
		'stencilBuilder',
		'contextMenuStencil'
	],
	#category : 'GToolkit-Phlow-Support - List utilities'
}

{ #category : #'api - instantiation' }
GtPhlowListItemElementWithContextMenuDecorator >> buildDefault [
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
							allParentsDetect: [ :eachParent | eachParent phlow isView ]
							ifFound: [ :aListElement |
								| anItemHolder anItemPosition anItemObject anItemType |
						
								anItemHolder := aListItemElement constraints infinite holder.
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
					ifNone: [ BlElement new ]
					]
					ifNone: [ BlElement new ].
				
				
				 ].

	anElement addAptitude: aContextMenuAptitude.
	^ anElement
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuStencil [
	<return: #GtPhlowListContextMenuStencilBuilder>

	^ contextMenuStencil
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuStencil: aGtPhlowListContextMenuStencilBuilder [
	contextMenuStencil := aGtPhlowListContextMenuStencilBuilder asStencilBuilder: GtPhlowListContextMenuStencilBuilder
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> stencilBuilder [
	<return: #BrListItemElementStencilBuilder>

	^ stencilBuilder
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> stencilBuilder: aBrListItemElementStencilBuilder [
	stencilBuilder := aBrListItemElementStencilBuilder asStencilBuilder: BrListItemElementStencilBuilder
]
