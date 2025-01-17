"
#Context menu decorator for a list item element

Decorates {{gtClass:BrListItemElementStencilBuilder}} and adds support for a context menu. Intended to be used by {{gtClass:GtPhlowListView}}.

"
Class {
	#name : #GtPhlowListItemElementWithContextMenuDecorator,
	#superclass : #BrListItemElementStencilBuilder,
	#instVars : [
		'stencilBuilder',
		'contextMenuStencil',
		'contextMenuItemsStencil'
	],
	#category : #'GToolkit-Phlow-Support - List utilities'
}

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator class >> stencilProperties [
	^ #(contextMenuStencil stencilBuilder contextMenuItemsStencil)
]

{ #category : #private }
GtPhlowListItemElementWithContextMenuDecorator >> buildContextMenuAptitudeFor: anElement [
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

						anItemType := aListElement viewModel itemTypeStencil
								itemPosition: anItemPosition;
								itemObject: anItemObject;
								build.

						contextMenuStencil
							itemType: anItemType;
							itemObject: anItemObject;
							itemPosition: anItemPosition;
							itemElement: anElement;
							build ];
					noneBlock: [ BlElement new ];
					find ].

	anElement addAptitude: aContextMenuAptitude.
]

{ #category : #private }
GtPhlowListItemElementWithContextMenuDecorator >> buildContextMenuItemsAptitudeFor: anElement [
	| aMenuAptitude |
	aMenuAptitude := BrWithExplicitContextMenuAptitude menu: [ 
				GtPhlowListAndListItemParentFinder new
					element: anElement;
					listKindOfClass: self listOfKindClass;
					foundBlock: [ :aListElement :aListItemElement | 
						| anItemHolder anItemPosition anItemObject anItemType |
						
						anItemHolder := aListItemElement constraints infinite holder.
						anItemPosition := anItemHolder dataSourcePosition.
						anItemObject := aListElement viewModel itemAt: anItemPosition.
						
						anItemType := aListElement viewModel itemTypeStencil
							itemPosition: anItemPosition;
							itemObject: anItemObject;
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
							allParentsDetect: [ :eachParent | eachParent phlow isViewContent ]
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
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuItemsStencil [
	<return: #GtPhlowListContextMenuItemsStencilBuilder or: nil>

	^ contextMenuItemsStencil
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuItemsStencil: aGtPhlowListContextMenuItemsStencilBuilder [
	"Set a stencil builder that creates a `BrMenu` subclass instance,
	representing a context menu, e.g., `BrMenuItems` object"
	
	contextMenuItemsStencil := aGtPhlowListContextMenuItemsStencilBuilder asStencilBuilder: GtPhlowListContextMenuItemsStencilBuilder
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuStencil [
	<return: #GtPhlowListContextMenuStencilBuilder>

	^ contextMenuStencil
]

{ #category : #accessing }
GtPhlowListItemElementWithContextMenuDecorator >> contextMenuStencil: aGtPhlowListContextMenuStencilBuilder [
	"Set a stencil builder that creates a `BlElement` instance,
	representing a context menu, e.g., simple list element.
	
	This solution is deprecated.
	Use #contextMenuItemsStencil: instead."

	contextMenuStencil := aGtPhlowListContextMenuStencilBuilder
			asStencilBuilder: GtPhlowListContextMenuStencilBuilder
]

{ #category : #private }
GtPhlowListItemElementWithContextMenuDecorator >> listOfKindClass [
	^ BrList
]

{ #category : #'api - instantiation' }
GtPhlowListItemElementWithContextMenuDecorator >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: stencilBuilder;
		push: contextMenuStencil;
		push: contextMenuItemsStencil
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
